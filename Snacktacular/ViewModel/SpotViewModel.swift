//
//  SpotViewModel.swift
//  Snacktacular
//
//  Created by apple on 07.11.2023.
//

import Foundation
import FirebaseFirestore
import UIKit
import FirebaseStorage

    //@MainActor

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
                let documentRef = try await db.collection("spots").addDocument(data: spot.dictionary)
                self.spot = spot
                self.spot.id = documentRef.documentID
                print("✅ Data added successfuly!")
                return true
            } catch {
                print("🚫 ERROR: Could not create a new spot in 'spots' \(error.localizedDescription)")
                return false
                
            }
        }
    }
    
    func saveImage(spot: Spot, photo: Photo, image: UIImage) async -> Bool {
        guard let spotID = spot.id else {
            print("EROOR: spot.id == nil")
            return false
        }
        
        var photoName = UUID().uuidString  //This will be the name of the image file
        if photo.id != nil {
            photoName = photo.id! // I have a photo.id, so use this as the photoname.This happens if we're updating an existing Photo's descriptive info.
        }
        let storage = Storage.storage()     //Create a Firebase Storage instance
        let storageRef = storage.reference().child("\(spotID)/\(photoName).jpeg")
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("ERROR: Could not resize image")
            return false
        }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg" // Seting metadata allows you ti see console image in the browser. This seting will work for png as well as jpeg
        
        var imageURLString = "" //We'll set this after the image is successfully saved
        
        do {
            let _ = try await storageRef.putDataAsync(resizedImage, metadata: metadata)
            print("Image Saved!")
            do {
                let imageURL = try await storageRef.downloadURL()
                imageURLString = "\(imageURL)" // We'll save this to Cloud Firestore as part of document in 'photos' colection, below
            } catch {
                print("Error: Could not get imageURL after saving image \(error.localizedDescription)")
                return false
            }
            
        } catch {
            print("Error: uploading image to FirebaseStorage")
            return false
        }
        
        //Now save the "photos collection of the spot document "spotID"
        let db = Firestore.firestore()
        let collectionString = "spots/\(spotID)/photos"
        
        do {
            var newPhoto = photo
            newPhoto.imageURLString = imageURLString
            try await db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("Data updated successfully")
            return true
        } catch {
            print("Error:Could not update data in 'photos' for spotId \(spotID)")
            return false
        }
    }
}




















