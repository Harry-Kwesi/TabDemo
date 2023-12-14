//
//  CustomTab.swift
//  PinnedTabDemo
//
//  Created by Harry Kwesi De Graft on 14/12/23.
//

import SwiftUI

struct CustomTab: View {
    @State private var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ContentView().tag(1)
            Text("Tab Content 2").tag(2)
            Text("Tab Content 3").tag(3)
            Text("Tab Content 4").tag(4)
            Text("Tab Content 5").tag(5)
        }.overlay(alignment: .bottom){
            CustomTabView(tableSelection:$tabSelection)
        }
    }
}

#Preview {
    CustomTab()
}
