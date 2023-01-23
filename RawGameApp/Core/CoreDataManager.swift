//
//  CoreDataManager.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import UIKit
import CoreData

class CoreDataManager {
    

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RawGameApp")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("\(String(describing: error?.localizedDescription) )")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.undoManager = nil
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        return container
    }()
    private func context() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return taskContext
    }
    
//    MARK: - GAME
    
    func getFavoritesData(completion: @escaping(Result<[GameFavoriteModel], Error>) -> Void) {
        let taskContext = context()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameFavoriteModel] = []
                for result in results {
                    let gamesData = GameFavoriteModel(id: result.value(forKey: "id") as? Int,
                                                      name: result.value(forKey: "name") as? String,
                                                      gameDetailModelDescription: result.value(forKey: "gameDetailModelDescription") as? String,
                                                      backgroundImage: result.value(forKey: "backgroundImage") as? String,
                                                      added: result.value(forKey: "added") as? Int,
                                                      released: result.value(forKey: "released") as? String,
                                                      reviewsCount: result.value(forKey: "reviewsCount") as? Int)
                    games.append(gamesData)
                }
                completion(.success(games))
            } catch let error as NSError {
                print("Couldn't fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func getFavoriteGameDetail(_ id: Int, completion: @escaping(_ fav: GameFavoriteModel) -> Void) {
        let taskContext = context()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let gameData = GameFavoriteModel(id: result.value(forKey: "id") as? Int,
                                                     name: result.value(forKey: "name") as? String,
                                                     gameDetailModelDescription: result.value(forKey: "gameDetailModelDescription") as? String,
                                                     backgroundImage: result.value(forKey: "backgroundImage") as? String,
                                                     added: result.value(forKey: "added") as? Int,
                                                     released: result.value(forKey: "released") as? String,
                                                     reviewsCount: result.value(forKey: "reviewsCount") as? Int)
                    completion(gameData)
                }
            } catch let error as NSError {
                print("Couldn't fetch. \(error), \(error.userInfo)")
            }
        }
    }
    func addFavoriteGame(gameData: GameFavoriteModel, completion: @escaping() -> Void) {
        let taskContext = context()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(gameData.id, forKey: "id")
                game.setValue(gameData.name, forKey: "name")
                game.setValue(gameData.backgroundImage, forKey: "backgroundImage")
                game.setValue(gameData.released, forKey: "released")
                game.setValue(gameData.gameDetailModelDescription, forKey: "gameDetailModelDescription")
                game.setValue(gameData.reviewsCount, forKey: "reviewsCount")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    func isFavoritedGame(_ id: Int,
                         completion: @escaping(_ isFavourite: Bool) -> Void) {
        let taskContext = context()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if (try taskContext.fetch(fetchRequest).first) != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func deleteFavoriteGame(_ id: Int) {
        let taskContext = context()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
               batchDeleteResult.result != nil {
            }
        }
    }
    
//    MARK: - NOTE

    func saveNote(title: String, text: String) -> Note?{
        let taskContext = context()
            if let entity = NSEntityDescription.entity(forEntityName: "Note", in: taskContext){
                let note = NSManagedObject(entity: entity, insertInto: taskContext)
                note.setValue(title, forKeyPath: "title")
                note.setValue(text, forKeyPath: "text")
                
                do {
                    try taskContext.save()
                    return note as? Note
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")   
                }
            }
        return nil
    }

    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        let taskContext = context()
        do {
            let notes = try taskContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
        return []
    }
    
    
    func deleteNote(note: Note) {
        let taskContext = context()
        taskContext.delete(note)
        
        do {
            try taskContext.save()
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    func updateNote(note: Note) -> Note {
        let taskContext = context()
        note.setValue(note.text, forKey: "text")
        note.setValue(note.title, forKey: "text")
        if note.hasChanges {
            do {
                try taskContext.save()
            } catch let error as NSError {
                print("Couldn't save. \(error), \(error.userInfo)")
            }
            return note
        }
        return note
        
    }
}

