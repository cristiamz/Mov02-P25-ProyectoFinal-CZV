//
//  ProyectoFinalApp.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct ProyectoFinalApp: App {
    init(){
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            FeedView()
        }
    }
    
    private func configureAmplify(){
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            
            print("Amplify configured with auth plugin")
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
    }
    
}
