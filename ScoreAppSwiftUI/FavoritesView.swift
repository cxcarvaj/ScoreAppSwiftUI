//
//  FavoritesView.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var vm: ScoresVM

    let columns: [GridItem] = [GridItem(.adaptive(minimum: 125))]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.favorites) { favoriteScore in
                        NavigationLink(value: favoriteScore) {
                            Image(favoriteScore.cover)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .contextMenu {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            vm.toggleFavorite(score: favoriteScore)
                                        }
                                    } label: {
                                        Label("Unfavorite", systemImage: "star.slash")
                                    }
                                }
                        }
                    }
                }
            }
            .safeAreaPadding()
            .navigationTitle("Favorites")
            .navigationDestination(for: Score.self, destination: viewScore)
        }
    }
}

#Preview {
    FavoritesView.preview
}
