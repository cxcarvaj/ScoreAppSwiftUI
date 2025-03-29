//
//  CoolTextField.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 27/3/25.
//

import SwiftUI

struct CoolTextField: View {
    let label: String
    let placeholder: String
    @Binding var value: String
    let validation: (String) -> String?
    
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .padding(.leading)
            HStack(alignment: .top) {
                TextField(placeholder,
                          text: $value,
                          axis: .vertical)
                //                        .lineLimit(2, reservesSpace: true)
                if !value.isEmpty {
                    Button {
                        value = ""
                    } label: {
                        Image(systemName: "xmark")
                            .symbolVariant(.circle.fill)
                    }
                    .buttonStyle(.plain)
                    .opacity(0.2)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background {
                Color.secondary.opacity(0.1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    .fill(.linearGradient(colors: [.red.opacity(0.9), .red.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
                    .opacity(errorMessage != nil ? 1.0 : 0.0)
            }
            
            Text("\(label)\(errorMessage ?? "")")
                .font(.caption)
                .foregroundStyle(.red)
                .padding(.leading)
                .opacity(errorMessage != nil ? 1.0 : 0.0)
        }
        .onChange(of: value) {
            errorMessage = validation(value)
        }
        .animation(.default, value: errorMessage)
    }
}

#Preview {
    @Previewable @State var value = ""
    CoolTextField(label: "Title",
                  placeholder: "Title of the Score",
                  value: $value) {
        $0.isEmpty ? " is required" : nil
    }
}
