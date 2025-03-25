//
//  Score.swift
//  ScoresAppUIKit
//
//  Created by Carlos Xavier Carvajal Villegas on 10/3/25.
//

import Foundation

struct ScoreDTO: Codable {
    let id: Int
    let title: String
    let composer: String
    let year: Int
    let length: Double
    let cover: String
    let tracks: [String]
    
    var toScore: Score {
        Score(id: id,
              title: title,
              composer: composer,
              year: year,
              length: length,
              cover: cover,
              tracks: tracks,
              favorited: false)
    }
}
