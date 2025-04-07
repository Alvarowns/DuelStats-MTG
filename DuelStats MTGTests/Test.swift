//
//  Test.swift
//  DuelStats MTGTests
//
//  Created by Alvaro Santos Orellana on 7/4/25.
//

import Testing

extension Tag {
    @Tag static var playerLogic: Self
}

@Suite("Test de lógica de jugadores", .tags(.playerLogic))
struct Test {
    @Test("Elimina correctamente un jugador del diccionario")
    func testUnselectedPlayer() async throws {
        // No podemos usar Player directamente al ser un modelo de SwiftData, tendríamos que crear un mock.
    }

}
