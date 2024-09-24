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
    @State private var poisonCounters: Int = 0
    @State private var showPoison: Bool = false
    @State private var timer: Timer?
    @State private var fondo: UIImage = .cuadrado2
    @State private var fondoIpad: UIImage = .horizontal2
    @State private var changeImage: Bool = false
    
    @Binding var someoneWon: Bool
    @Binding var playerWon: Player
    @Binding var deckWon: Deck
    
    let fondoNames: [String] = ["cuadrado1", "cuadrado2","cuadrado3","cuadrado4","cuadrado5","cuadrado6","cuadrado7","cuadrado8","cuadrado9","cuadrado10","cuadrado11","cuadrado12","cuadrado13"]
    
    let player: Player
    let deck: Deck
    
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
        ZStack {
            VStack {
                HStack {
                    Button {
                        changeImage.toggle()
                    } label: {
                        Image(systemName: "circles.hexagonpath")
                    }
                    .shadowPop()
                    
                    Spacer()
                    
                    Button {
                        showPoison.toggle()
                    } label: {
                        Image(.poison)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: horizontalSizeClass == .compact ? 50 : 80)
                    }
                    .offset(x: 4)
                    .shadowPop()
                    
                    Spacer()
                    
                    Button {
                        someoneWon.toggle()
                        playerWon = player
                        deckWon = deck
                    } label: {
                        Image(systemName: "crown")
                    }
                    .shadowPop()
                }
                .font(horizontalSizeClass == .compact ? .title : .custom("ipad", size: 60))
                .bold()
                .padding()
                .padding(.top)
                
                Text(player.name)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title)
                    .bold()
                    .shadowPop()
                
                VStack(spacing: 10) {
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
                        .padding()
                        
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
                        .padding()
                    }
                    .bold()
                    .frame(maxWidth: .infinity)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            if poisonCounters != 0 {
                                poisonCounters -= 1
                            }
                        } label: {
                            Image(systemName: "minus.circle")
                        }
                        .shadowPop()
                        .font(.title)
                        .buttonRepeatBehavior(.enabled)
                        .padding()
                        
                        Spacer()
                        
                        VStack(spacing: 0) {
                            Text("\(poisonCounters)")
                                .font(.largeTitle)
                        }
                        .shadowPop()
                        
                        Spacer()
                        
                        Button {
                            poisonCounters += 1
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                        .shadowPop()
                        .font(.title)
                        .buttonRepeatBehavior(.enabled)
                        .padding()
                        
                        Spacer()
                    }
                    .foregroundStyle(.green)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .opacity(showPoison ? 1.0 : 0.0)
                }
                
                Spacer()
            }
            .background {
                if horizontalSizeClass == .compact {
                    Image(uiImage: fondo)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(uiImage: fondoIpad)
                        .resizable()
                        .scaledToFill()
                }
            }
            .tint(.white)
            .foregroundStyle(.white)
            .ignoresSafeArea()
            .onChange(of: viewModel.startingLife) {
                playerLife = viewModel.startingLife
            }
            .onChange(of: viewModel.restartLifes) {
                playerLife = viewModel.startingLife
            }
            .blur(radius: changeImage ? 3.0 : 0.0)
            .disabled(changeImage ? true : false)
            
            VStack {
                ZStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(fondoNames, id: \.self) { fondo in
                                Image(fondo)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .frame(maxWidth: 200, maxHeight: 200)
                                    .onTapGesture {
                                        self.fondo = UIImage(imageLiteralResourceName: fondo)
                                        changeImage.toggle()
                                    }
                                    .shadowPop()
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.never)
                    .safeAreaPadding(.horizontal)
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.black)
                    .shadowPop()
            }
            .padding(.horizontal)
            .opacity(changeImage ? 1.0 : 0.0)
        }
    }
    
    private func restartTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            lifesCounterSwitch = false
            lifesCounter = 0
        }
    }
}
