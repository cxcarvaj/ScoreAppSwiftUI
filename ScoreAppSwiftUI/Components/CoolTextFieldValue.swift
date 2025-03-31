//
//  CoolTextField 2.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 27/3/25.
//


import SwiftUI

struct CoolTextFieldValue<Format : ParseableFormatStyle>: View where Format.FormatOutput == String, Format.FormatInput: Equatable {
    
    let label: String
    let placeholder: String
    @Binding var value: Format.FormatInput
    let format: Format
    let validation: (Format.FormatInput) -> String?
    
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .padding(.leading)
                .accessibilityHidden(true)
            HStack(alignment: .top) {
                TextField(placeholder,
                          value: $value,
                          format: format)
                .accessibilityLabel("\(label). \(placeholder)")
                .accessibilityHint("TextField. \(validation(value) != nil ? "Error: \(errorMessage!)" : "Enter a \(label)")")
                .accessibilityValue("\(value)")
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
    @Previewable @State var value = 1998
    CoolTextFieldValue(label: "Title",
                  placeholder: "Title of the Score",
                  value: $value,
                  format: .number.precision(.integerLength(4))) {
        ($0 < 1900 || $0 > 2050) ? " must be between 1900 and 2050" : nil
    }
}
