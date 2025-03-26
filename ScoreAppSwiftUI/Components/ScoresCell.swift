//
//  ScoresCell.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

struct ScoresCell: View {
    let score: Score
    let deleteAction: (Score) -> Void
    let favoritedAction: (Score) -> Void
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(score.title)
                    .font(.headline)
                Text(score.composer)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Spacer()
                HStack {
                    Text(score.yearS)
                    Spacer()
                    Text(score.lengthS)
                }
                .font(.caption)
            }
            .padding(.vertical, 5)
            .frame(height: 100)
            Spacer()
            Image(score.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(.rect(cornerRadius: 10))
        }
        .swipeActions(edge: .trailing) {
            Button {
                showDeleteAlert.toggle()
            } label: {
                Label("Delete score", systemImage: "trash")
                    .tint(.red)
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                favoritedAction(score)
            } label: {
                Label(score.favorited ? "Unfavorite" : "Favorited",
                      systemImage: score.favorited ? "star" : "star.fill")
            }
            .tint(score.favorited ? .red : .blue)
        }
        .alert("Confirm score deletion",
               isPresented: $showDeleteAlert) {
            Button(role: .destructive) {
                deleteAction(score)
            } label: {
                Text("Delete")
            }
            Button(role: .cancel) {} label: {
                Text("Cancel")
            }
        } message: {
            Text("Do you really want to delete this score?")
        }
    }
}

#Preview {
    ScoresCell(score: .test) { _ in } favoritedAction: { _ in }
}
