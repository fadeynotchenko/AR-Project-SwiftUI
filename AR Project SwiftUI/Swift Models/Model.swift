//
//  Model.swift
//  ARP SwiftUI
//
//  Created by Fadey Notchenko on 13.02.2022.
//

import Foundation
import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case furniture
    case toys
    case dishes
    
    var title: String {
        get {
            switch self {
            case .furniture:
                return "Мебель"
            case .toys:
                return "Игрушки"
            case .dishes:
                return "Посуда"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var modelEntity: ModelEntity?
    var scale: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scale: Float = 1.0) {
        self.name = name
        self.category = category
        self.scale = scale
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename).sink(receiveCompletion: { loadComplition in
            switch loadComplition {
                
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                
            case .finished:
                break
            }
        
        }, receiveValue: { modelEntity in
            self.modelEntity = modelEntity
            self.modelEntity?.scale *= self.scale
            
            print("\(self.name) loaded")
        })
    }
}

struct Models {
    var arrayOfModel: [Model] = []
    
    init() {
        let chair = Model(name: "chair_swan", category: .furniture, scale: 0.5)
        let cup = Model(name: "cup_saucer_set", category: .dishes)
        let fender = Model(name: "fender_stratocaster", category: .furniture, scale: 0.5)
        let flower = Model(name: "flower_tulip", category: .furniture)
        let gramo = Model(name: "gramophone", category: .furniture, scale: 0.5)
        let teapot = Model(name: "teapot", category: .dishes)
        let car = Model(name: "toy_car", category: .toys)
        let drummer = Model(name: "toy_drummer", category: .toys)
        let wateringcan = Model(name: "wateringcan", category: .furniture, scale: 0.5)
        
        self.arrayOfModel += [chair, cup, fender, flower, gramo, teapot, car, drummer, wateringcan]
    }
    
    func getModelByCategory(category: ModelCategory) -> [Model] {
        return arrayOfModel.filter {
            $0.category == category
        }
    }
}
