//
//  ContentView.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ScoresVM()
    
    var body: some View {
        NavigationStack {
            List(vm.scores) { score in
                ScoresCell(score: score)
            }
            .navigationTitle("Scores")
        }
    }
}

#Preview {
    ContentView.preview
}
