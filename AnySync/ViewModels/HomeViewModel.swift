//
//  HomeViewModel.swift
//  AnySync
//
//  Created by Atlas on 3/6/21.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeViewModel: ObservableObject {
    @Published var buttons = [SyncButton]()
    var subscriber = Subscriber()
    let defaults = UserDefaults.standard
    let db = Firestore.firestore()

    // Upstream
    func sendButtonPush(_ buttonID : String) {
        // Adds a new press record to firebase under "presses"
        
    }
    
    // Downstream
    func subscribeToButton(button: SyncButton) {
        // TODO: Three things:
        // 1. save the button to local defaults - OK
        // 2. send subscriber object to firebase under "subscriber" - OK
        // 3. puts a button inside the @State buttons - OK
    
        // talk to firebase
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        
        if let token = defaults.string(forKey: "notificationToken") {
            subscriber.deviceNotificationToken = token
           ref = db.collection("buttons").document("\(button.id)").collection("subscribers").document("\(subscriber.uuid! as String)")
            ref!.setData([
                "uuid": subscriber.uuid! as String,
                "token": subscriber.deviceNotificationToken
            ], merge: false){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                    // Lets crash yay!
                    fatalError()
                } else {
                    print("added subscription for \(self.subscriber.uuid!)")
                    self.saveButtonsToDefaults(button: button)
                }
            }
        } else {
            // bao cuo
            fatalError()
        }
        
        
    }
    
    // Persistence
    func loadButtonsFromDefaults() {
        // This reads the buttons from defaults
        if let data = UserDefaults.standard.value(forKey:"buttons") as? Data {
            do {
                self.buttons = try PropertyListDecoder().decode(Array<SyncButton>.self, from: data)
            } catch {
                // bao cuo
                fatalError("sebastian ate shit")
            }
        }
    }
    
    func saveButtonsToDefaults(button: SyncButton) {
        buttons.append(button)
        defaults.setValue(try? PropertyListEncoder().encode(buttons), forKey: "buttons")
        self.loadButtonsFromDefaults()
    }
    
}
