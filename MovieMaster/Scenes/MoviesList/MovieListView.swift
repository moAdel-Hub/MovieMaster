//
//  MovieListView.swift
//  MovieMaster
//
//  Created by Mohamed Ali on 26/10/2024.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var viewModel = MoviesListViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                    List {
                        ForEach(viewModel.movies, id: \.self) { movie in
                            let movieDetailsViewModel = MovieDetailsViewModel(movieID: Int(movie.id))
                            NavigationLink(destination: MovieDetailsView(viewModel: movieDetailsViewModel)) {
                                MovieCardView(movie: movie)
                            }
                            
                        }
                        if viewModel.canLoadMore {
                            Text("loading More")
                                .task {
                                    self.viewModel.loadMore()
                                }
                        }
                    }
            }
            .navigationTitle("Latest Movies")
            .alert("", isPresented: $viewModel.showAlert, presenting: viewModel.userError) { _ in
                Button("Ok") {
                    viewModel.resetError()
                }
            } message: { error in
                Text(error.localizedDescription)
            }
        }
    }
}

#Preview {
    MovieListView()
}
