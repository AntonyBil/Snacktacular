//
//  ListView.swift
//  Snacktacular
//
//  Created by apple on 06.11.2023.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ListView: View {
    @FirestoreQuery(collectionPath: "spots") var spots: [Spot]
    @State private var sheetIsPresenting = false
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List(spots) { spot in
                NavigationLink {
                    SpotDetailView(spot: spot)
                } label: {
                    Text(spot.name)
                        .font(.title2)
                }

            }
            .listStyle(.plain)
            .navigationTitle("Snack Spots")
            .navigationBarTitleDisplayMode(.inline)
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
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView()
        }
    }
}
