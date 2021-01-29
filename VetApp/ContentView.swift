//
//  ContentView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            Color(red: 224/255, green: 229/255, blue: 236/255)
                .ignoresSafeArea()
            
            Button(action: {}){
                Image(systemName: "cross.fill")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .padding()
                    .background(Color(red: 224/255, green: 229/255, blue: 236/255))
                    .cornerRadius(250.0)
                    
                    
            }.shadow(color: Color.white, radius: 8, x: -8.0, y: -8.8)
            .shadow(color: Color(red: 163/255, green: 177/255, blue: 198/255), radius: 8, x: 9.0, y: 9.0)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
