//
//  ToursListViewController.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 30/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation
import UIKit

class ToursListViewController: UIViewController {
    let viewModel: ToursListViewModel = ToursListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self,
        selector: #selector(reloadUI),
        name: .updateTours,
        object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshData()
        tableView.reloadData()
    }
    
    func addTour(tour: TourStruct) {
        viewModel.newTour(title: tour.title)
    }
    
    @objc func reloadUI() {
        tableView.reloadData()
    }
}

extension ToursListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tourcell") as? TourTableViewCell
        
        cell?.title.text = viewModel.getTourTitle(at: indexPath.row)
        return cell ?? TourTableViewCell()
    }
}

extension ToursListViewController: UITableViewDelegate {
    
}
