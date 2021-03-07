//
//  HomeView.swift
//  AnySync
//
//  Created by Atlas on 3/5/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var isShowingAddView = false
    
    // TODO: replace data source with actual data source
//    let data = [SyncButton(id: "scasc", name: "Sex", timeInterval: 3600.0), SyncButton(id: "a", name: "Play COD", timeInterval: 1800.0),
//        SyncButton(id: "c", name: "Dinner Date", timeInterval: 1800.0)]
    
    var body: some View {
        NavigationView {
            List(viewModel.buttons, id: \.id) { rowButton in
                   HomeRowView(syncButton: rowButton)
                    .padding(.vertical)
                }
                .navigationBarTitle("Syncs")
            .toolbar {
                Button(action: {
                    self.isShowingAddView.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(Font.title.weight(.semibold))
                })
            }
                .buttonStyle(PlainButtonStyle())
        }.sheet( isPresented: $isShowingAddView, content: {
            AddView(addViewModel: AddViewModel(), showSheetView: $isShowingAddView)
        })
            
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
