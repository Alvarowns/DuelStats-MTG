//
//  MatchesPlayedView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI
import SwiftData

struct MatchesPlayedView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \SingleMatch.date, order: .reverse) var matches: [SingleMatch]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(matches, id: \.self) { match in
                    VStack(alignment: .leading) {
                        Text("\(match.date.formatted())")
                            .font(.headline)
                            .foregroundStyle(.white)
                        
                        ForEach(matches, id: \.self) { match in
                            Text("Winner: \(match.winner.name)")
                            
                            Text("Players: \(match.players)")
                            
                            Text(match.date.description)
                        }
                    }
                }
                .onDelete(perform: deleteMatch(_:))
            }
            .navigationTitle("Matches")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func deleteMatch(_ indexSet: IndexSet) {
        for index in indexSet {
            let match = matches[index]
            modelContext.delete(match)
        }
    }
}

#Preview {
    MatchesPlayedView()
}
