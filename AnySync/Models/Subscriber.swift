//
//  Subscription.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import UIKit

struct Subscriber: Identifiable, Codable {
    var id = UIDevice.current.identifierForVendor?.uuidString
    var uuid = UIDevice.current.identifierForVendor?.uuidString
    
    // TODO: add notification token here
    var deviceNotificationToken = ""
}
