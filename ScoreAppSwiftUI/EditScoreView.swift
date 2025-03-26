//
//  EditScoreView.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI

struct EditScoreView: View {
    @ObservedObject var editScoreVM: EditScoreVM
    
    var body: some View {
        TextField("Enter the title", text: $editScoreVM.title)
    }
}

#Preview {
    EditScoreView(editScoreVM: EditScoreVM(score: .test))
}
