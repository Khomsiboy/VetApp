//
//  ShowImage.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-03-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowImage: View {
    
    var imageUrl = ""
    @Binding var isOpen : Bool
    
    var body: some View {
        ZStack{
            
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                .ignoresSafeArea(.all)
            VStack{
                VStack{
                    HStack{
                        Button(action: {
                            self.isOpen = false
                        }, label: {
                            Text("Back")
                                .foregroundColor(.blue)
                        })
                        Spacer()
                    }.padding()
                   
                }
                Spacer()
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
        }
    }
}

struct ShowImage_Previews: PreviewProvider {
    static var previews: some View {
        ShowImage(isOpen: .constant(true))
    }
}
