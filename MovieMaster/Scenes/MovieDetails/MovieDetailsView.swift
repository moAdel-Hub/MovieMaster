//
//  MovieDetailsView.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 26/10/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    var body: some View {
        ScrollView {
            if viewModel.movieDetails != nil {
                VStack {
                    WebImage(url: URL(string: APIConstant.imageBaseURL + (viewModel.movieDetails?.backdrop ?? ""))) { image in
                        image.resizable()
                    } placeholder: {
                        Image(.imagePlaceholder)
                    }
                    .transition(.fade(duration: 0.9))
                    .scaledToFit()
                    .frame(height: 230, alignment: .leading)
                    .cornerRadius(9.0)
                    
                    Text(viewModel.movieDetails?.title ?? "")
                        .font(.headline)
                        .bold()
                    
                    Text("\(viewModel.movieDetails?.tagline ?? "")")
                    
                    Spacer()
                    
                    Text("Release date: " + (viewModel.movieDetails?.releaseDate ?? ""))
                    Text(viewModel.movieDetails?.overview ?? "")
                        .padding()
                }
            }
            else if viewModel.showAlert {
                VStack(alignment: .center){
                    Spacer()
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                        .padding()
                    
                    Text(AppStrings.ErrorDestination.noInternet)
                }
                .padding()
                
            }
        }
        .navigationTitle(viewModel.movieDetails?.title ?? "")
        .onAppear {
            viewModel.fetchMovieDetails()
        }
        .alert("", isPresented: $viewModel.showAlert, presenting: viewModel.userError) { _ in
            Button("Ok") {
                viewModel.resetError()
            }
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}
                         

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 000))
}
