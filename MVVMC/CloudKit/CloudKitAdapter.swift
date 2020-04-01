//
//  CloudKitAdapter.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 31/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitAdapter: ToursListViewDelegate {
    
    private let adaptee: CloudKitService
    
    init(){
        adaptee = CloudKitService()
    }
    
    func refresh(_ completion: @escaping ([String]?) -> Void) {
        var response: [String]?
        adaptee.refresh({ (result) in
            if let error = result.error {
            print(error.localizedDescription)
            return
            } else {
                if let records = result.records {
                    response = records.compactMap({
                        self.deployRecord(record: $0)
                    })
                    completion(response)
                }
            }
        })
    }
    
    func deployRecord(record: CKRecord) -> String {
        guard let title = record["title"] as? String else { return "404"}
        return title
    }
}
