//
//  InventoryView.swift
//  InventoryManager
//
//  Created by Kevin Macaulay on 3/24/24.
//

import SwiftUI

struct InventoryList: View {
    @Environment(ModelData.self) var modelData
    @State private var path = NavigationPath()
    @State var newInventoryItem: InventoryItem = InventoryItem(id: UUID().uuidString, name: "", price: 0)
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(modelData.inventory) { inventoryItem in
                    NavigationLink {
                        InventoryItemDetail(inventoryItem: inventoryItem)
                    } label: {
                        InventoryItemRow(inventoryItem: inventoryItem)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Inventory")
            .toolbar {
                Button {
                    newInventoryItem = InventoryItem(id: UUID().uuidString, name: "", price: 0)
                    modelData.inventory.append(newInventoryItem)
                    
                    path.append("AddInventoryItem")
                } label: {
                    Image(systemName: "plus")
                }
                .navigationDestination(for: String.self) { route in
                    InventoryItemDetail(inventoryItem: newInventoryItem)
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        modelData.inventory.remove(atOffsets: offsets)
    }
}

#Preview {
    InventoryList()
        .environment(ModelData())
}
