//
//  InventoryManagerApp.swift
//  InventoryManager
//
//  Created by Kevin Macaulay on 3/24/24.
//

import SwiftUI

@main
struct InventoryManagerApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            InventoryList()
                .environment(modelData)
        }
    }
}
