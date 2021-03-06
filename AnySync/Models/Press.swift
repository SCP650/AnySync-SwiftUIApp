//
//  Press.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import UIKit

// This is the payload for button pressed

struct Press {
    let id = "w19ic"
    let uuid = UIDevice.current.identifierForVendor?.uuidString
    let timestamp = Date()
}
