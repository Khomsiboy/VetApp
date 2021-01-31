//
//  LogInView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import SwiftUI

struct LogInView: View {
    
    @State var email = ""
    @State var password = ""
    @ObservedObject var session = Session()
    
    var body: some View {
        
        ZStack{
            Color(red: 224/255, green: 229/255, blue: 236/255)
                .ignoresSafeArea()
            
            
            
            
            NavigationView{
            
                
              
                
                VStack{
                    Button(action: {
                        print("Press")
                    }, label: {
                        Image(systemName: "cross.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .shadow(color: Color.white, radius: 8, x: -8.0, y: -8.0)
                            .shadow(color: Color(red: 163/255, green: 177/255, blue: 198/255), radius: 8, x: 9.0, y: 9.0)
                            .padding()
                            .background(Color(red: 224/255, green: 229/255, blue: 236/255))
                            .cornerRadius(250.0)
                            .foregroundColor(.green)
                            .position(x: 90, y: -245)
                        
                    }).frame(width: 0.5, height: 0.5)
                    .shadow(color: Color.white, radius: 8, x: -8.0, y: -8.8)
                    .shadow(color: Color(red: 163/255, green: 177/255, blue: 198/255), radius: 8, x: 9.0, y: 9.0)
                    
                  
                    
                    
                    TextField("Email",text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password",text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        session.signIn(email: email, password: password)
                        print("yes")
                    }, label: {
                        Text("Login")
                    })
                    .padding(.all,30)
                    Button(action: {
                        session.signUp(email: email, password: password)
                        print("yes")
                    }, label: {
                        Text("Sign Up")
                    })
                    
                }
                
                
                .navigationBarTitle("Welcome")
                
                
            }
        }
        
       
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
