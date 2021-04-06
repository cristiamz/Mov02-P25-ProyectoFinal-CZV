//
//  SessionViewModel.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import Foundation

class SessionViewModel: ObservableObject {
    @Published var logged = false
    
    func isLogged()->Bool{
        return logged
    }
}
