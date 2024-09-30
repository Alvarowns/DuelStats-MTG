//
//  SplashView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 24/9/24.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Query var background: [BackgroundPersistent]
    
    @State private var size: Double = 0.5
    @State private var opacity: Double = 0.5
    
    var body: some View {
            VStack {
                Spacer()
                
                Image(.dsPet)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: horizontalSizeClass == .compact ? 300 : 500)
                    .shadowPop()
                    .scaleEffect(size)
                    .opacity(opacity)
                
                Text("DuelStats MTG")
                    .font(horizontalSizeClass == .compact ? .largeTitle : .custom("iPad", size: 60))
                    .foregroundStyle(.white)
                    .padding()
                    .fontWeight(.heavy)
                    .shadowPop()
                    .shadowPop()
                    .scaleEffect(size)
                    .opacity(opacity)
                
                Spacer()
                Spacer()
            }
            .padding(.bottom)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                if let background = background.first?.image {
                    Image("\(background)")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.5)
                        .ignoresSafeArea()
                } else {
                    Image(uiImage: viewModel.backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .opacity(0.5)
                        .ignoresSafeArea()
                }
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.8)) {
                    self.size = 1.0
                    self.opacity = 1.0
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    viewModel.appState = .startingView
                }
            }
    }
}
