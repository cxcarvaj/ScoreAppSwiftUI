//
//  ContentView.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var vm: ScoresVM
    
    var body: some View {
        NavigationStack {
            List {
                if !vm.scoresByComposerIsEmpty {
                    ForEach(vm.scoresByComposers, id: \.self) { scores in
                        if scores.count > 0 {
                            Section {
                                ForEach(scores) { score in
                                    NavigationLink(value: score) {
                                        ScoresCell(score: score,
                                                   deleteAction: vm.deleteScoreRow,
                                                   favoritedAction: vm.toggleFavorite)
                                    }
                                }
                                //onDelete y onMove solo salen en el ForEach
//                                .onDelete(perform: vm.deleteScores)
//                                .onMove(perform: vm.moveScores)
                            } header: {
                                Text(scores.first?.composer ?? "")
                            }
                        }
                    }
                } else {
                    ContentUnavailableView("No score found",
                                           systemImage: "music.note",
                                           description: Text("There is no scores within the search you type. Try another search.")
                    )
                }
            }
            .navigationTitle("Scores")
            .navigationDestination(for: Score.self, destination: editScore)
            .searchable(text: $vm.searchText, prompt: "Search a score")
            .sortedByButton(orderBy: $vm.orderBy)
        }
    }
}

#Preview {
    ContentView.preview
}
