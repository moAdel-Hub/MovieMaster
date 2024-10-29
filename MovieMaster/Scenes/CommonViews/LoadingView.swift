//
//  LoadingView.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 30/10/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
            ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(2)
    }
}


#Preview {
    LoadingView()
}
