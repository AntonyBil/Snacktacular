//
//  LoginView.swift
//  Snacktacular
//
//  Created by apple on 31.10.2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Group {
                    TextField("E-mail", text: $email)
                    SecureField("Password", text: $password)
                }
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: 2)
                }
                .padding(.horizontal)
                
                HStack {
                    Button {
                        //
                    } label: {
                        Text("Sing Up")
                    }
                    .padding(.trailing)
                    
                    
                    Button {
                        //
                    } label: {
                        Text("Log In")
                    }
                    .padding(.leading)

                }
                .buttonStyle(.borderedProminent)
                .tint(Color("SnackColor"))
                .font(.title2)
                .padding(.top)
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
