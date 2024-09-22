//
//  Settings.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 22/9/24.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.dismiss) var dismiss
    
    let fondoNames: [String] = ["bg1", "bg2", "bg9", "bg10", "bg11", "bg13"]
    
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
                }
            }
        }
    }
}
