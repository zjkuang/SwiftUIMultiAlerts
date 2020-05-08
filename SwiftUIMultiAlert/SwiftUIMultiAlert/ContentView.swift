//
//  ContentView.swift
//  SwiftUIMultiAlert
//
//  Created by Zhengqian Kuang on 2020-05-08.
//  Copyright © 2020 Kuangs. All rights reserved.
//

import SwiftUI

// How can I have two alerts on one view in SwiftUI? https://stackoverflow.com/a/58069775/5424189
// Here we tried another method with a ViewAlert and an AlertActionDelegate which is a good example in practicing "associatedtype" and "typealias"

protocol AlertActionDelegate {
    associatedtype V
    func onAlertActionConfirm(alert: V)
}

protocol ViewAlert {
    func alertView<D: AlertActionDelegate>(delegate: D) -> Alert
}

enum ContentViewAlert: ViewAlert {
    case none
    case alert1, alert2
    
    func alertView<D>(delegate: D) -> Alert where D : AlertActionDelegate {
        var title = ""
        var message = ""
        switch self {
        case .none:
            break
        case .alert1:
            title = "ALERT 1"
            message = "Confirm?"
        case .alert2:
            title = "ALERT 2"
            message = "Confirm?"
        }
        return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Yes")) {
            delegate.onAlertActionConfirm(alert: self as! D.V)
        }, secondaryButton: .cancel())
    }
}

struct ContentView: View, AlertActionDelegate {
    typealias V = ContentViewAlert
    
    @ObservedObject var viewModel = ContentViewModel()
    
    @State var showAlert = false
    @State var alert: ContentViewAlert = .none
    func onAlertActionConfirm(alert: V) {
        switch alert {
        case .alert1:
            viewModel.doOne()
        case .alert2:
            viewModel.doTwo()
        default:
            break
        }
    }
    
    var body: some View {
        NavigationView{
            Group {
                List {
                    ForEach(viewModel.listData) { item in
                        Text(item.title.rawValue)
                            .onTapGesture {
                                self.itemTapped(item)
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    return alert.alertView(delegate: self)
                }
            }
            .navigationBarTitle(Text("List"))
        }
        .navigationViewStyle(StackNavigationViewStyle()) // to stop it from showing as split view
    }
    
    private func itemTapped(_ item: ContentViewListItem) {
        switch item.title {
        case .one:
            alert = .alert1
        case .two:
            alert = .alert2
        }
        self.showAlert.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
