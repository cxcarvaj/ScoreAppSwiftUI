//
//  ScoreCover.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 29/3/25.
//

import SwiftUI

struct ScoreCover: View {
    let score: Score
    
    @State private var cover: UIImage?
    
    var body: some View {
        if let cover {
            Image(uiImage: cover)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(.rect(cornerRadius: 10))
        } else {
            Image(score.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .clipShape(.rect(cornerRadius: 10))
                .onAppear {
                    let url = URL.documentsDirectory.appending(path: "cover\(score.id)").appendingPathExtension("heic")
                    
                    if FileManager.default.fileExists(atPath: url.path) {
                        if let data = try? Data(contentsOf: url) {
                            self.cover = UIImage(data: data)
                        }
                    }
                }
        }
    }
}

#Preview {
    ScoreCover(score: .test)
}
