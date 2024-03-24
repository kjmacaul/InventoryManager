//
//  InventoryItemDetail.swift
//  InventoryManager
//
//  Created by Kevin Macaulay on 3/24/24.
//

import SwiftUI
import PhotosUI

struct InventoryItemDetail: View {
    @Environment(ModelData.self) var modelData
    @Environment(\.dismiss) private var dismiss
    
    var inventoryItem: InventoryItem
    @State private var selectedPickerItem: PhotosPickerItem?
    
    var inventoryItemIndex: Int? {
        return modelData.inventory.firstIndex(where: { $0.id == inventoryItem.id })
    }
    
    var body: some View {
        @Bindable var modelData = modelData
        
        ScrollView {
            imageView()
                .overlay(alignment: .bottomTrailing) {
                    PhotosPicker(selection: $selectedPickerItem,
                                 matching: .images) {
                        Image(systemName: "camera.circle")
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                    }
                    .buttonStyle(.borderless)
                }
                .onChange(of: selectedPickerItem) {
                    Task {
                        if let imageData = try? await selectedPickerItem?.loadTransferable(type: Data.self), let inventoryItemIndex = inventoryItemIndex {
                            modelData.inventory[inventoryItemIndex].imageData = imageData
                        }
                    }
                }
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Item Name")
                        .font(.footnote)
                    
                    if let inventoryItemIndex = inventoryItemIndex {
                        TextField("Item Name", text: $modelData.inventory[inventoryItemIndex].name)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Item Price")
                        .font(.footnote)
                    
                    if let inventoryItemIndex = inventoryItemIndex {
                        TextField("Item Price", value: $modelData.inventory[inventoryItemIndex].price, format: .number.precision(.fractionLength(2)))
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(inventoryItem.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                if let inventoryItemIndex = inventoryItemIndex {
                    modelData.inventory.remove(at: inventoryItemIndex)
                }
                
                dismiss()
            } label: {
                Image(systemName: "trash")
            }
        }
    }
    
    @ViewBuilder
    func imageView() -> some View {
        if let inventoryItemIndex = inventoryItemIndex, let image = modelData.inventory[inventoryItemIndex].image {
            image
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        } else {
            Image(systemName: "tag")
                .resizable()
                .foregroundStyle(.accent)
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    let modelData = ModelData()
    return InventoryItemDetail(inventoryItem: modelData.inventory[0])
        .environment(modelData)
}

#Preview("New Item") {
    let modelData = ModelData()
    let newInventoryItem = InventoryItem(id: UUID().uuidString, name: "", price: 0)
    modelData.inventory.append(newInventoryItem)
    
    return InventoryItemDetail(inventoryItem: newInventoryItem)
        .environment(modelData)
}
