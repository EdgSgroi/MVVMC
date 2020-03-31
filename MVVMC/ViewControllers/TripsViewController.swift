//
//  TourViewController.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 30/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class TripsViewController: UIViewController {
    let viewModel: TripsViewModel = TripsViewModel()
    
    var container: CKContainer!
    var publicDB: CKDatabase!
    var privateDB: CKDatabase!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
        refresh({
            error in
                 if let error = error {
                   let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
                   self.tableView.refreshControl?.endRefreshing()
                   return
                 }
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
               })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func addTour(tour: TourStruct) {
        viewModel.newTour(title: tour.title)
    }
    
    @objc func refresh(_ completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Tour", predicate: predicate)
        tours(forQuery: query, completion)
    }
    
    private func tours(forQuery query: CKQuery, _ completion: @escaping (Error?) -> Void) {
        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) {
            [weak self] results, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let results = results else { return }
            let tours = results.compactMap {
                self.deployRecord(record: $0, database: self.publicDB)
            }
            self.viewModel.newTour(tours: tours)
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    func deployRecord(record: CKRecord, database: CKDatabase) -> Tour {
        guard let title = record["title"] as? String else { return Tour(title: "404")}
        return Tour(title: title)
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
