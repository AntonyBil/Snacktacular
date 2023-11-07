//
//  Spot.swift
//  Snacktacular
//
//  Created by apple on 07.11.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Spot: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var address = ""
    
    var dictionary: [String: Any] {
        return ["name": name, "address": address]
    }
}
