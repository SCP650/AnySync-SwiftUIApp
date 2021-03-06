//
//  AddView.swift
//  AnySync
//
//  Created by Kevin Wang on 3/6/21.
//

import SwiftUI

struct AddView: View {
    @State var name : String = ""
    @State var time : Int = 2
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Text("What is the event?")
                    TextField("e.g. Play video games!", text: $name)
                    Text("How long are you interested?")
                    Picker("", selection: $time) {
                 
                      Text("30 mins").tag(30)
                      Text("1 h").tag(60)
                    Text("1.5 h").tag(90)
                    Text("2 h").tag(120)
                    }
              
                    .pickerStyle(SegmentedPickerStyle())
                }
                Button(action: { }) {
                  Text("Create")
                }
            }.navigationBarTitle("Create Button")
           
       
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .preferredColorScheme(.dark)
    }
}
