//
//  LoginView.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import SwiftUI
import LocalAuthentication
import Amplify
import SCLAlertView

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @EnvironmentObject var sessionVM: SessionViewModel
    //@Environment(\.presentationMode) var presentationMode
    //@ObservedObject var coreDataVM = CoreDataViewModel()
    
    
    var body: some View {
        VStack {
            Text("Cenfotec-gram")
                .font(.title)
                .foregroundColor(Color.black)

            HStack{
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(width: 35)
                TextField("EMAIL", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            }
            .padding()
            .background(Color.white.opacity(username == "" ? 0 : 0.12))
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
                .opacity(username != "" && password != "" ? 1 : 0.5)
                .disabled(username != "" && password != "" ? false: true )
                
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
            
            NavigationLink(destination:  SignUpView()) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Or click here to Sign Up").font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/).fontWeight(.black)
                    Spacer()
                }
            }.padding()
            
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
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(username)"){(status, error) in
            if error != nil{
                print("Error")
                print(error!.localizedDescription)
                return
            }
            withAnimation(.easeOut){self.sessionVM.logged = true}
        }
    }

    func authenticateUserPassword(){
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            
            case .success:
                print("\(username) signed in")
                DispatchQueue.main.async {
                    withAnimation(.easeOut){self.sessionVM.logged = true}
                    print("Login In")
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    SCLAlertView().showError("Error", subTitle: error.errorDescription) // Error

                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
