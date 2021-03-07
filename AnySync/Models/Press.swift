//
//  Press.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import UIKit

// This is the payload for button pressed

struct Press: Codable, Identifiable {
    var id = "w19ic"
    var uuid = UIDevice.current.identifierForVendor?.uuidString
    var timestamp = Date()
}
