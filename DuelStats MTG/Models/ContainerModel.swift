//
//  ContainerModel.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

@Model
class ContainerModel: Hashable {
    var players: [Player]
    var matches: [SingleMatch]
    var decks: [Deck]
    var background: [BackgroundPersistent]
    
    init(players: [Player], matches: [SingleMatch], decks: [Deck], background: [BackgroundPersistent]) {
        self.players = players
        self.matches = matches
        self.decks = decks
        self.background = background
    }
}

@Model
class BackgroundPersistent {
    var image: String
    
    init(image: String) {
        self.image = image
    }
}
