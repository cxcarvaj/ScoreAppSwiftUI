//
//  SortedByButton.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

fileprivate struct SortedByButton: ViewModifier {
    @Binding var orderBy: SortedBy
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        ForEach(SortedBy.allCases) { option in
                            Button {
                                orderBy = option
                            } label: {
                                Text(option.rawValue)
                            }

                        }
                        
                    } label: {
                        Text("Order By")
                    }

                }
            }
    }
}

extension View {
    func sortedByButton(orderBy: Binding<SortedBy>) -> some View {
        modifier(SortedByButton(orderBy: orderBy))
    }
}
