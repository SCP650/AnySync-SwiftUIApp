//
//  AddView.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import SwiftUI

struct AddView: View {

    @ObservedObject var addViewModel: AddViewModel
    @Binding var showSheetView: Bool
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Text("What is the event?")
                    TextField("e.g. Play video games!", text: $addViewModel.buttonName)
                    Text("How long are you interested?")
                    Picker("", selection: $addViewModel.discoverableTime) {
                 
                      Text("30 mins").tag(1800)
                      Text("1 h").tag(2600)
                    Text("1.5 h").tag(5400)
                    Text("2 h").tag(7200)
                    }
              
                    .pickerStyle(SegmentedPickerStyle())
                }
                Button(action: {
                    self.addViewModel.createNewButton()
                    self.showSheetView = false
                }) {
                  Text("Create")
                }
            }.navigationBarTitle("Create Button")
           
       
            
        }
    }
}
