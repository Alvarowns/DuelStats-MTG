//
//  MainView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 22/9/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    @State private var settings: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    settings.toggle()
                } label: {
                    Image(systemName: "gearshape")
                }
            }
            .font(.title2)
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
                .frame(maxHeight: 300)
                .shadowPop()
            
            Text("DuelStats MTG")
                .font(.largeTitle)
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
                    .font(.title3)
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
