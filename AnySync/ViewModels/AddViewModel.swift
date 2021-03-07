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
    let homeVM: HomeViewModel
    let defaults = UserDefaults.standard
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
    }
    
    // MARK: Form element states
    @Published var buttonName = ""
    @Published var discoverableTime = 2600
    
    // MARK: New Button
    func createNewButton(completion: @escaping (String) -> Void, onFailure: @escaping (String) -> Void) {
        
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("buttons").addDocument(data: [
            "name": self.buttonName,
            "time_interval": self.discoverableTime
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                // Lets crash yay!
                onFailure("done")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                let theButton =  SyncButton(id: ref!.documentID, name: self.buttonName, timeInterval: self.discoverableTime)
                self.homeVM.subscribeToButton(button: theButton)
                UIPasteboard.general.string = "anysync://\(ref!.documentID)"
                completion(ref!.documentID)
            }
        }
        
        
        
        // TODO: Three things
        // 1. create a new button document under firebase - OK
        // 2. create a new subscription in new button document created 
        // 3. get button document and call the persistence function in HomeVM to save to local - OK

    }

}
