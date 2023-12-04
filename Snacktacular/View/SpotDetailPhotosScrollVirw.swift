//
//  SpotDetailPhotosScrollVirw.swift
//  Snacktacular
//
//  Created by apple on 01.12.2023.
//

import SwiftUI

struct SpotDetailPhotosScrollVirw: View {
    struct FakePhoto: Identifiable {
        let id = UUID().uuidString
        var imageURLString = "https://firebasestorage.googleapis.com:443/v0/b/snacktacular-adc33.appspot.com/o/OKcHiPvESJLGGYxCMgeB%2F1769EF31-2991-4C0D-8AA7-53A6293E3E3D.jpeg?alt=media&token=76f4cc20-52af-4a82-88a8-953fce139ae3"
    }
    
 //   let photos = [FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto(), FakePhoto()]
    @State private var showPhotoVivwerView = false
    @State private var uiImage = UIImage()
    let photos: [Photo]
    var spot: Spot
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(spacing: 4) {
                ForEach(photos) { photo in
                    let imageURL = URL(string: photo.imageURLString) ?? URL(string: "")
                    
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                        // Order is important here!
                            .frame(width: 80, height: 80)
                            .scaledToFit()
                            .clipped()
                            .onTapGesture {
                                let renderer = ImageRenderer(content: image)
                                uiImage = renderer.uiImage ?? UIImage()
                                showPhotoVivwerView.toggle()
                            }
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }

                }
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 4)
        .sheet(isPresented: $showPhotoVivwerView) {
            PhotoView(uiImage: uiImage, spot: spot)
        }
    }
}

struct SpotDetailPhotosScrollVirw_Previews: PreviewProvider {
    static var previews: some View {
        SpotDetailPhotosScrollVirw(photos: [Photo(imageURLString: "https://firebasestorage.googleapis.com:443/v0/b/snacktacular-adc33.appspot.com/o/OKcHiPvESJLGGYxCMgeB%2F1769EF31-2991-4C0D-8AA7-53A6293E3E3D.jpeg?alt=media&token=76f4cc20-52af-4a82-88a8-953fce139ae3")], spot: Spot(id: "OKcHiPvESJLGGYxCMgeB"))
    }
}
