//
//  Photo.swift
//  Snacktacular
//
//  Created by apple on 29.11.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Photo:Identifiable, Codable {
    @DocumentID var id: String?
    var imageURLString = ""     //This will hold the URL for loding the image.
    var description = ""
    var reviwer = Auth.auth().currentUser?.email ?? ""
    var postedOn = Date()
    
    var dictionary: [String: Any] {
        return ["imageURLString": imageURLString, "description": description, "reviwer": reviwer, "postedOn": Timestamp(date: Date()) ]
    }
    
}
