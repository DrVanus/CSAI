//
//  NewsView.swift
//  CryptoSageAIP2
//
//  Created by DM on 2/27/25.
//

import SwiftUI

struct NewsArticle: Identifiable {
    let id = UUID()
    let title: String
    let source: String
    let summary: String
}

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = [
        NewsArticle(
            title: "Bitcoin hits new all-time high!",
            source: "Example Crypto News",
            summary: "BTC has reached an unprecedented value..."
        ),
        // ...
    ]
    
    func refreshNews() {
        // Real API call to fetch news
    }
}

struct NewsView: View {
    @ObservedObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.articles) { article in
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.headline)
                    Text("Source: \(article.source)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(article.summary)
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Crypto News")
            .onAppear {
                viewModel.refreshNews()
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
