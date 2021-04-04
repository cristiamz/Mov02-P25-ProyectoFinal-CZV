//
//  SignUpView.swift
//  ProyectoFinal
//
//  Created by Cristian Zuniga on 4/4/21.
//

import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            
            Text("Register").bold().font(.title)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))

            TextField("Username", text: $username)
                .padding()
                .background(Color("flash-white"))
                .cornerRadius(4.0)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                .autocapitalization(.none)
    
            SecureField("Password", text: $password) .padding().background(Color("flash-white"))
                    .cornerRadius(4.0)
                    .padding(.bottom, 10)
                .autocapitalization(.none)
            
           
            Button(action: signUp) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("SignUp").foregroundColor(Color.white)
                    Spacer()
                }
                }.padding().background(Color.green).cornerRadius(4.0)
        }
    }
    
    func signUp() {
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
