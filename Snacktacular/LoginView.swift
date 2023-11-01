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
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Group {
                    TextField("E-mail", text: $email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .submitLabel(.next)
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                }
                .textFieldStyle(.roundedBorder)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.gray.opacity(0.5), lineWidth: 2)
                }
                .padding(.horizontal)
                
                HStack {
                    Button {
                        register()
                    } label: {
                        Text("Sing Up")
                    }
                    .padding(.trailing)
                    
                    
                    Button {
                        login()
                    } label: {
                        Text("Log In")
                    }
                    .padding(.leading)

                }
                .buttonStyle(.borderedProminent)
                .tint(Color("SnackColor"))
                .font(.title2)
                .padding(.top)
                .navigationBarTitleDisplayMode(.inline)
            }
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) {}
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error { //login error ocured
                print("Registration Error: \(error.localizedDescription)")
                alertMessage = "Login Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Registration success!")
                //TODO: loadListView
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error { //login error ocured
                print("Login Error: \(error.localizedDescription)")
                alertMessage = "Login Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Login success!")
                //TODO: loadListView
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
