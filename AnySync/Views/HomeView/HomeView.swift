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
    
    var body: some View {
        NavigationView {
            
            if viewModel.buttons.count < 1 {
                Text("You currently have no syncs.")
                    .font(.headline )
                    .navigationBarTitle("Syncs")
                        .toolbar {
                            Button(action: {
                                self.isShowingAddView.toggle()
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(Font.title.weight(.semibold))
                            })
                        }
                        .buttonStyle(PlainButtonStyle())
                
            } else {
                List{
                    ForEach(viewModel.buttons, id: \.id){ rowButton in
                        HomeRowView(syncButton: rowButton, vm: viewModel)
                        .padding(.vertical)
                      
                    }  .onDelete { (index) in
                       
                        viewModel.unsubscribeToButton(index)
                    }
                }
                .navigationBarTitle("Syncs")
                    .toolbar {
                        Button(action: {
                            self.isShowingAddView.toggle()
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .font(Font.title.weight(.semibold))
                        })
                    }
                    .buttonStyle(PlainButtonStyle())
                    
            }
            
            
        }.sheet( isPresented: $isShowingAddView, content: {
            AddView(addViewModel: AddViewModel(homeVM: self.viewModel), showSheetView: $isShowingAddView)
        })
        .onAppear(perform: {
            viewModel.loadButtonsFromDefaults()
        })
            
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
