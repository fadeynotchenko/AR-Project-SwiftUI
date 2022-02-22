//
//  BottomBarView.swift
//  ARP SwiftUI
//
//  Created by Fadey Notchenko on 12.02.2022.
//

import SwiftUI

struct CustomButton: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    let iconName: String
    let id: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            if let model = self.placementSettings.lastConfirmedModel, self.id == 1 {
                Image(model.name)
                    .resizable()
                    .frame(width: 50)
                    .aspectRatio(1/1, contentMode: .fit)
                    .background(.white)
                    .cornerRadius(8)
            } else {
                Image(systemName: self.iconName)
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            
        }
        .frame(width: 50, height: 50)
    }
}

struct BottomBarView: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var isModelsSheetShow: Bool
    @Binding var isSettingSheetShow: Bool
    
    var body: some View {
        
        HStack {
            CustomButton(iconName: "arkit", id: 1) {
                withAnimation {
                    self.placementSettings.selectedModel = self.placementSettings.lastConfirmedModel
                }
            }
            
            Spacer()
            
            CustomButton(iconName: "square.grid.2x2.fill", id: 2) {
                withAnimation {
                    self.isModelsSheetShow.toggle()
                    print("Models sheet open")
                }
            }.sheet(isPresented: $isModelsSheetShow) {
                ModelsSheetView(isModelsSheetShow: $isModelsSheetShow)
            }
            
            Spacer()
            
            CustomButton(iconName: "gearshape", id: 3) {
                withAnimation {
                    self.isSettingSheetShow.toggle()
                }
            }.sheet(isPresented: $isSettingSheetShow) {
                SettingView(isSettingSheetShow: $isSettingSheetShow)
            }
        }
        .frame(maxWidth: 400)
        .padding(30)
        .background(Color.black.opacity(0.25))
        
    }
}
