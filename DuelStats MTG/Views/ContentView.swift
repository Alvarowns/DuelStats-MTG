//
//  ContentView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
