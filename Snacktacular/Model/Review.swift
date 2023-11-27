//
//  Review.swift
//  Snacktacular
//
//  Created by apple on 16.11.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Review: Identifiable, Codable {
    @DocumentID var id: String?
    var title = ""
    var body = ""
    var rating = 0
    var reviwer = Auth.auth().currentUser?.email ?? ""
    var postedOn = Date()
    
    var dictionary: [String: Any] {
        return ["title": title, "body": body, "rating": rating, "reviwer" : reviwer, "postedOn": Timestamp(date: Date())]
    }
    
}
