//
//  CloudKitService.swift
//  MVVMC
//
//  Created by Edgar Sgroi on 31/03/20.
//  Copyright © 2020 Edgar Sgroi. All rights reserved.
//

import Foundation
import CloudKit

public struct CloudKitResponse {
    var error: CKError?
    var records: [CKRecord]?
}

class CloudKitService {
    
    var container: CKContainer
    var publicDB: CKDatabase
    var privateDB: CKDatabase
    var tours: [Any] = []
    var records: [CKRecord]?
    
    init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
        
    }
    
    func refresh(_ completion: @escaping (CloudKitResponse) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Tour", predicate: predicate)
        publicDB.perform(query, inZoneWith: CKRecordZone.default().zoneID) {
            [weak self] results, error in
            guard let self = self else { return }
            if let error = error as? CKError {
                DispatchQueue.main.async {
                    completion(CloudKitResponse(error: error, records: nil))
                }
                return
            }
            guard let results = results else { return }
            self.records = results
            DispatchQueue.main.async {
                completion(CloudKitResponse(error: nil, records: results))
            }
        }
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
            self.records = results
//            self.tours = results.compactMap {
////                self.deployRecord(record: $0, database: self.publicDB)
//                self.tours.append(self.deployRecord(record: $0, database: self.publicDB))
//            }
            
//            self.viewModel.newTour(tours: tours)
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    func deployRecord(record: CKRecord, database: CKDatabase) -> String {
        guard let title = record["title"] as? String else { return "404"}
        return title
    }

}
