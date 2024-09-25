//
//  PlayerSmallView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 23/9/24.
//

import SwiftUI

struct PlayerSmallView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var playerLife: Int = 20
    @State private var lifesCounter: Int = 0
    @State private var lifesCounterSwitch: Bool = false
    @State private var poisonCounters: Int = 0
    @State private var showPoison: Bool = false
    @State private var timer: Timer?
    @State private var fondo: UIImage = .horizontal2
    @State private var fondoIpad: UIImage = .horizontalIpad2
    @State private var changeImage: Bool = false
    
    @Binding var someoneWon: Bool
    @Binding var playerWon: Player
    @Binding var deckWon: Deck
    
    let fondoNames: [String] = ["horizontal2","horizontal3","horizontal4","horizontal5","horizontal6","horizontal7","horizontal8","horizontal9","horizontal10","horizontal11"]
    
    let fondoNamesIpad: [String] = ["horizontalIpad2", "horizontalIpad3", "horizontalIpad4", "horizontalIpad5", "horizontalIpad6", "horizontalIpad7" ,"horizontal8Ipad", "horizontal9Ipad", "horizontal10Ipad", "horizontal11Ipad"]
    
    let player: Player
    let deck: Deck
    
    var rotation: CGFloat
    
    var sizeClassFont: Font {
        if horizontalSizeClass == .compact {
            return .custom("iphone", size: 45)
        } else if horizontalSizeClass == .regular {
            return .custom("ipad", size: 100)
        }
        return .custom("iphone", size: 45)
    }
    
    var body: some View {
        GeometryReader { geometry in
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
                        
                        HStack(spacing: 0) {
                            Button {
                                showPoison.toggle()
                            } label: {
                                Image(.poison)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: horizontalSizeClass == .compact ? 30 : 80)
                            }
                            
                            Text("\(poisonCounters)")
                                .font(horizontalSizeClass == .compact ? .subheadline : .title)
                                .foregroundStyle(.green)
                                .bold()
                                .opacity(poisonCounters > 0 ? 1.0 : 0.0)
                        }
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
                    .bold()
                    .foregroundStyle(.white)
                    .offset(x: 2)
                    .font(horizontalSizeClass == .compact ? .title : .custom("ipad", size: 60))
                    .padding(.top)
                    .padding(.top, horizontalSizeClass != .compact ? 10 : 0)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .frame(minWidth: horizontalSizeClass == .compact ? geometry.size.width * 2 : geometry.size.width * 1.2)
                    
                    Text(player.name)
                        .padding(5)
                        .font(horizontalSizeClass == .compact ? .title3 : .largeTitle)
                        .shadowPop()
                        .bold()
                    
                    ZStack {
                        HStack {
                            Button {
                                playerLife -= 1
                                lifesCounter -= 1
                            } label: {
                                Image(systemName: "minus.circle")
                            }
                            .foregroundStyle(.white)
                            .shadowPop()
                            .font(sizeClassFont)
                            .bold()
                            .buttonRepeatBehavior(.enabled)
                            
                            Spacer()
                            
                            VStack(spacing: -2) {
                                Text(lifesCounter > 0 ? "+\(lifesCounter)" : "\(lifesCounter)")
                                    .font(.body)
                                    .opacity(lifesCounterSwitch && lifesCounter != 0 ? 1.0 : 0.0)
                                    .onChange(of: lifesCounter) {
                                        lifesCounterSwitch = true
                                        restartTimer()
                                    }
                                
                                Text("\(playerLife)")
                                    .font(horizontalSizeClass == .compact ? .custom("iPhone", size: 80) : .custom("iPad", size: 150))
                                    .bold()
                            }
                            .shadowPop()
                            
                            Spacer()
                            
                            Button {
                                playerLife += 1
                                lifesCounter += 1
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .foregroundStyle(.white)
                            .shadowPop()
                            .font(sizeClassFont)
                            .bold()
                            .buttonRepeatBehavior(.enabled)
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .frame(minWidth: horizontalSizeClass == .compact ? geometry.size.width * 2 : geometry.size.width * 1.2)
                        .opacity(showPoison && horizontalSizeClass == .compact ? 0.0 : 1.0)
                        .transition(.opacity)
                        .animation(.spring, value: showPoison)
                        
                        if horizontalSizeClass == .compact {
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
                                
                                Spacer()
                            }
                            .bold()
                            .foregroundStyle(.green)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            .frame(minWidth: geometry.size.width)
                            .opacity(showPoison ? 1.0 : 0.0)
                            .transition(.opacity)
                            .animation(.spring, value: showPoison)
                        }
                    }
                    
                    if horizontalSizeClass != .compact {
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
                            .font(.largeTitle)
                            .buttonRepeatBehavior(.enabled)
                            
                            Spacer()
                            
                            VStack(spacing: 0) {
                                Text("\(poisonCounters)")
                                    .font(.custom("iPad", size: 100))
                            }
                            .shadowPop()
                            
                            Spacer()
                            
                            Button {
                                poisonCounters += 1
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                            .shadowPop()
                            .font(.largeTitle)
                            .buttonRepeatBehavior(.enabled)
                            
                            Spacer()
                        }
                        .bold()
                        .foregroundStyle(.green)
                        .clipped()
                        .opacity(showPoison ? 1.0 : 0.0)
                    }
                }
                .background {
                    if horizontalSizeClass == .compact{
                            Image(uiImage: fondo)
                                .resizable()
                                .scaledToFit()
                    } else {
                        Image(uiImage: fondoIpad)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .onChange(of: viewModel.startingLife) {
                    playerLife = viewModel.startingLife
                }
                .onChange(of: viewModel.restartLifes) {
                    playerLife = viewModel.startingLife
                }
                .blur(radius: changeImage ? 3.0 : 0.0)
                .disabled(changeImage ? true : false)
                .rotationEffect(.degrees(rotation), anchor: .center)
                .frame(minWidth: geometry.size.width, maxHeight: geometry.size.height)
                
                VStack(spacing: 0) {
                    ZStack {
                        ScrollView(.horizontal) {
                            if horizontalSizeClass == .compact {
                                HStack {
                                    ForEach(fondoNames, id: \.self) { fondo in
                                        Image(fondo)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .frame(maxWidth: 200, maxHeight: 150)
                                            .onTapGesture {
                                                self.fondo = UIImage(imageLiteralResourceName: fondo)
                                                changeImage.toggle()
                                            }
                                            .shadowPop()
                                    }
                                }
                            } else {
                                HStack {
                                    ForEach(fondoNamesIpad, id: \.self) { fondo in
                                        Image(fondo)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .frame(maxWidth: 200, maxHeight: 150)
                                            .onTapGesture {
                                                self.fondoIpad = UIImage(imageLiteralResourceName: fondo)
                                                changeImage.toggle()
                                            }
                                            .shadowPop()
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.never)
                        .safeAreaPadding(.horizontal)
                    }
                }
                .frame(maxHeight: 180)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.black)
                        .shadowPop()
                }
                .padding(.horizontal)
                .opacity(changeImage ? 1.0 : 0.0)
                .rotationEffect(.degrees(rotation), anchor: .center)
            }
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
