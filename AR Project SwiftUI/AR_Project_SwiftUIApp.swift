//
//  AR_Project_SwiftUIApp.swift
//  AR Project SwiftUI
//
//  Created by Fadey Notchenko on 22.02.2022.
//

import SwiftUI

@main
struct AR_Project_SwiftUIApp: App {
    
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
