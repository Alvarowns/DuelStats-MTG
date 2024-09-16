//
//  Extensions.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 14/9/24.
//

import SwiftUI

extension View {
    public func shadowPop() -> some View {
        self
            .shadow(radius: 2)
            .shadow(radius: 0.5)
            .shadow(radius: 0.5)
            .shadow(radius: 0.5)
            .shadow(radius: 0.5)
            .shadow(radius: 0.5)
            .shadow(radius: 0.5)
    }
}
