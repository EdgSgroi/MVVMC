//
//  ToursListViewModel.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 30/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation

protocol ToursListViewDelegate: class {
    func refresh(_ completion: @escaping ([String]?) -> Void)
}

class ToursListViewModel {
    
    var tours: [Tour]
    
    weak var delegate: ToursListViewDelegate?
    
    init(){
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
    
    func refreshData(){
        let service = CloudKitAdapter()
        service.refresh({ response in
            if let tours: [String] = response {
            self.tours = tours.compactMap({
                Tour(title: $0)
            })
            NotificationCenter.default.post(name: .updateTours, object: nil)
        }
        })
    }
}

extension Notification.Name {
    static let updateTours = Notification.Name("update_tours_list")
}
