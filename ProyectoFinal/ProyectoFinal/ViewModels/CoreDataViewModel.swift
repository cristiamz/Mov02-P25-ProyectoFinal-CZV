//
//  CoreDataViewModel.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import Foundation

class CoreDataViewModel: ObservableObject{
    @Published var coreDM = CoreDataManager()
    @Published var user: [UserEntity] = [UserEntity]()
   
    func register (userName: String, pass: String){
        self.coreDM.register (userName: userName, pass: pass)
    }
    
    func auth(userName: String, pass: String)->Bool{
       
        user = self.coreDM.auth (userName: userName, pass: pass)
        
        if user.count == 0
        {
            return false
        }
        
        if user[0].password != pass
        {
            return false
        }
        
        return true
        
    }
    
      
    
    
}
