//
//  HomeRowView.swift
//  AnySync
//
//  Created by Kevin Wang on 3/5/21.
//

import SwiftUI

struct HomeRowView: View {
    var syncButton: SyncButton
    var vm: HomeViewModel
    @State var simpleAlert = false
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                vm.sendButtonPush(syncButton.id)
                simpleAlert.toggle()
            }, label: {
                Text("Sync")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.horizontal)

                    
            })
            .foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(10)
            .alert(isPresented: $simpleAlert, content: {
                Alert(title: Text("Sent!"), message: Text("If any subscribers also press the button, we will notify you!"))
        })
            Spacer()
            VStack(alignment: .leading){
                Text(syncButton.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Discoverable for \(Int(syncButton.timeInterval / 60)) minutes ")
            }
            Spacer()
        }
    }
}

//struct HomeRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeRowView(syncButton: SyncButton(id: "scasc", name: "Sex", timeInterval: 1800))
//            .preferredColorScheme(.dark)
//            .previewLayout(.fixed(width: 400, height: 100))
//    }
//}
