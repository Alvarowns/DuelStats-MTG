//
//  Settings.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 22/9/24.
//

import SwiftUI
import SwiftData

struct Settings: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query var backgroundPersistent: [BackgroundPersistent]
    
    let fondoNames: [String] = ["bg1", "bg2", "fondoVertical1", "fondoVertical3", "fondoFlat1", "fondoFlat3", "fondoFlat4", "fondoFlat5"]
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                Spacer()
            }
            
            Form {
                Section {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(fondoNames, id: \.self) { fondo in
                                Button {
                                    viewModel.backgroundImage = UIImage(imageLiteralResourceName: fondo)
                                    if backgroundPersistent.isEmpty {
                                        addFirstBackground(fondo)
                                    } else {
                                        changePersistentBackground(fondo)
                                    }
                                } label: {
                                    Image(fondo)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .frame(maxWidth: 200, maxHeight: 200)
                                }
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.never)
                    .safeAreaPadding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.black)
                            .shadowPop()
                    }
                    .padding(.horizontal)
                } header: {
                    Text("Background")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .padding(.top)
                }
            }
            .formStyle(.columns)
            
            Spacer()
        }
        .padding()
        .background {
            if let background = backgroundPersistent.first?.image {
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
        .tint(.white)
    }
    
    func addFirstBackground(_ background: String) {
        let background = BackgroundPersistent(image: background)
        modelContext.insert(background)
    }
    
    func changePersistentBackground(_ background: String) {
        backgroundPersistent.first?.image = background
    }
}
