//
//  ModelsSheetView.swift
//  ARP SwiftUI
//
//  Created by Fadey Notchenko on 13.02.2022.
//

import SwiftUI

struct ModelsSheetView: View {
    
    @Binding var isModelsSheetShow: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ModelsByCategory(isModelsSheetShow: $isModelsSheetShow)
            }
            .navigationBarTitle(Text("3D Модели"), displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        self.isModelsSheetShow.toggle()
                    }
                }
            }
        }
    }
}

struct HorizontalGrid: View {
    
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var isModelsSheetShow: Bool
    var title: String
    var items: [Model]
    private let gridItemLayout = [GridItem(.fixed(150))]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.title2).bold()
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                LazyHGrid(rows: gridItemLayout, spacing: 30) {
                    
                    ForEach(0..<items.count) { item in
                        
                        let model = items[item]
                        ItemButton(model: model) {
                            model.asyncLoadModelEntity()
                            withAnimation {
                                self.placementSettings.selectedModel = model
                                self.isModelsSheetShow.toggle()
                                print(model.name)
                            }
                        }
                    }
                }
                .padding()
            }
            
        }
    }
}

struct ModelsByCategory: View {
    
    @Binding var isModelsSheetShow: Bool
    let models = Models()
    
    var body: some View {
        ForEach(ModelCategory.allCases, id: \.self) { category in
            if let arrayModelByCategory = models.getModelByCategory(category: category) {
                HorizontalGrid(isModelsSheetShow: $isModelsSheetShow, title: category.title, items: arrayModelByCategory)
            }
        }
    }
}

struct ItemButton: View {
    
    let model: Model
    let action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            Image(self.model.name)
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8)
        }
    }
}
