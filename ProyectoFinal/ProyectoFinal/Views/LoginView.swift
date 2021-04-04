//
//  LoginView.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @State var userName = ""
    @State var password = ""
    @AppStorage("status") var logged = false
    
    //@Environment(\.presentationMode) var presentationMode
    @ObservedObject var coreDataVM = CoreDataViewModel()
    
    
    var body: some View {
        VStack {
            Text("Cenfotec-gram")
                .font(.title)
                .foregroundColor(Color.black)
            Text("Login")
                .font(.headline)
                .padding(.vertical, 2.0)
            
            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 35)
                TextField("EMAIL", text: $userName)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack{
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 35)
                SecureField("PASSWORD", text: $password)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            
            HStack(spacing: 15){
                Button(action: authenticateUserPassword, label:{
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                })
                .opacity(userName != "" && password != "" ? 1 : 0.5)
                .disabled(userName != "" && password != "" ? false: true )
                
                if getBiometricStatus(){
                    Button(
                        action: authenticateUser,
                        label:{
                            Image (systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    )
                }
            }
        }
    }
    func getBiometricStatus()->Bool{
        let scanner = LAContext()
        // Biometry is available on the device
        if  scanner.canEvaluatePolicy(.deviceOwnerAuthentication, error: .none){
            return true
        }
        return false
    }

    func authenticateUser(){
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(userName)"){(status, error) in
            if error != nil{
                print("Error")
                print(error!.localizedDescription)
                return
            }
            withAnimation(.easeOut){logged = true}
        }
    }

    func authenticateUserPassword(){
        if self.coreDataVM.auth(userName: userName, pass: password){
            withAnimation(.easeOut){logged = true}
        }else{
            print("User Password Does not match")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
