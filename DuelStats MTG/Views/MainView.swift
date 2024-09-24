//
//  MainView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 22/9/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State private var settings: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    settings.toggle()
                } label: {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .bold()
            .padding(.horizontal)
            .shadowPop()
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundStyle(.orange)
            
            Spacer()
            
            Image(.dsPet)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: horizontalSizeClass == .compact ? 300 : 500)
                .shadowPop()
            
            Text("DuelStats MTG")
                .font(horizontalSizeClass == .compact ? .largeTitle : .custom("iPad", size: 60))
                .foregroundStyle(.orange)
                .padding()
                .bold()
                .shadowPop()
                .shadowPop()
            
            Spacer()
            Spacer()
            
            Button {
                viewModel.appState = .tabBar
            } label: {
                Text("Start")
                    .font(horizontalSizeClass == .compact ? .title3 : .title)
                    .bold()
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.black)
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .shadowPop()
            .padding()
        }
        .fullScreenCover(isPresented: $settings) {
            Settings()
        }
        .background {
            Image(uiImage: viewModel.backgroundImage)
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .ignoresSafeArea()
        }
    }
}
