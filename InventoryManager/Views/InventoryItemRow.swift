//
//  InventoryItemRow.swift
//  InventoryManager
//
//  Created by Kevin Macaulay on 3/24/24.
//

import SwiftUI

struct InventoryItemRow: View {
    var inventoryItem: InventoryItem
    
    var body: some View {
        HStack {
            imageView()

            Text(inventoryItem.name)

            Spacer()

            Text(inventoryItem.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder
    func imageView() -> some View {
        if let image = inventoryItem.image {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
        } else {
            Image(systemName: "tag")
                .resizable()
                .foregroundStyle(.accent)
                .frame(width: 50, height: 50)
        }
    }
}

#Preview {
    let inventoryItems = ModelData().inventory
    
    return Group {
        InventoryItemRow(inventoryItem: inventoryItems[0])
        InventoryItemRow(inventoryItem: inventoryItems[1])
        InventoryItemRow(inventoryItem: InventoryItem(id: UUID().uuidString, name: "", price: 0))
    }
}
