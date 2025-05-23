//
//  InfoPopUp.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 12/9/24.
//

import SwiftUI

struct InfoPopUp: View {
    @Binding var showInfo: Bool
    
    var title: String
    var subtitle: String
    var message: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .bold()
                .font(.title3)
                .foregroundStyle(.white)
            
            Text(subtitle)
                .bold()
                .font(.headline)
                .foregroundStyle(.white)
            
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.red)
            
            Button {
                showInfo = false
            } label: {
                Text("Ok")
                    .frame(width: 150)
                    .bold()
                    .foregroundStyle(.black)
            }
            .buttonStyle(.borderedProminent)
        }
        .multilineTextAlignment(.center)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.lead)
                .shadow(color: .white, radius: 2)
        }
        .padding()
        .opacity(showInfo ? 1.0 : 0.0)
    }
}
