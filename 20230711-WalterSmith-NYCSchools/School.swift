//
//  School.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/11/23.
//

import Foundation

struct School : Codable,Identifiable,Hashable {
    
    let id : UUID? = UUID()
    
    let school_name : String
    let dbn : String
    let overview_paragraph : String
    let location : String
    let phone_number : String
}
