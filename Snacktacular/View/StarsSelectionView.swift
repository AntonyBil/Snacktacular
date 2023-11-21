//
//  StarsSelectionView.swift
//  Snacktacular
//
//  Created by apple on 16.11.2023.
//

import SwiftUI

struct StarsSelectionView: View {
    
    @Binding var rating: Int // change this to @Binding after layout is tested
    let highestRating = 5
    let unselected = Image(systemName: "star")
    let selected = Image(systemName: "star.fill")
    let font: Font = .largeTitle
    let fillCollor: Color = .red
    let emptyCollor: Color = .gray
    
    var body: some View {
        HStack {
            ForEach(1...highestRating, id: \.self) { number in
                showStar(for: number)
                    .foregroundColor(number <= rating ? fillCollor : emptyCollor)
                    .onTapGesture {
                        rating = number
                    }
            }
            .font(font)
        }
    }
    
    func showStar( for number: Int) -> Image {
        if number > rating {
            return unselected
        } else {
            return selected
        }
    }
}

struct StarsSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StarsSelectionView(rating: .constant(4))
    }
}
