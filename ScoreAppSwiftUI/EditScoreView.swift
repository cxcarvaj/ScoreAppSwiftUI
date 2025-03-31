//
//  EditScoreView.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 26/3/25.
//

import SwiftUI
import PhotosUI

struct EditScoreView: View {
    @ObservedObject var editScoreVM: EditScoreVM
    @EnvironmentObject private var vm: ScoresVM
    @Environment(\.dismiss) var dismiss
    
    @State private var dropTarget: Bool = false
    
//    @State private var date: Date = Date()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                //            TextField("Enter the title", text: $editScoreVM.title)
                //                .textFieldStyle(.roundedBorder)
                
                Section {
                    CoolTextField(label: "Score title",
                                  placeholder: "Enter the title of the score",
                                  value: $editScoreVM.title,
                                  validation: editScoreVM.isValueEmpty)
                    
                    Picker(selection: $editScoreVM.composer) {
                        ForEach(vm.composers, id: \.self) { composer in
                            Text(composer)
                        }
                    } label: {
                        Text("Composer")
                    }
                    .pickerStyle(.navigationLink)
                    .tint(.secondary)
                    
                    HStack {
                        CoolTextFieldValue(label: "Year",
                                           placeholder: "Enter the year of the score",
                                           value: $editScoreVM.year,
                                           format: .number.precision(.integerLength(4)),
                                           validation: editScoreVM.validateYear)
                        
                        CoolTextFieldValue(label: "Length",
                                           placeholder: "Enter the length of the score",
                                           value: $editScoreVM.length,
                                           format: .number.precision(
                                            .integerAndFractionLength(integer: 3, fraction: 1)),
                                           validation: editScoreVM.validateLenght)
                    }
                    .padding(.top)
                } header: {
                    Text("Score Data")
                        .font(.headline)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                }
                
                
                Section {
                    if let image = editScoreVM.cover {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
    //                        Esta es la forma vieja de hacer drag & drop
    //                            .onDrag { NSItemProvider(object: image) } preview: {
    //                                Image(uiImage: image)
    //                            }
                            .draggable(Image(uiImage: image)) {
                                Image(uiImage: image)
                            }
                            .dropDestination(for: Data.self) { items, location in
                                print("Location: \(location)")
                                if let item = items.first {
                                    editScoreVM.cover = UIImage(data: item)
                                    return true
                                }
                                return false
                            } isTargeted: {
                                dropTarget = $0
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 4)
                                    .fill(Color.red)
                                    .opacity(dropTarget ? 1.0 : 0.0)
                            }

                            
                    } else {
                        Image(editScoreVM.score.cover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
    //                            .onDrag { NSItemProvider(object: UIImage(named: editScoreVM.score.cover)!) } preview: {
    //                                Image(editScoreVM.score.cover)
    //                            }
                            .accessibilityHint(Text("Cover of the scores"))
                            .draggable(Image(editScoreVM.score.cover)) {
                                Image(editScoreVM.score.cover)
                            }
                            .dropDestination(for: Data.self) { items, location in
                                print("Location: \(location)")
                                if let item = items.first {
                                    editScoreVM.cover = UIImage(data: item)
                                    return true
                                }
                                return false
                            } isTargeted: {
                                dropTarget = $0
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 4)
                                    .fill(Color.red)
                                    .opacity(dropTarget ? 1.0 : 0.0)
                            }

                    }
                    
                    PhotosPicker(selection: $editScoreVM.photo, matching: .images) {
                        Label("Change cover", systemImage: "photo")
                    }
                    .buttonStyle(.bordered)
                    .padding(.bottom)
                } header: {
                    Text("Cover")
                        .font(.headline)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
                
                
                //Como el List está dentro de un ScrollView, debemos darle un tamaño
                //                List {
                //                    ForEach(editScoreVM.tracks, id: \.self) { track in
                //                            Text(track)
                //                    }
                //                }
                //                .listStyle(.plain)
                //                .frame(height: 500)
                Section {
                    List {
                        ForEach($editScoreVM.tracks, id: \.self) { $track in
                            TextField("Enter the track name", text: $track)
                                .accessibilityLabel("\(track). Enter the track name")
                                .accessibilityHint("Enter the name of the track.")
                                .accessibilityValue(track)
                        }
                        .onDelete(perform: editScoreVM.deleteTrackAt)
                        .onMove(perform: editScoreVM.moveTrack)
                    }
                    .listStyle(.plain)
                    .frame(minHeight: 500)
                } header: {
                    Text("Tracks")
                        .font(.headline)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                }
                
                
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
            
            .navigationTitle("Edit Score")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    HStack {
                        ShareScore(score: editScoreVM.score)
                        
                        Button {
                            if let newScore = editScoreVM.saveScore() {
                                vm.updateScore(score: newScore)
                                dismiss()
                            }
                            
                        } label: {
                            Text("Save")
                        }
                    }
                    
                }
            }
        }
        .safeAreaPadding()
        .alert("Validation Error",
               isPresented: $editScoreVM.showAlert) {} message: {
            Text(editScoreVM.errorMsg)
        }
    }
}

#Preview {
    EditScoreView.preview
}
