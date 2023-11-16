//
//  ReviewView.swift
//  Snacktacular
//
//  Created by apple on 16.11.2023.
//

import SwiftUI

struct ReviewView: View {
    
    @State var spot: Spot
    @State var review: Review
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(spot.name)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                Text(spot.address)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Click to Rate:")
                .font(.title)
                .bold()
            
            HStack {
                ForEach(0...4, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .tint(.red)
                        .font(.largeTitle)
                }
            }
            .padding(.bottom)
            
            VStackLayout(alignment: .leading) {
                Text("Revirw Title:")
                    .bold()
                
                TextField("title", text: $review.title)
                    .textFieldStyle(.roundedBorder)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: 2)
                    }
                
                Text("Review")
                    .bold()
                
                TextField("review", text: $review.body, axis: .vertical)
                    .padding(.horizontal, 6)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .textFieldStyle(.roundedBorder)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.5), lineWidth: 2)
                    }

                
            }
            .padding(.horizontal)
            .font(.title2)
            
            Spacer()

        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancrl") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    //TODO:
                    dismiss()
                }
            }
        }
    }
}
    

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReviewView(spot: Spot(name: "Shake shack", address: "49 Boyleston St., Chestnut Hill, MA 02467"), review: Review())
        }
    }
}
