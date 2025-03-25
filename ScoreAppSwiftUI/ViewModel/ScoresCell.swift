//
//  ScoresCell.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

struct ScoresCell: View {
    let score: Score
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(score.title)
                    .font(.headline)
                Text(score.composer)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                HStack {
                    Text(score.yearS)
                    Text(score.lengthS)
                }
                .font(.caption)
                .padding(.top, 5)
            }
            Spacer()
            Image(score.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(.rect(cornerRadius: 10))
        }
    }
}

#Preview {
    ScoresCell(score: .test)
}
