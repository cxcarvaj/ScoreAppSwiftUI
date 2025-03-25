//
//  RepositoryTest.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import UIKit

struct RepositoryTest: DataRepository {
    var url: URL {
        Bundle.main.url(forResource: "scoresdatatest",
                        withExtension: "json")!
    }
    
    var urlDoc: URL {
        URL.documentsDirectory.appending(path: "scoresdatatest").appendingPathExtension(for: .json)
    }
    
    func saveScores(_ scores: [Score]) throws {}
}

extension Score {
    static let test = Score(id: 1, title: "Star Wars", composer: "John Williams", year: 1977, length: 73, cover: "StarWars", tracks: ["Main Title", "Imperial Attack", "Princess Leia's Theme", "The Desert and the Robot Auction", "Ben's Death and TIE Fighter Attack", "The Little People Work", "Rescue of the Princess", "Inner City", "Cantina Band", "The Land of the Sand People", "Mouse Robot and Blasting Off", "The Return Home", "The Walls Converge", "The Princess Appears", "The Last Battle", "The Throne Room and End Title"], favorited: false)
}


extension ContentView {
    static let preview = ContentView(vm: ScoresVM(repository: RepositoryTest()))
}
