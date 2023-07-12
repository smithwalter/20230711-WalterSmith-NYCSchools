//
//  NYCSchoolsService.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/12/23.
//

import Foundation
import UIKit

protocol NYCSchoolsServiceDelegate {
    func SchoolsListUpdated(_ schools: [School])
}
class NYCSchoolsService {
    var schools : [School]?
    var delegate : NYCSchoolsServiceDelegate?
    
    func getSchools() {
        if let data = getTestSchools() {
            if let schools = decodeSchools(data) {
                delegate?.SchoolsListUpdated(schools)
                self.schools = schools
            }
        }
    }
    
    // it was easier to just download the dataset and read it from XCAssets
    func getTestSchools() -> Data? {
        if let asset = NSDataAsset(name: "s3k6-pzi2") {
                return asset.data
        }
        return nil
    }
    func getSchoolsFromService(_ URI : String) -> Data? {
        return nil
    }
    func decodeSchools(_ data:Data) -> [School]? {
        do {
            return try JSONDecoder().decode([School].self, from:data)
        } catch {
            print(error)
            return nil
        }
    }
}
