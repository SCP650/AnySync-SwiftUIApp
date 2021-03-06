//
//  AddView.swift
//  AnySync
//
//  Created by Atlas on 3/5/21.
//

import SwiftUI

struct AddView: View {
    @State var name : String = ""
    @State var time : Double = 2
    
    var body: some View {
        NavigationView{
           
            Section {
//                TextField("Button Name", text: $name)
            }
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
