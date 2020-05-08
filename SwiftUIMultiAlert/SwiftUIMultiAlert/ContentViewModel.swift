//
//  ContentViewModel.swift
//  SwiftUIMultiAlert
//
//  Created by Zhengqian Kuang on 2020-05-08.
//  Copyright © 2020 Kuangs. All rights reserved.
//

import Foundation

enum ContentViewListItemTitle: String {
    case one = "One"
    case two = "Two"
}

struct ContentViewListItem: Identifiable {
    var id = UUID()
    var title: ContentViewListItemTitle
}

class ContentViewModel: ObservableObject {
    @Published var listData: [ContentViewListItem] = [
        ContentViewListItem(title: .one),
        ContentViewListItem(title: .two)
    ]
    
    func doOne() {
        print("Do One")
    }
    
    func doTwo() {
        print("Do Two")
    }
}
