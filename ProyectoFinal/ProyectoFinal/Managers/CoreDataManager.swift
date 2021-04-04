//
//  CoreDataManager.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import Foundation
import CoreData

class CoreDataManager{
    
    let persistentContainer: NSPersistentContainer
    
    init(){
        // Which files should the container use.
        persistentContainer = NSPersistentContainer(name: "CenfotecGram")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                print("Unable to load Core Data Store \(error)")
            }
        }
    }
    
    func register(userName: String, pass: String){
        let user = UserEntity(context: persistentContainer.viewContext)
        user.userName = userName
        user.password = pass
  
        if (try? persistentContainer.viewContext.save()) != nil{
            print("Success to save")
        }else{
            print("Failed to save")
        }
    }
    
    func auth(userName: String, pass: String) -> [UserEntity]{
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        //fetchRequest.predicate =  NSPredicate(format: "userName == %@ && password == %@", userName, pass)
        fetchRequest.predicate =  NSPredicate(format: "userName == %@", userName)
        
        if let result = try? persistentContainer.viewContext.fetch(fetchRequest){
            return result
        }
        return []
    }
    
}
