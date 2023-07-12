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
                List(delegate.schools) { school in
                    NavigationLink(school.school_name, destination: NYCSchoolDetailView(delegate,school) )
                }
            }
        }
    }
}

struct NYCSchoolsContentView_Previews: PreviewProvider {
    static var previews: some View {
        NYCSchoolsContentView()
    }
}
