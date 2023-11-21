//
//  SpotViewModel.swift
//  Snacktacular
//
//  Created by apple on 07.11.2023.
//

import Foundation
import FirebaseFirestore

class SpotViewModel: ObservableObject {
    @Published var spot = Spot()
    
    func saveSpot(spot:Spot) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = spot.id { //spot must already exist
            do {
                try await db.collection("spots").document(id).setData(spot.dictionary)
                print("✅ Data updated successfuly!")
                return true
            } catch {
                print("🚫 ERROR: Could not update data in 'spot' \(error.localizedDescription)")
                return false
            }
        } else {    //no id. Then this must be a new spot to add
            do {
                _ = try await db.collection("spots").addDocument(data: spot.dictionary)
                print("✅ Data added successfuly!")
                return true
            } catch {
                print("🚫 ERROR: Could not create a new spot in 'spots' \(error.localizedDescription)")
                return false
                
            }
        }
    }
}
