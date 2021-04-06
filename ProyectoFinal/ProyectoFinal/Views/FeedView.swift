//
//  FeedView.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import SwiftUI
import Amplify

struct FeedView: View {
    @StateObject var sessionVM = SessionViewModel()
    
    var body: some View {
        NavigationView{
            if sessionVM.isLogged() {
                Text("Logged to the feed")
                .toolbar {
                    Button("Log Out") {
                        self.logOut()
                    }
                }
            }else{
                VStack{
                   LoginView()
                }.padding()
            }
        }
        .onAppear { self.fetchCurrentAuthSession() }
        .navigationBarTitle("Welcome")
        .environmentObject(self.sessionVM)
        
    }
    func fetchCurrentAuthSession() {
        Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
                
                if session.isSignedIn {
                    self.sessionVM.logged = true
                }
                
            case .failure(let error):
                print("Fetch session failed with error \(error)")
            }
        }
    }
    func logOut(){
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
                withAnimation(.easeOut){self.sessionVM.logged = false}
                //self.sessionVM.logged = false
            case .failure(let error):
                print("Sign out failed with error \(error)")
                self.sessionVM.logged = true
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
