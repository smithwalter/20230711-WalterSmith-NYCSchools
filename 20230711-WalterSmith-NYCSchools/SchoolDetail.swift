//
//  SchoolDetails.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/12/23.
//

import Foundation

struct SchoolDetail : Codable {
    let dbn : String
    let school_name : String
    let num_of_sat_test_takers : String
    let sat_critical_reading_avg_score : String
    let sat_math_avg_score : String
    let sat_writing_avg_score : String
}
