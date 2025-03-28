//
//  EditScoreView.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI

struct EditScoreView: View {
    @ObservedObject var editScoreVM: EditScoreVM
    @EnvironmentObject private var vm: ScoresVM
    
//    @State private var date: Date = Date()
    
    var body: some View {
        ScrollView {
//            TextField("Enter the title", text: $editScoreVM.title)
//                .textFieldStyle(.roundedBorder)
            LazyVStack(spacing: 0) {
                CoolTextField(label: "Score title",
                              placeholder: "Enter the title of the score",
                              value: $editScoreVM.title,
                              validation: editScoreVM.isValueEmpty)
                
                HStack {
                    Text("Composer")
                        .font(.headline)
                    Spacer()
                    Picker(selection: $editScoreVM.composer) {
                        ForEach(vm.composers, id: \.self) { composer in
                            Text(composer)
                        }
                    } label: {
                        Text("Composer")
                    }
                    .pickerStyle(.menu)
                    .tint(.secondary)
                }
                .padding(.horizontal)
                
                CoolTextFieldValue(label: "Year",
                                   placeholder: "Enter the year of the score",
                                   value: $editScoreVM.year,
                                   format: .number.precision(.integerLength(4)),
                                   validation: editScoreVM.validateYear)
                
//                TextField("Year",
//                          value: $editScoreVM.year,
//                          format: .number.precision(.integerLength(4)))
//                
//                TextField("Date",
//                          value: $date,
//                          format: .dateTime.day(.defaultDigits).month(.twoDigits).year(.twoDigits))
                
//                TextEditor(text: $editScoreVM.composer)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 100)
            }

        }
        .safeAreaPadding()
        .navigationTitle("Edit Score")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    
                } label: {
                    Text("Save")
                }

            }
        }
    }
}

#Preview {
    EditScoreView.preview
}
