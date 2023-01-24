//
//  CoreDataManager.swift
//  RawGameApp
//
//  Created by kamilcal on 20.01.2023.
//

import UIKit
import CoreData

class CoreDataManager {
    

    
      static let shared = CoreDataManager()

      private let managedContext: NSManagedObjectContext!
      
      private init() {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          managedContext = appDelegate.persistentContainer.viewContext
      }
    
//    MARK: - GAME
    
    func getFavoritesData(completion: @escaping(Result<[GameFavoriteModel], Error>) -> Void) {
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try self.managedContext.fetch(fetchRequest)
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
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try self.managedContext.fetch(fetchRequest).first {
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
        managedContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext) {
                let game = NSManagedObject(entity: entity, insertInto: managedContext)
                game.setValue(gameData.id, forKey: "id")
                game.setValue(gameData.name, forKey: "name")
                game.setValue(gameData.backgroundImage, forKey: "backgroundImage")
                game.setValue(gameData.released, forKey: "released")
                game.setValue(gameData.gameDetailModelDescription, forKey: "gameDetailModelDescription")
                game.setValue(gameData.reviewsCount, forKey: "reviewsCount")
                do {
                    try managedContext.save()
                    completion()
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    func isFavoritedGame(_ id: Int,
                         completion: @escaping(_ isFavourite: Bool) -> Void) {
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if (try self.managedContext.fetch(fetchRequest).first) != nil {
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
        managedContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? self.managedContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
               batchDeleteResult.result != nil {
            }
        }
    }
    
//    MARK: - NOTE

    func saveNote(title: String, text: String) -> Note?{
            if let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext){
                let note = NSManagedObject(entity: entity, insertInto: managedContext)
                note.setValue(title, forKeyPath: "title")
                note.setValue(text, forKeyPath: "text")
                
                do {
                    try managedContext.save()
                    return note as? Note
                } catch let error as NSError {
                    print("Couldn't save. \(error), \(error.userInfo)")
                }
            }
        return nil
    }

    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
        return []
    }
    
    
    func deleteNote(note: Note) {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    func updateNote(note: Note) -> Note {
        note.setValue(note.text, forKey: "text")
        note.setValue(note.title, forKey: "text")
        if note.hasChanges {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Couldn't save. \(error), \(error.userInfo)")
            }
            return note
        }
        return note
        
    }

    }


