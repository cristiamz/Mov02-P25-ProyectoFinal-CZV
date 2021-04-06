//
//  SignUpView.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import SwiftUI
import Amplify
import SCLAlertView

struct SignUpView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            
            Text("Register").bold().font(.title)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))

            TextField("User name", text: $username)
                .padding()
                .background(Color("flash-white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                .disableAutocorrection(true)
                .autocapitalization(.none)
    
            SecureField("Password", text: $password) .padding().background(Color("flash-white"))
                    .cornerRadius(4.0)
                    .padding(.bottom, 10)
                .autocapitalization(.none)
            
           
            Button(action: signUp) {
                HStack(spacing: 15){
                    
                        Text("Sign Up")
                            .fontWeight(.heavy)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                
                    
                
                }
                
//                HStack(alignment: .center) {
//
//
//                    Spacer()
//                    Text("SignUp").foregroundColor(Color.white)
//                    Spacer()
//                }
                }.opacity(username != "" && password != "" ? 1 : 0.5)
            .disabled(username != "" && password != "" ? false: true )
            .cornerRadius(4.0)
            //.padding().background(Color.green).cornerRadius(4.0)
        }
    }
    
    func signUp() {
        let userAttributes = [AuthUserAttribute(.email, value: username)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { result in
            switch result {
            case .success(let signUpResult):
                
                switch signUpResult.nextStep {
                case .confirmUser(let details, let info):
                    print(details ?? "no details", info ?? "no additional info")
                    
                    DispatchQueue.main.async {
                     
                        let alert = SCLAlertView(
                        )
                        let txt = alert.addTextField("Enter confirm number")
                        alert.addButton("Confirm") {
                            confirmSignUp(emailCode: txt.text!)
                            print("Facilitar Codigo")
                        }
                        alert.showEdit("Verification Code", subTitle: "Enter the code received in your email", closeButtonTitle: "Cancel")
                    }
                    
                case .done:
                    print("Sign up complete")
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    SCLAlertView().showError("Error", subTitle: error.errorDescription) // Error

                }

            }
        }
    }
    
    func confirmSignUp(emailCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: emailCode) { result in
            
            switch result {
            
            case .success(let confirmSignUpResult):
                
                switch confirmSignUpResult.nextStep {
                case .confirmUser(let details, let info):
                    print(details ?? "no details", info ?? "no additional info")
                    
                    
                case .done:
                    print("\(username) confirmed their email")
                    username = ""
                    password = ""
                     DispatchQueue.main.async {
                        SCLAlertView().showInfo("Success", subTitle: "Email Confirmed")
                        withAnimation(.easeOut){}
                    }
                
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
