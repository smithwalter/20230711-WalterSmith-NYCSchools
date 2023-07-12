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
    

    // This data doesn't change much and should be placed in a persistent store
    // TODO: add coredata
    @Published var schools : [School]
    var schoolDetails : [SchoolDetail]
    
    var _schoolService : NYCSchoolsService
    var _detailsService : NYCSchoolDetailsService
    
    func SchoolDetailsUpdated(_ schoolDetails: [SchoolDetail]) {
        self.schoolDetails = schoolDetails
    }
    
    // Sorting by name. Would love to add options, but time constraints
    func SchoolsListUpdated(_ schools: [School]) {
        self.schools = schools.sorted(by: {$0.school_name < $1.school_name})
    }
    
    // Using a filter to search an array. Will need to use a more efficient method if dataset gets significantly bigger
    func getDetails(forSchool : School) -> SchoolDetail? {
        let details = schoolDetails.filter({$0.dbn == forSchool.dbn})
        return details.count > 0 ? details[0] : nil
    }
    
    override init() {
        self.schools = [School]()
        self.schoolDetails = [SchoolDetail]()
        self._schoolService = NYCSchoolsService()
        self._detailsService = NYCSchoolDetailsService()
        
        super.init()
        
        // Data doesn't change muchm so updating on app load should be enough
        _schoolService.delegate = self
        _detailsService.delegate = self
        _schoolService.getSchools()
        _detailsService.getSchoolDetails()
    }
}
