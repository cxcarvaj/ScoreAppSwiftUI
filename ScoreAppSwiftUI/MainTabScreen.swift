//
//  MainTabScreen.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI


enum Tabs {
    case scores
    case favorites
}

struct MainTabScreen: View {
    @State private var selectedTab: Tabs = .scores

    var body: some View {
        TabView(selection: $selectedTab) {
            
//            Para versiones menores a iOS 18
//            ContentView().tabItem {
//                Label("Scores", systemImage: "music.note")
//            }
//
//            FavoritesView().tabItem {
//                Label("Favorites", systemImage: "star")
//            }
            
//            //iOS 18
            Tab("Scores", systemImage: "music.note", value: Tabs.scores) {
                ContentView()
            }

            Tab("Favorites", systemImage: "star", value: Tabs.favorites) {
                FavoritesView()
            }
        }
    }
}

#Preview {
    MainTabScreen.preview
}
