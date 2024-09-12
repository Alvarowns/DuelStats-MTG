//
//  PlayerModel.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

@Model
class Player: Hashable {
    @Attribute(.unique) var id = UUID()
    var name: String
    var decks: [Deck]
    @Relationship var matches: [SingleMatch]
    
    init(id: UUID = UUID(), name: String, decks: [Deck], matches: [SingleMatch]) {
        self.id = id
        self.name = name
        self.decks = decks
        self.matches = matches
    }
}

@Model
class Deck: Hashable {
    @Attribute(.unique) var id = UUID()
    var name: String
    var format: String
    
    init(id: UUID = UUID(), name: String, format: String) {
        self.id = id
        self.name = name
        self.format = format
    }
}

