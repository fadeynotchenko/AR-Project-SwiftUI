//
//  ContentView.swift
//  AR Project SwiftUI
//
//  Created by Fadey Notchenko on 22.02.2022.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @State var isModelsSheetShow = false
    @State var isSettingSheetShow = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
                
            if self.placementSettings.selectedModel == nil {
                BottomBarView(isModelsSheetShow: $isModelsSheetShow, isSettingSheetShow: $isSettingSheetShow)
            } else {
                PlacementView()
            }
                
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero)
        
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, { event in
            
            self.updateScene(for: arView)
        })
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        
    }
    
    private func updateScene(for arView: CustomARView) {
        arView.focusEntity?.isEnabled = self.placementSettings.selectedModel != nil
        
        if let confirmedModel = self.placementSettings.confirmedModel, let modelEntity = confirmedModel.modelEntity {
            
            place(modelEntity, arView)
            
            self.placementSettings.confirmedModel = nil
        }
    }
    
    private func place(_ modelEntity: ModelEntity, _ arView: ARView) {
        let clonedEntity = modelEntity.clone(recursive: true)
        clonedEntity.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.translation, .rotation], for: clonedEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(clonedEntity)
        
        arView.scene.addAnchor(anchorEntity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

