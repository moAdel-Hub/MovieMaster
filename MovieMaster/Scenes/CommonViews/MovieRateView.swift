//
//  MovieRateView.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 29/10/2024.
//

import SwiftUI

struct MovieRateView: View {
    let rate: Double
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            
            Text("\(rate, specifier: "%.1f")/10 IMDB")
                .font(.subheadline)
                .fontWeight(.ultraLight)
            
        }
    }
}
