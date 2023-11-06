//
//  LoginView.swift
//  Snacktacular
//
//  Created by apple on 31.10.2023.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    enum Field {
        case email, password
    }
    
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonsDisabled = true
    @State private var path = NavigationPath()
    @FocusState private var focusField: Field?
    
    
    var body: some View {
        NavigationStack(path: $path) {
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
                        .focused($focusField, equals: .email) ///this fild is bound to the .email case
                        .onSubmit {
                            focusField = .password
                        }
                        .onChange(of: email) { _ in
                             enableButtons()
                        }
                    SecureField("Password", text: $password)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .focused($focusField, equals: .password) ///this fild is bound to the .password case
                        .onSubmit {
                            focusField = nil // will dismiss the keyboard
                        }
                        .onChange(of: password) { _ in
                            enableButtons()
                        }
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
                .disabled(buttonsDisabled)
                .buttonStyle(.borderedProminent)
                .tint(Color("SnackColor"))
                .font(.title2)
                .padding(.top)
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: String.self) { view in
                    if view == "ListView" {
                        ListView()
                    }
                }
            }
            
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }
       
        .onAppear {
            //if logged in when app runs, navigate to the new screen & skip login screen
            if Auth.auth().currentUser != nil {
                print("Login Successful")
                path.append("ListView")
            }
        }
    }
    
    
    //TODO: use extension
    func enableButtons() {
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonsDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error { //login error ocured
                print("Registration Error: \(error.localizedDescription)")
                alertMessage = "Login Error: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("Registration success!")
                path.append("ListView")
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
                path.append("ListView")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
