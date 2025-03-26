//
//  ViewScore.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI

struct ViewScore: View {
    let score: Score
    var body: some View {
        Form {
            Section {
                LabeledContent("Title", value: score.title)
                LabeledContent("Composer", value: score.composer)
                LabeledContent("Year", value: score.yearS)
                LabeledContent("Length", value: score.lengthS)
            } header: {
                Text("Score data")
            }
            
            Section {
                ForEach(score.tracks, id: \.self) { track in
                    Text(track)
                }
            } header: {
                Text("Tracks")
            }
        }
        .navigationTitle(score.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ViewScore(score: .test)
}
