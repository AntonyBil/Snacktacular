//
//  PhotoView.swift
//  Snacktacular
//
//  Created by apple on 30.11.2023.
//

import SwiftUI
import Firebase

struct PhotoView: View {
    @EnvironmentObject var spotVM: SpotViewModel
    @Binding var photo: Photo
    var uiImage: UIImage
    var spot: Spot
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
    
        NavigationStack {
            VStack {
                Spacer()
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                TextField("Description", text: $photo.description)
                    .textFieldStyle(.roundedBorder)
                
                Text("by: \(photo.reviwer) on: \(photo.postedOn.formatted(date: .numeric, time: .omitted))")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .disabled(Auth.auth().currentUser?.email != photo.reviwer)
            }
            .padding()
            .toolbar {
                if Auth.auth().currentUser?.email == photo.reviwer {
                    //Image wase posted by current user
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .automatic) {
                        Button("Save") {
                            Task {
                                let success = await spotVM.saveImage(spot: spot, photo: photo, image: uiImage)
                                if success {
                                    dismiss()
                                }
                            }
                        }
                    }
                } else {
                    // Image was NOT posted by current user
                    ToolbarItem(placement: .automatic) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: .constant(Photo()), uiImage: UIImage(named: "burrito") ?? UIImage(), spot: Spot())
            .environmentObject(SpotViewModel())
    }
}
