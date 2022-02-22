//
//  SettingView.swift
//  ARP SwiftUI
//
//  Created by Fadey Notchenko on 13.02.2022.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var isSettingSheetShow: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                
            }
            .navigationBarTitle(Text("Настройки"), displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        self.isSettingSheetShow.toggle()
                    }
                }
            }
        }
    }
}
