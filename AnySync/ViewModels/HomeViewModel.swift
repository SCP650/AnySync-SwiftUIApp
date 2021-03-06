//
//  HomeViewModel.swift
//  AnySync
//
//  Created by Atlas on 3/6/21.
//

import Foundation

class HomeViewModel {
    @State var buttons: SyncButton = []

    // Upstream
    func sendButtonPush() {
        // Adds a new press record to firebase under "presses"
    }
    
    // Downstream
    func subscribeToButton() {
        // TODO: Three things:
        // 1. save the button to local defaults
        // 2. send subscriber object to firebase under "subscriber"
        // 3. puts a button inside the @State buttons

    }
    
    // Persistence
    func loadButtonsFromDefaults() {
        // This reads the buttons from defaults
    }
    
}
