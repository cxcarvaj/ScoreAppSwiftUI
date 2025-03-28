//
//  ViewBuilders.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI

extension View {
    func editScore(score: Score) -> some View {
        EditScoreView(editScoreVM: EditScoreVM(score: score))
    }
    
    func viewScore(score: Score) -> some View {
        ViewScore(score: score)
    }
}
