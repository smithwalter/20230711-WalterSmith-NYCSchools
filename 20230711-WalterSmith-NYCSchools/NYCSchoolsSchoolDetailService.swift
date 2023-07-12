//
//  NYCSchoolsSchoolDetailService.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/12/23.
//

import Foundation
import UIKit

protocol NYCSchoolDetailsServiceDelegate {
    func SchoolDetailsUpdated(_ schools: [SchoolDetail])
}
class NYCSchoolDetailsService {
    var delegate : NYCSchoolDetailsServiceDelegate?
    
    func getSchoolDetails() {
        getSchoolDetailsFromService()
    }
    func createURI() -> String {
        // was planning to use api functionality to fetch data school by school, but didn't have time to get synchronicity right.
        return "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"//?dbn=\(dbn)"
    }
    func getSchoolDetailsFromService() {
        if let url = URL(string:createURI()) {
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                if let data = data {
                    self?.decodeSchoolDetails(data)
                } else {
                    print(error)
                }
            }
            task.resume()
        } else {
            print("url error")
        }
    }
    
    // Easier to just downloas the data and get from XCAssets
    func getTestSchools() {
        if let asset = NSDataAsset(name: "f9bf-2cp4") {
            decodeSchoolDetails(asset.data)
        }
    }
    
    func decodeSchoolDetails(_ data:Data) {
        do {
            let schoolDetails = try JSONDecoder().decode([SchoolDetail].self, from:data)
            self.delegate?.SchoolDetailsUpdated(schoolDetails)
        } catch {
            print(error)
        }
    }
}
