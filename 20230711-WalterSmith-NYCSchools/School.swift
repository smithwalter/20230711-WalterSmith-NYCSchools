//
//  School.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/11/23.
//

import Foundation

struct School : Decodable,Identifiable {
    let school_name : String
    let dbn : String
    let id : UUID? = UUID()
}
