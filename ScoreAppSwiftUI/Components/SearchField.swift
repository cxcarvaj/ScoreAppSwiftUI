//
//  SearchField.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 27/3/25.
//

import SwiftUI

struct SearchField: View {
    let placeholder: String
    @Binding var searchText: String
    
    @State private var searchColor = Color.blue
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchColor)
                .bold()
                .padding(10)
                .background(searchColor.opacity(0.1), in: Circle())
                .overlay {
                    Circle()
                        .stroke(lineWidth: 1)
                        .fill(searchColor)
                        .opacity(isFocused ? 1.0 : 0.0)
                }
                .accessibilityHidden(true)
            
            TextField(placeholder, text: $searchText)
                .onChange(of: isFocused) {
                    searchColor = isFocused ? .blue : .gray
                }
                .onSubmit {
                    if !searchText.isEmpty {
                        searchColor = .gray
                    }
                }
                .submitLabel(.search)
                .focused($isFocused)
            
            if !searchText.isEmpty && isFocused {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark")
                        .symbolVariant(.circle)
                        .symbolVariant(.fill)
                        .font(.title3)
                }
                .tint(.blue)
                .padding(.trailing, 5)
//                .buttonStyle(.plain)
//                .opacity(0.5)
            }
        }
        .accessibilityElement(children: .combine) //Esto le dice que tome al componente como uno solo
        .accessibilityAddTraits(.isSearchField)
        .accessibilityLabel(Text("Search field for scores"))
        .accessibilityHint(Text("Enter a score title to search"))
        .padding(5)
//        .padding(.horizontal)
//        .padding(.vertical, 10)
        .background {
            Color.secondary.opacity(0.1)
        }
        .clipShape(Capsule())
        .overlay {
            Capsule()
                .stroke(lineWidth: 2)
                .fill(.linearGradient(colors: [.blue.opacity(0.9), .blue.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
            
        }
        .animation(.default, value: isFocused)
        .animation(.default, value: searchColor)
    }
}

#Preview {
    @Previewable @State var searchText = ""
    SearchField(placeholder: "Search a composer", searchText: $searchText)
        .padding()
}
