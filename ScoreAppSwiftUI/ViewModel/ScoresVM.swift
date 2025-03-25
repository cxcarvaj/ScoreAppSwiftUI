//
//  ScoresVM.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

final class ScoresVM: ObservableObject {
    
    private let repository: DataRepository
    
    @Published var scores: [Score] {
        didSet {
            try? repository.saveScores(scores)
        }
    }
    
    
    init(repository: DataRepository = Repository()) {
        self.repository = repository
        
        do {
            self.scores = try repository.getScores()
        } catch {
            self.scores = []
            print("error loading scores: \(error)")
        }
    }
    
    
}
