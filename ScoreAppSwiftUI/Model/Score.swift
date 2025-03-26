//
//  Score.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import Foundation

struct Score: Codable, Identifiable ,Hashable {
    let id: Int
    let title: String
    let composer: String
    let year: Int
    let length: Double
    let cover: String
    let tracks: [String]
    var favorited: Bool
}


extension Score {
    var lengthS: String {
        "\(length.formatted(.number.precision(.integerAndFractionLength(integer: 3, fraction: 1)))) min."
    }
    
    var yearS: String {
        year.formatted(.number.precision(.integerLength(4)))
    }
}
