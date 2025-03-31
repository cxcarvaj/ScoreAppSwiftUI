//
//  ShareScore.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 30/3/25.
//

import SwiftUI

struct ShareScore: View {
    let score: Score
    
    @State private var url: URL?
    
    var body: some View {
        VStack {
            if let url {
                ShareLink(item: url,
                          subject: Text(score.title),
                          message: Text("Sharing a score."))
            }
        }
        .onAppear {
            let fileURL = URL.documentsDirectory.appending(path: "cover\(score.id)").appendingPathExtension("heic")
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                self.url = fileURL
            } else {
                let fileURL = URL.temporaryDirectory.appending(path: "cover\(score.id)")
                    .appendingPathExtension("jpg")
                
                if let cover = UIImage(named: score.cover),
                   let data = cover.jpegData(compressionQuality: 0.8) {
                    try? data.write(to: fileURL, options: .atomic)
                    
                    if FileManager.default.fileExists(atPath: fileURL.path) {
                        self.url = fileURL
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ShareScore(score: .test)
}
