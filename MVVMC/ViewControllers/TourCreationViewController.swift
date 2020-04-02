//
//  TourCreationViewController.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 30/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation
import UIKit

struct TourStruct {
    let title: String
}

class TourCreationViewController: UIViewController {
    
    let viewModel: ToursListViewModel = ToursListViewModel()
    
    @IBOutlet weak var lblTourTitle: UITextField!
    
    @IBAction func done(_ sender: Any) {
        navigationController?.viewControllers.forEach({ (vc) in
            if let editVC = vc as? ToursListViewController {
                let tour: TourStruct = TourStruct(title: lblTourTitle.text ?? "404")
                editVC.addTour(tour: tour)
            }
        })
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
