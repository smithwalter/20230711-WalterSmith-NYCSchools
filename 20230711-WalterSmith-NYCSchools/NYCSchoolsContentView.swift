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
        NavigationView {
            VStack {
                Text("Schools").font(.title2).foregroundColor(.blue)
                Text("(click for details)").font(.caption2).foregroundColor(.blue)
                List(delegate.schools) { school in
                    VStack {
                        NavigationLink( school.school_name,
                                        destination: NYCSchoolDetailView(delegate,school)
                        )
                    }
                    .padding()
                }
            }
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
