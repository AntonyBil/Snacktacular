//
//  SpotDetailView.swift
//  Snacktacular
//
//  Created by apple on 07.11.2023.
//

import SwiftUI

struct SpotDetailView: View {
    
    @EnvironmentObject var spotVM: SpotViewModel
    @State var spot: Spot
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group {
                TextField("Name", text: $spot.name)
                    .font(.title)
                TextField("Address", text: $spot.address)
                    .font(.title2)
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(spot.id == nil)
        .toolbar {
            if spot.id == nil { //New spot, we show Cancel/Save buttons
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                          let succes = await spotVM.saveSpot(spot: spot)
                            if succes {
                                dismiss()
                            } else {
                                print("🚫 Eroor saving spot!")
                            }
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SpotDetailView(spot: Spot())
                .environmentObject(SpotViewModel())
        }
       
    }
}
