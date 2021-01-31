//
//  FirstScreen.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-31.
//

import SwiftUI

struct FirstScreen: View {
    
    var body: some View {
        
        ZStack{
            Color(red: 224/255, green: 229/255, blue: 236/255)
                .ignoresSafeArea()
            
           TabView{
               
                Home()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                Chat()
                    .tabItem {
                        Image(systemName: "ellipsis.bubble")
                        Text("Chat")
                    }
                Acccount()
                    .tabItem {
                        Image("082-dog-paw")
                            .foregroundColor(Color.blue)
                        Text("Account")
                           
                    }
                
           }.accentColor(Color.green)
            
        }
        
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
