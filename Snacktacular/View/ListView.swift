//
//  ListView.swift
//  Snacktacular
//
//  Created by apple on 06.11.2023.
//

import SwiftUI
import Firebase

struct ListView: View {
    @State private var sheetIsPresenting = false
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Text("List items will go here")
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Sign Out") {
                    do {
                        try Auth.auth().signOut()
                        print("Log out succesful!")
                        dismiss()
                    } catch {
                        print("ERROR: Could not sign out!")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    sheetIsPresenting.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
        .sheet(isPresented: $sheetIsPresenting) {
            NavigationStack {
                SpotDetailView(spot: Spot())
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView()
        }
    }
}
