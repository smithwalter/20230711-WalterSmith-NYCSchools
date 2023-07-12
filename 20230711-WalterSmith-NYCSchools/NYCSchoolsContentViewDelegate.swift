//
//  NYCSchoolContentViewDelegate.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/11/23.
//

import Foundation

class NYCSchoolsContentViewDelegate : NSObject,
                                      ObservableObject,
                                      NYCSchoolsServiceDelegate,
                                      NYCSchoolDetailsServiceDelegate,
                                      NYCSchoolDetailViewDelegate {

    @Published var schools : [School]
    @Published var details : SchoolDetails
    
    var _schoolService : NYCSchoolsService
    var _detailsService : NYCSchoolDetailsService
    
    func SchoolDetailsUpdated(_ schoolDetails: SchoolDetails) {
        self.details = schoolDetails
    }
    
    func SchoolsListUpdated(_ schools: [School]) {
        self.schools = schools
    }
    
    func getDetails(forSchool : String) {
        _detailsService.getSchoolDetails(forSchool)
    }
    
    override init() {
        self.schools = [School]()
        self.details = SchoolDetails(dbn: "", school_name: "", num_of_sat_test_takers: "", sat_critical_reading_avg_score: "0", sat_math_avg_score: "0", sat_writing_avg_score: "0")
        self._schoolService = NYCSchoolsService()
        self._detailsService = NYCSchoolDetailsService()
        
        super.init()
        
        _schoolService.delegate = self
        _detailsService.delegate = self
        _schoolService.getSchools()
    }
}
