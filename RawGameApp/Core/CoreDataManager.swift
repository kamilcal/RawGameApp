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
     
     let persistentContainer: NSPersistentContainer = {
         
         let container = NSPersistentContainer(name: "MovieCoreData")
         container.loadPersistentStores { (storeDescription, error) in
             if let err = error {
                 fatalError("Loading of store failed: \(err)")
             }
         }
         return container
     }()
     
     
     func fetchFavouriteGames() -> [Favourite] {
         let context = persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
         do {
             let favouriteGames = try context.fetch(fetchRequest)
             return favouriteGames
         } catch let fetchErr {
             print("Failed to fetch favourite games: ", fetchErr)
             return []
         }
         
     }
     
     
     func saveFavouriteGames(added: Int, backgroundImage: String, gameDetailModelDescription: String, id: Int, name: String, released: String, reviewsCount: Int){
         let context = persistentContainer.viewContext
         let game = NSEntityDescription.insertNewObject(forEntityName: "Favourite", into: context) as! Favourite
         
         game.setValue(added, forKey: "added")
         game.setValue(backgroundImage, forKey: "backgroundImage")
         game.setValue(gameDetailModelDescription, forKey: "gameDetailModelDescription")
         game.setValue(id, forKey: "id")
         game.setValue(name, forKey: "name")
         game.setValue(released, forKey: "released")
         game.setValue(reviewsCount, forKey: "reviewsCount")
         do {
             try context.save()
         } catch let err {
             print("Failed to create favourite games: ", err)
         }
     }
     
     
     func isSavedGame(id: Int) -> [Favourite]{
         let context = persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
         fetchRequest.predicate = NSPredicate(format: "id == %i", id)
         do {
             let games = try context.fetch(fetchRequest)
             return games as! [Favourite]
         } catch let err {
             print("Failed to create is saved games: ", err)
         }
         return []
     }
     
     
     func deleteGame(game: Favourite){
         let context = persistentContainer.viewContext
         context.delete(game)
         do {
             try context.save()
         } catch _ as NSError {
         }
     }
     


   
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "RawGameApp")
//        container.loadPersistentStores { _, error in
//            guard error == nil else {
//                fatalError("\(String(describing: error?.localizedDescription) )")
//            }
//        }
//        container.viewContext.automaticallyMergesChangesFromParent = false
//        container.viewContext.undoManager = nil
//        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
//        container.viewContext.shouldDeleteInaccessibleFaults = true
//        return container
//    }()
//    private func context() -> NSManagedObjectContext {
//        let taskContext = persistentContainer.newBackgroundContext()
//        taskContext.undoManager = nil
//        taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
//        return taskContext
//    }
//    func getFavouritesData(completion: @escaping(Result<[GameFavoriteModel], Error>) -> Void) {
//        let taskContext = context()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
//            do {
//                let results = try taskContext.fetch(fetchRequest)
//                var games: [GameFavoriteModel] = []
//                for result in results {
//                    let gamesData = GameFavoriteModel(id: result.value(forKey: "id") as? Int,
//                                                      name: result.value(forKey: "name") as? String,
//                                                      gameDetailModelDescription: result.value(forKey: "gameDetailModelDescription") as? String,
//                                                      backgroundImage: result.value(forKey: "backgroundImage") as? String,
//                                                      added: result.value(forKey: "added") as? Int,
//                                                      released: result.value(forKey: "released") as? String,
//                                                      reviewsCount: result.value(forKey: "reviewsCount") as? Int)
//                    games.append(gamesData)
//                }
//                completion(.success(games))
//            } catch let error as NSError {
//                print("Couldn't fetch. \(error), \(error.userInfo)")
//            }
//        }
//    }
//    func getFavouriteGameDetail(_ id: Int, completion: @escaping(_ fav: GameFavoriteModel) -> Void) {
//        let taskContext = context()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
//            fetchRequest.fetchLimit = 1
//            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
//            do {
//                if let result = try taskContext.fetch(fetchRequest).first {
//                    let gameData = GameFavoriteModel(id: result.value(forKey: "id") as? Int,
//                                                     name: result.value(forKey: "name") as? String,
//                                                     gameDetailModelDescription: result.value(forKey: "gameDetailModelDescription") as? String,
//                                                     backgroundImage: result.value(forKey: "backgroundImage") as? String,
//                                                     added: result.value(forKey: "added") as? Int,
//                                                     released: result.value(forKey: "released") as? String,
//                                                     reviewsCount: result.value(forKey: "reviewsCount") as? Int)
//                    completion(gameData)
//                }
//            } catch let error as NSError {
//                print("Couldn't fetch. \(error), \(error.userInfo)")
//            }
//        }
//    }
//    func addFavouriteGame(gameData: GameFavoriteModel, completion: @escaping() -> Void) {
//        let taskContext = context()
//        taskContext.performAndWait {
//            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
//                let game = NSManagedObject(entity: entity, insertInto: taskContext)
//                game.setValue(gameData.id, forKey: "id")
//                game.setValue(gameData.name, forKey: "name")
//                game.setValue(gameData.backgroundImage, forKey: "backgroundImage")
//                game.setValue(gameData.released, forKey: "released")
//                game.setValue(gameData.gameDetailModelDescription, forKey: "gameDetailModelDescription")
//                game.setValue(gameData.reviewsCount, forKey: "reviewsCount")
//                do {
//                    try taskContext.save()
//                    completion()
//                } catch let error as NSError {
//                    print("Couldn't save. \(error), \(error.userInfo)")
//                }
//            }
//        }
//    }
//    func isFavoritedGame(_ id: Int,
//                         completion: @escaping(_ isFavourite: Bool) -> Void) {
//        let taskContext = context()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
//            fetchRequest.fetchLimit = 1
//            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
//            do {
//                if (try taskContext.fetch(fetchRequest).first) != nil {
//                    completion(true)
//                } else {
//                    completion(false)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//    func deleteFavouriteGame(_ id: Int, completion: @escaping() -> Void) {
//        let taskContext = context()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
//            fetchRequest.fetchLimit = 1
//            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
//            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            batchDeleteRequest.resultType = .resultTypeCount
//            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
//               batchDeleteResult.result != nil {
//                completion()
//            }
//        }
//    }
//}
//
