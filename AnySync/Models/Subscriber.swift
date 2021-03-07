//
//  Subscription.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import UIKit
import FirebaseMessaging

struct Subscriber: Codable {
    var uuid = UIDevice.current.identifierForVendor?.uuidString
    
    // TODO: add notification token here
    var deviceNotificationToken = ""
}
