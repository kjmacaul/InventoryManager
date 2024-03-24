//
//  InventoryItem.swift
//  InventoryManager
//
//  Created by Kevin Macaulay on 3/24/24.
//

import Foundation
import SwiftUI
import UIKit

struct InventoryItem: Codable, Identifiable {
    var id: String
    var name: String
    var price: Decimal
    
    internal init(id: String, name: String, price: Decimal, imageName: String? = nil, imageData: Data? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.imageName = imageName
        self.imageData = imageData
    }
    
    private var imageName: String?
    var image: Image? {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else if let imageName = imageName {
            return Image(imageName)
        } else {
            return nil
        }
    }
    
    var imageData: Data? = nil
}
