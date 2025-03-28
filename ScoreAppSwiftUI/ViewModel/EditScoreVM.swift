//
//  EditScoreVM.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI

final class EditScoreVM: ObservableObject {
    @Published var title = ""
    @Published var composer = ""
    @Published var year = 0
    @Published var length = 0.0
    @Published var tracks: [String] = []
    
    let score: Score
    
    init(score: Score) {
        self.score = score
        initValues()
    }
    
    func initValues() {
        title = score.title
        composer = score.composer
        year = score.year
        length = score.length
        tracks = score.tracks
    }
    
    func isValueEmpty(_ value: String) -> String? {
        value.isEmpty ? " is required" : nil
    }
    
    func validateYear(_ year: Int) -> String? {
        year < 1900 || year > 2050 ? " must be between 1900 and 2050" : nil
    }
}
