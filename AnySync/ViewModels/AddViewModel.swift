//
//  AddViewModel.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddViewModel: ObservableObject {
    
    // MARK: Form element states
    @Published var buttonName = ""
    @Published var discoverableTime = 2600
    
    // MARK: New Button
    func createNewButton() {
        
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("buttons").addDocument(data: [
            "name": self.buttonName,
            "time_interval": self.discoverableTime
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
        // TODO: Three things
        // 1. create a new button document under firebase
        // 2. create a new subscription in new button document created
        // 3. get button document and call the persistence function in HomeVM to save to local
        
    }
}
