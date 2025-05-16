//
//  Item.swift
//  TaskSwift
//
//  Created by PC-0065_Kota.Akatsuka on 2025/05/17.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
