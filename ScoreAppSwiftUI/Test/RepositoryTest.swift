//
//  RepositoryTest.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import SwiftUI

struct RepositoryTest: DataRepository {
    var url: URL {
        Bundle.main.url(forResource: "scoresdatatest",
                        withExtension: "json")!
    }
    
    var urlDoc: URL {
        URL.documentsDirectory.appending(path: "scoresdatatest").appendingPathExtension(for: .json)
    }
    
    func getScores() throws -> [Score] {
        try load(url: url, type: [ScoreDTO].self).map(\.toScore).map {
            var score = $0
            score.favorited = Bool.random()
            return score
        }
    }
    
    func saveScores(_ scores: [Score]) throws {}
}

extension Score {
    static let test = Score(id: 1, title: "Star Wars", composer: "John Williams", year: 1977, length: 73, cover: "StarWars", tracks: ["Main Title", "Imperial Attack", "Princess Leia's Theme", "The Desert and the Robot Auction", "Ben's Death and TIE Fighter Attack", "The Little People Work", "Rescue of the Princess", "Inner City", "Cantina Band", "The Land of the Sand People", "Mouse Robot and Blasting Off", "The Return Home", "The Walls Converge", "The Princess Appears", "The Last Battle", "The Throne Room and End Title"], favorited: false)
}


extension ContentView {
    static var preview: some View {
        ContentView()
            .environmentObject(ScoresVM(repository: RepositoryTest()))
    }
}

extension FavoritesView {
    static var preview: some View {
        FavoritesView()
            .environmentObject(ScoresVM(repository: RepositoryTest()))
    }
}
