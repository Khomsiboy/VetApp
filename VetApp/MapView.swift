//
//  MapView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-26.
//

import SwiftUI

struct MapView: View {
    @State private var search: String = ""
    var body: some View {
        ZStack{
            
            TextField("Sök", text: $search, onEditingChanged: {
                _ in
            }){
                
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .offset(y: 44)
            
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
