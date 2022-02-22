//
//  PlacementView.swift
//  ARP SwiftUI
//
//  Created by Fadey Notchenko on 13.02.2022.
//

import Foundation
import SwiftUI

struct PlacementView: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    var body: some View {
        HStack(alignment: .bottom) {
            Spacer()
            
            PlacementButton(name: "xmark.circle.fill") {
                withAnimation {
                    self.placementSettings.selectedModel = nil
                    print("NO")
                }
            }
            
            Spacer()
            
            PlacementButton(name: "checkmark.circle.fill") {
                withAnimation {
                    self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                    self.placementSettings.lastConfirmedModel = self.placementSettings.confirmedModel
                    self.placementSettings.selectedModel = nil
                    print("YES")
                }
            }
            
            Spacer()
        }
        .padding(.bottom, 40)
    }
}

struct PlacementButton: View {
    
    var name: String
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            Image(systemName: name)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}
