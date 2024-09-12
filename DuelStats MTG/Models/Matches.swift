//
//  Matches.swift
//  GamesLifeCounter
//
//  Created by Alvaro Santos Orellana on 29/4/24.
//

import Foundation
import SwiftData

@Model
class SingleMatch: Hashable {
    @Attribute(.unique)  var id = UUID()
    var playersID: [UUID]
    var decksID: [UUID]
    var winnerID: UUID
    var winnerDeckID: UUID
    var date: Date
    
    init(id: UUID = UUID(), playersID: [UUID], decksID: [UUID], winnerID: UUID, winnerDeckID: UUID, date: Date) {
        self.id = id
        self.playersID = playersID
        self.decksID = decksID
        self.winnerID = winnerID
        self.winnerDeckID = winnerDeckID
        self.date = date
    }
}
