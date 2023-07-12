//
//  NYCSchoolsSchoolDetailService.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/12/23.
//

import Foundation
import UIKit

protocol NYCSchoolDetailsServiceDelegate {
    func SchoolDetailsUpdated(_ schoolDetails: SchoolDetails)
}
class NYCSchoolDetailsService {
    var delegate : NYCSchoolDetailsServiceDelegate?
    var getting : Bool = false
    
    func getSchoolDetails(_ dbn: String) {
        if (getting) {
            //getTestSchools(dbn)
        } else  {
            getSchoolDetailsFromService(dbn)
            getting = true
        }
    }
    func createURI(_ dbn : String) -> String {
        return "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"//?dbn=\(dbn)"
    }
    func getSchoolDetailsFromService(_ dbn : String) {
        if let url = URL(string:createURI(dbn)) {
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
                if let data = data {
                    self?.decodeSchoolDetails(data, dbn)
                } else {
                    print(error)
                }
            }
            task.resume()
        } else {
            print("url error")
        }
    }
    func getTestSchools(_ dbn: String) {
        if let asset = NSDataAsset(name: "f9bf-2cp4") {
            decodeSchoolDetails(asset.data,dbn)
        }
    }
    func decodeSchoolDetails(_ data:Data, _ dbn : String) {
        do {
            let schoolDetailss = try JSONDecoder().decode([SchoolDetails].self, from:data)
            let detailss = schoolDetailss.filter({return $0.dbn == dbn})
            if detailss.count > 0 {
                let details = detailss[0]
                delegate?.SchoolDetailsUpdated(details)
            }
        } catch {
            print(error)
        }
    }
}
