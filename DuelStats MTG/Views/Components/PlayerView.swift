//
//  PlayerView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 15/9/24.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var playerLife: Int = 20
    @State private var lifesCounter: Int = 0
    @State private var lifesCounterSwitch: Bool = false
    @State private var timer: Timer?
    
    let player: Player
    
    var sizeClassFont: Font {
        if horizontalSizeClass == .compact {
            return .custom("iphone", size: 50)
        } else if horizontalSizeClass == .regular {
            return .custom("ipad", size: 100)
        }
        return .custom("iphone", size: 50)
    }
    
    var lifeGreaterThan100: Font {
        if playerLife > 99 {
            return .custom(">99", size: 80)
        } else {
            return .custom("<99", size: 100)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "circles.hexagonpath")
                }
                .shadowPop()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "crown")
                }
                .shadowPop()
            }
            .font(horizontalSizeClass == .compact ? .title : .custom("ipad", size: 60))
            .bold()
            
            Text(player.name)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.title)
                .bold()
                .shadowPop()
            
            HStack {
                Button {
                    playerLife -= 1
                    lifesCounter -= 1
                } label: {
                    Image(systemName: "minus.circle")
                }
                .shadowPop()
                .font(sizeClassFont)
                .buttonRepeatBehavior(.enabled)
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text(lifesCounter > 0 ? "+\(lifesCounter)" : "\(lifesCounter)")
                        .font(.body)
                        .opacity(lifesCounterSwitch && lifesCounter != 0 ? 1.0 : 0.0)
                        .onChange(of: lifesCounter) {
                            lifesCounterSwitch = true
                            restartTimer()
                        }
                    
                    Text("\(playerLife)")
                        .font(horizontalSizeClass == .compact ? lifeGreaterThan100 : .custom("ipad", size: 160))
                }
                .shadowPop()
                
                Spacer()
                
                Button {
                    playerLife += 1
                    lifesCounter += 1
                } label: {
                    Image(systemName: "plus.circle")
                }
                .shadowPop()
                .font(sizeClassFont)
                .buttonRepeatBehavior(.enabled)
            }
            .bold()
            .frame(maxWidth: .infinity)
        }
        .padding()
//        .background {
//            Image(uiImage: viewModel.backgroundImage)
//                .resizable()
//                .scaledToFill()
//        }
        .tint(.white)
        .foregroundStyle(.white)
    }
    
    private func restartTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            lifesCounterSwitch = false
            lifesCounter = 0
        }
    }
}
