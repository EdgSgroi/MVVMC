//
//  TourViewController.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 30/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation
import UIKit

class TripsViewController: UIViewController {
    let viewModel: TripsViewModel = TripsViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func addTour(tour: TourStruct) {
        viewModel.newTour(title: tour.title)
    }
    
}

extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tourcell") as? TourTableViewCell
        
        cell?.title.text = viewModel.getTourTitle(at: indexPath.row)
        return cell ?? TourTableViewCell()
    }
}

extension TripsViewController: UITableViewDelegate {
    
}
