//
//  SavedQuotesView.swift
//  RandomQuoteApp
//
//  Created by Pubudu Dilshan on 2025-01-01.
//

import Foundation
import SwiftUI

struct SavedQuotesView: View {
    @Binding var savedQuotes: [(String, String)]

    var body: some View {
        VStack {
            Button("Clear All") {
                savedQuotes.removeAll()
            }
            .padding()
            .foregroundColor(.red)

            List(savedQuotes, id: \.0) { quote in
                VStack(alignment: .leading) {
                    Text("\"\(quote.0)\"")
                        .font(.body)
                    Text("- \(quote.1)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            .navigationTitle("Saved Quotes")
        }
    }
}
