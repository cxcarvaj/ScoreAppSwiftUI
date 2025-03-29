//
//  EditScoreVM.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI
import PhotosUI

@MainActor
final class EditScoreVM: ObservableObject {
    @Published var title = ""
    @Published var composer = ""
    @Published var year = 0
    @Published var length = 0.0
    @Published var tracks: [String] = []
    
    @Published var photo: PhotosPickerItem? {
        didSet {
            if let photo {
                loadPhoto(photo)
            }
        }
    }
    
    @Published var cover: UIImage?
    
    let score: Score
    
    init(score: Score) {
        self.score = score
        initValues()
    }
    
    func initValues() {
        title = score.title
        composer = score.composer
        year = score.year
        length = score.length
        tracks = score.tracks
        
        let url = URL.documentsDirectory.appending(path: "cover\(score.id)").appendingPathExtension("heic")
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = try? Data(contentsOf: url) {
                self.cover = UIImage(data: data)
            }
        }
    }
    
    func isValueEmpty(_ value: String) -> String? {
        value.isEmpty ? " is required" : nil
    }
    
    func validateYear(_ year: Int) -> String? {
        year < 1900 || year > 2050 ? " must be between 1900 and 2050" : nil
    }
    
    func validateLenght(_ lenght: Double) -> String? {
        lenght < 0.1 || lenght > 300 ? " must be between 0.1 and 300" : nil
    }
    
    func loadPhoto(_ photo: PhotosPickerItem) {
        photo.loadTransferable(type: Data.self) { result in
            if case .success(let success) = result, let success {
                Task { @MainActor in
                    self.cover = UIImage(data: success)
                }
            }
        }
    }
    
    func deleteTrackAt(_ index: IndexSet) {
        tracks.remove(atOffsets: index)
    }
    
    func moveTrack(from source: IndexSet, to destination: Int) {
        tracks.move(fromOffsets: source, toOffset: destination)
    }
    
    func saveScore() -> Score? {
        let newScore = Score(id: score.id,
                             title: title,
                             composer: composer,
                             year: year,
                             length:length,
                             cover: score.cover,
                             tracks: tracks,
                             favorited: false)
        
        saveCover()
        return newScore
    }
    
    func saveCover() {
        guard let cover else { return }
        let scale = cover.size.width * 9 / 16
        let height = cover.size.height * scale
        
        guard let thumbnail = cover.preparingThumbnail(of: CGSize(width: 300, height: height)),
              let data = thumbnail.heicData() else { return }
        let url = URL.documentsDirectory.appending(path: "cover\(score.id)").appendingPathExtension("heic")
        
        do {
            try data.write(to: url, options: .atomic)
        
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
        
    }
}
