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
    var favorite: Bool
    @Relationship var matches: [SingleMatch]
    
    init(id: UUID = UUID(), name: String, decks: [Deck], favorite: Bool, matches: [SingleMatch]) {
        self.id = id
        self.name = name
        self.decks = decks
        self.favorite = favorite
        self.matches = matches
    }
}

@Model
class Deck: Hashable {
    @Attribute(.unique) var id = UUID()
    var name: String
    var format: String
    var hasBeenDeleted: Bool
    
    init(id: UUID = UUID(), name: String, format: String, hasBeenDeleted: Bool) {
        self.id = id
        self.name = name
        self.format = format
        self.hasBeenDeleted = hasBeenDeleted
    }
}

