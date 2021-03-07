//
//  AddViewModel.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import SwiftUI

class AddViewModel: ObservableObject {
    
    // MARK: Form element states
    @State var buttonName = ""
    @State var discoverableTime = 0
    
    // MARK: New Button
    func createNewButton() {
        // TODO: Three things
        // 1. create a new button document under firebase
        // 2. create a new subscription in new button document created
        // 3. get button document and call the persistence function in HomeVM to save to local
        
    }
}
