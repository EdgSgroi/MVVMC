//
//  TripsViewModel.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 30/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation

class TripsViewModel {
//    var tourModel: Tour
    var tours: [Tour]
    
    init(){
//        self.tourModel = tourModel
        tours = [Tour]()
    }
    
    func rowsNumber() -> Int {
        return tours.count
    }
    
    func getTourTitle(at index: Int) -> String {
        let tour = tours[index].title
        return tour
    }
    
    func newTour(title: String) {
        let tour = Tour(title: title)
        tours.append(tour)
    }
    
    /** Função feita para teste do CloudKit ----- Retirar e refatorar após funcionar*/
    func newTour(tours: [Tour]) {
        self.tours = tours
    }
}
