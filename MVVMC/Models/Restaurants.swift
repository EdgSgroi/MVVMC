//
//  Restaurants.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 30/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation

struct Restaurants {
    var name: String
    var foodType: String
    var address: String
    
    init(name: String, foodType: String, address: String) {
        self.name = name
        self.foodType = foodType
        self.address = address
    }
}
