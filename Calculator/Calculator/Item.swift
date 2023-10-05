//
//  Item.swift
//  Calculator
//
//  Created by MacBook Pro on 05/10/23.
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
