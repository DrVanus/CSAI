//
//  MarketplaceView.swift
//  StoryVaultAI
//
//  Created by DM on 2/25/25.
//

import SwiftUI

struct MarketplaceView: View {
    @State private var searchText = ""
    
    // Full list of items (placeholder prices - adjust as needed)
    private let items: [MarketplaceItem] = [
        // Existing expansions
        MarketplaceItem(name: "Public Domain Classics Pack",
                        description: "Fully legal stories",
                        price: "$2.99",
                        genre: "Various"),
        MarketplaceItem(name: "Beowulf Campaign",
                        description: "Epic expansions from the Old English poem",
                        price: "$3.99",
                        genre: "Fantasy"),
        MarketplaceItem(name: "Treasure Island Pack",
                        description: "Pirate expansions",
                        price: "$3.99",
                        genre: "Adventure"),
        MarketplaceItem(name: "Dracula Adventures",
                        description: "Gothic expansions",
                        price: "$2.49",
                        genre: "Horror"),
        MarketplaceItem(name: "Steampunk Worlds",
                        description: "Victorian clockwork expansions",
                        price: "$2.99",
                        genre: "Steampunk"),
        
        // Public-domain stories (placeholder prices for demonstration)
        MarketplaceItem(name: "Alice’s Adventures in Wonderland",
                        description: "Lewis Carroll (1865)",
                        price: "$1.99",
                        genre: "Fantasy"),
        MarketplaceItem(name: "The Wonderful Wizard of Oz",
                        description: "L. Frank Baum (1900)",
                        price: "$1.99",
                        genre: "Fantasy"),
        MarketplaceItem(name: "Peter Pan (Peter and Wendy)",
                        description: "J. M. Barrie (1911)",
                        price: "$1.99",
                        genre: "Fantasy"),
        MarketplaceItem(name: "Grimm’s Fairy Tales",
                        description: "Jacob & Wilhelm Grimm (19th c.)",
                        price: "$0.99",
                        genre: "Fantasy"),
        MarketplaceItem(name: "One Thousand and One Nights",
                        description: "Various (ancient/medieval)",
                        price: "$2.49",
                        genre: "Fantasy"),
        
        // Adventure
        MarketplaceItem(name: "Treasure Island",
                        description: "R. L. Stevenson (1883)",
                        price: "$0.99",
                        genre: "Adventure"),
        MarketplaceItem(name: "The Count of Monte Cristo",
                        description: "A. Dumas (1844)",
                        price: "$1.99",
                        genre: "Adventure"),
        MarketplaceItem(name: "The Three Musketeers",
                        description: "A. Dumas (1844)",
                        price: "$1.49",
                        genre: "Adventure"),
        MarketplaceItem(name: "Robinson Crusoe",
                        description: "Daniel Defoe (1719)",
                        price: "$0.99",
                        genre: "Adventure"),
        MarketplaceItem(name: "The Odyssey",
                        description: "Homer (ancient Greek epic)",
                        price: "$0.99",
                        genre: "Adventure"),
        
        // Romance
        MarketplaceItem(name: "Pride and Prejudice",
                        description: "Jane Austen (1813)",
                        price: "$1.49",
                        genre: "Romance"),
        MarketplaceItem(name: "Jane Eyre",
                        description: "Charlotte Brontë (1847)",
                        price: "$1.49",
                        genre: "Romance"),
        MarketplaceItem(name: "Wuthering Heights",
                        description: "Emily Brontë (1847)",
                        price: "$1.49",
                        genre: "Romance"),
        MarketplaceItem(name: "Little Women",
                        description: "Louisa May Alcott (1868)",
                        price: "$0.99",
                        genre: "Romance"),
        
        // Horror / Gothic
        MarketplaceItem(name: "Dracula",
                        description: "Bram Stoker (1897)",
                        price: "$1.99",
                        genre: "Horror"),
        MarketplaceItem(name: "Frankenstein",
                        description: "Mary Shelley (1818)",
                        price: "$1.49",
                        genre: "Horror"),
        MarketplaceItem(name: "Carmilla",
                        description: "J. Sheridan Le Fanu (1872)",
                        price: "$0.99",
                        genre: "Horror"),
        MarketplaceItem(name: "Dr. Jekyll and Mr. Hyde",
                        description: "R. L. Stevenson (1886)",
                        price: "$0.99",
                        genre: "Horror"),
        
        // Mystery / Detective
        MarketplaceItem(name: "The Adventures of Sherlock Holmes",
                        description: "A. Conan Doyle (1892)",
                        price: "$0.99",
                        genre: "Mystery / Detective"),
        MarketplaceItem(name: "The Hound of the Baskervilles",
                        description: "A. Conan Doyle (1902)",
                        price: "$1.49",
                        genre: "Mystery / Detective"),
        MarketplaceItem(name: "The Moonstone",
                        description: "Wilkie Collins (1868)",
                        price: "$1.49",
                        genre: "Mystery / Detective"),
        MarketplaceItem(name: "The Mysterious Affair at Styles",
                        description: "Agatha Christie (1920)",
                        price: "$1.49",
                        genre: "Mystery / Detective"),
        
        // Science Fiction
        MarketplaceItem(name: "The War of the Worlds",
                        description: "H. G. Wells (1898)",
                        price: "$1.49",
                        genre: "Science Fiction"),
        MarketplaceItem(name: "The Time Machine",
                        description: "H. G. Wells (1895)",
                        price: "$1.49",
                        genre: "Science Fiction"),
        MarketplaceItem(name: "20,000 Leagues Under the Sea",
                        description: "Jules Verne (1870)",
                        price: "$1.49",
                        genre: "Science Fiction"),
        MarketplaceItem(name: "Journey to the Center of the Earth",
                        description: "Jules Verne (1864)",
                        price: "$1.49",
                        genre: "Science Fiction"),
        
        // Drama / Literary Fiction
        MarketplaceItem(name: "The Great Gatsby",
                        description: "F. Scott Fitzgerald (1925)",
                        price: "$1.99",
                        genre: "Drama / Literary Fiction"),
        MarketplaceItem(name: "The Phantom of the Opera",
                        description: "Gaston Leroux (1910)",
                        price: "$1.49",
                        genre: "Drama / Literary Fiction"),
        MarketplaceItem(name: "The Sun Also Rises",
                        description: "Ernest Hemingway (1926)",
                        price: "$1.49",
                        genre: "Drama / Literary Fiction"),
        MarketplaceItem(name: "Winnie-the-Pooh",
                        description: "A. A. Milne (1926)",
                        price: "$0.99",
                        genre: "Drama / Literary Fiction")
    ]
    
    // Filter items by search text
    private var filteredItems: [MarketplaceItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
                || $0.description.localizedCaseInsensitiveContains(searchText)
                || $0.genre.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // Group the filtered items by genre
    private var groupedItems: [String: [MarketplaceItem]] {
        Dictionary(grouping: filteredItems, by: { $0.genre })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.1), .blue.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                List {
                    // Search bar at the top
                    Section {
                        TextField("Search Marketplace...", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 4)
                    }
                    
                    // Display items grouped by genre
                    ForEach(groupedItems.keys.sorted(), id: \.self) { genre in
                        Section(header: Text(genre).font(.headline)) {
                            ForEach(groupedItems[genre] ?? []) { item in
                                NavigationLink(destination: MarketplaceDetailView(item: item)) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name)
                                            .font(.headline)
                                        Text(item.description)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        Text("Price: \(item.price)")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(6)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Marketplace", displayMode: .inline)
        }
    }
}

// Extended to handle detail pages
struct MarketplaceItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: String
    let genre: String
}
