//
//  ContentView.swift
//  RandomQuoteApp
//
//  Created by Pubudu Dilshan on 2025-01-01.
//

import SwiftUI


struct ContentView: View {
    @State private var quote: String = "Tap the button to get a quote!🌟"
    @State private var author: String = ""
    @State private var showAnimation: Bool = false
    @State private var savedQuotes: [(String, String)] = []
    
    
    
    var body: some View {
        
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.green]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            
            VStack(spacing: 20) {
                
                
                Text("Random Quote Generator")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("\"\(quote)\"")
                    .font(.body)
                    .italic()
                    .multilineTextAlignment(.center)
                    .padding()
                
                if !author.isEmpty {
                    Text("- \(author)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                
                Button(action: fetchQuote) {
                    Text("✨ Generate New Quote")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Button(action: saveQuote) {
                    Text("💾 Save Quote")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                    // NavigationLink to SavedQuotesView
                    NavigationLink(destination: SavedQuotesView(savedQuotes: $savedQuotes)) {
                        Text("📚 View Saved Quotes")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    
                    
                }
                
            }
            .padding()
        }
    }
        
        func fetchQuote() {
            let urlString = "https://api.quotable.io/random"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    let decoder = JSONDecoder()
                    if let json = try? decoder.decode(Quote.self, from: data) {
                        DispatchQueue.main.async {
                            self.quote = json.content
                            self.author = json.author
                        }
                    }
                }
            }.resume()
        }
        
        struct Quote: Codable {
            let content: String
            let author: String
        }
        
        func saveQuote() {
            let newQuote = (quote, author)
            savedQuotes.append(newQuote)
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

    
    
    #Preview {
        ContentView()
    }

