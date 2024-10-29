//
//  MovieCardView.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 29/10/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        HStack() {
            
            WebImage(url: URL(string: APIConstant.imageBaseURL + (movie.posterPath ?? ""))) { image in
                image.resizable()
            } placeholder: {
                Image(.imagePlaceholder)
            }
            .transition(.fade(duration: 0.9))
            .scaledToFit()
            .frame(width: 150, height: 230, alignment: .leading)
            .cornerRadius(9.0)
            
            Spacer()
            VStack(alignment: .leading) {
            
                Text(movie.title ?? "")
                    .frame(maxWidth: 200,alignment: .leading)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
                
                
                MovieRateView(rate: movie.rating)
                
                Spacer()
            }
            
            
        }
        .frame(height: 210)
    }
}
