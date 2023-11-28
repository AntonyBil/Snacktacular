//
//  ReviewViewModel.swift
//  Snacktacular
//
//  Created by apple on 21.11.2023.
//

import Foundation
import FirebaseFirestore

class ReviewViewModel: ObservableObject {
    @Published var review = Review()
    
    func saveReview(spot: Spot, review: Review) async -> Bool {
        let db = Firestore.firestore()
        
        guard let spotID = spot.id else {
            print("ERROR: spot.id = nil")
            return false
        }
        
        let collectionString = "spots/\(spotID)/reviews"
        
        
        if let id = review.id { //review must already exist
            do {
                try await db.collection(collectionString).document(id).setData(review.dictionary)
                print("✅ Data updated successfuly!")
                return true
            } catch {
                print("🚫 ERROR: Could not update data in 'reviews' \(error.localizedDescription)")
                return false
            }
        } else {    //no id. Then this must be a new review to add
            do {
                _ = try await db.collection(collectionString).addDocument(data: review.dictionary)
                print("✅ Data added successfuly!")
                return true
            } catch {
                print("🚫 ERROR: Could not create a new review in 'reviews' \(error.localizedDescription)")
                return false
                
            }
        }
    }
    
    func deleteReview (spot: Spot, review: Review) async -> Bool {
        let db = Firestore.firestore()
        
        guard let spotID = spot.id, let reviewID = review.id else {
            print("ERROR: spot.id = \(spot.id ?? ""), review.id = \(review.id ?? ""). This should not have happened.")
            return false
        }
        
        do {
            let _ = try await db.collection("spots").document(spotID).collection("reviews").document(reviewID).delete()
            print("Document cuccessfully deleted!")
            return true
        } catch {
            print("Error: removing document \(error.localizedDescription)")
            return false
        }
    }
}
