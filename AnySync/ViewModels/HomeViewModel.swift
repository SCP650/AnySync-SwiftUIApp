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
        if let token = defaults.string(forKey: "notificationToken") {
            subscriber.deviceNotificationToken = token
            db.collection("buttons").document("\(buttonID)").collection("presses").addDocument(data: [
                "time_pressed": Date(),
                "uuid": subscriber.uuid! as String
            ], completion: { (err) in
                if err != nil {
                    // bao cuo
                    fatalError()
                }
                print("I pressed")
            })
        } else {
            // bao cuo
            fatalError()
        }
    }
    
    // Downstream
    func subscribeToButton(button: SyncButton) {
        // 1. save the button to local defaults
        // 2. send subscriber object to firebase under "subscriber"
        // 3. puts a button inside the @State buttons
    
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
    
    func loadButtonFromRemote(_ buttonID: String) {
        db.collection("buttons").document("\(buttonID)").getDocument { (doc, err) in
            if err != nil {
                // bao cuo
                fatalError()
            } else {
                let name = doc?.get("name") as! String
                let timeInterval = doc?.get("time_interval") as! Int
                let newButton = SyncButton(id: buttonID, name: name, timeInterval: timeInterval)
                self.subscribeToButton(button: newButton)
            }
        }
    }
    
    //delete buttons
    func unsubscribeToButton(_ button_index : IndexSet){
        let button = buttons[button_index.first ?? 0]
        buttons.remove(atOffsets: button_index)
        
        db.collection("buttons").document("\(button.id)").collection("subscribers").document("\(subscriber.uuid! as String)").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
