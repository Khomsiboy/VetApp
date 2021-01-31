//
//  AcccountView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import Foundation
import SwiftUI

struct Acccount: View {
    
    @ObservedObject var session = Session()
    var body : some View {
        VStack{
            Text("Account")
            Button(action: {
                session.signOut()
            }, label: {
                Text("Sign Out")
            })
        }
      
    
    }
    
    
}


struct AcccountView_Previews: PreviewProvider {
    static var previews: some View {
        Acccount()
    }
}
