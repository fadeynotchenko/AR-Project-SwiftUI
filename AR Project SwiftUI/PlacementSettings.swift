//
//  PlacementSettings.swift
//  ARP SwiftUI
//
//  Created by Fadey Notchenko on 13.02.2022.
//

import Foundation
import Combine

class PlacementSettings: ObservableObject {
    
    @Published var selectedModel: Model? {
        willSet {
            print("Selected model \(String(describing: newValue))")
        }
    }
    
    @Published var confirmedModel: Model? {
        willSet {
            guard let model = newValue else {
                print("Clear")
                return
            }
            print("Confirmed model \(model.name)")
        }
    }
    
    @Published var lastConfirmedModel: Model?
    
    var sceneObserver: Cancellable?
}
