//
//  ContentView.swift
//  20230711-WalterSmith-NYCSchools
//
//  Created by Walter Smith on 7/11/23.
//

import SwiftUI

struct NYCSchoolsContentView: View {
    @ObservedObject var delegate = NYCSchoolsContentViewDelegate()
    var body: some View {
        NavigationStack {
            VStack {
                Text("NYC Schools")
                Text("(click for details")
                Table(delegate.schools) {
                    //TableColumn("school_name", value: \.school_name)
                    TableColumn("Schools", content: {NYCSchoolsRow(school: $0,delegate: self)})
                }
            }
        }
    }
}

struct NYCSchoolsRow: View {
    var school : School
    var delegate : any View
    var body: some View {
        Text(school.school_name).onTapGesture {
            //load NYCSchoolDetailView
        }
    }
}
protocol NYCSchoolDetailViewDelegate {
    var details : SchoolDetails {get}
    func getDetails(forSchool:String)
}
struct NYCSchoolDetailView: View {
    var delegate : NYCSchoolDetailViewDelegate
    var school : School
    init(_ delegate : NYCSchoolDetailViewDelegate,_ school : School) {
        self.delegate = delegate
        self.school = school
        if (school.dbn != delegate.details.dbn) {
            self.delegate.getDetails(forSchool: school.dbn)
        }
    }
    var body : some View {
        Text(delegate.details.dbn)
    }
}

struct NYCSchoolsContentView_Previews: PreviewProvider {
    static var previews: some View {
        NYCSchoolsContentView()
    }
}
