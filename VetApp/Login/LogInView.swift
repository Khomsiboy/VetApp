//
//  LogInView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import SwiftUI

struct LogInView: View {
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            if UIScreen.main.bounds.height > 800{
                LoginDesign()
            }else{
                
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                    LoginDesign()
                })
                
            }
            
            
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}


struct LoginDesign: View {
    
    @State var index = 0
    
    var body: some View{
        
        
        
        VStack{
            Image("undraw_relaxing_walk_mljx-removebg")
                .resizable()
                .frame(width: 250, height: 150)
            
            HStack{
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8,dampingFraction: 0.5,blendDuration:0.5)){
                        self.index = 0
                    }
                    
                    
                }, label: {
                    Text("Login")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                })
                .background(self.index == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8,dampingFraction: 0.5,blendDuration:0.5)){
                        self.index = 1
                    }
                    
                    
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                }) .background(self.index == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
            } .background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top,25)
            
            
            if index == 0 {
                Login()
            }else{
                SignUp()
                
            }
            
            Button(action: {
                
            }, label: {
                Text("Forgot password")
                    .foregroundColor(.white)
            }).padding(.top,20)
            
            HStack(spacing: 15){
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
                Text("or")
                    .foregroundColor(.white)
                Color.white.opacity(0.7)
                    .frame(width: 35, height: 1)
            }.padding(.top,10)
            HStack{
                
                Button(action: {
                    
                }, label: {
                    Image("facebook")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(5)
                }).background(Color.white)
                .clipShape(Circle())
                
                Button(action: {
                    
                }, label: {
                    Image("google")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(5)
                }).background(Color.white)
                .clipShape(Circle())
                
            }
            
            
        }.padding()
        
        /*  Button(action: {
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
         
         */
        
        
        /*  TextField("Email",text: $email)
         .textFieldStyle(RoundedBorderTextFieldStyle())
         
         SecureField("Password",text: $password)
         .textFieldStyle(RoundedBorderTextFieldStyle())
         
         Button(action: {
         session.signIn(email: email, password: password)
         print("Login suc")
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
         
         */
        
    }
}


struct Login:View {
    
    @State var email = ""
    @State var password = ""
    var data = [UserData]()
    @ObservedObject var session = Session()
    
    var body: some View{
        
        VStack{
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Email", text: self.$email)
                    
                    
                }.padding(.vertical,20)
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                    
                    
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    })
                    
                }.padding(.vertical,20)
                
                
            }
            .padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top,25)
        }
        
        
        Button(action: {
            session.signIn(email: email, password: password)
        }, label: {
            Text("Login")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: (UIScreen.main.bounds.width - 250))
                .padding(.vertical)
            
        }).background(
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            
        )
        .cornerRadius(8)
        .offset(y: -40)
        .padding(.bottom,-40)
        .shadow(radius: 8)
        
        
    }
}


struct SignUp: View {
    
    @State var userName = ""
    @State var email = ""
    @State var password = ""
    @State var repassword = ""
    @ObservedObject var session = Session()
    
    var body: some View{
        
        VStack{
            VStack{
                HStack(spacing: 15){
                    
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.black)
                    TextField("Name", text: self.$userName)
                    
                }.padding(.vertical,20)
                HStack(spacing: 15){
                    
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Email", text: self.$email)
                    
                }.padding(.vertical,20)
                Divider()
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                    
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    })
                    
                }.padding(.vertical,20)
                Divider()
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                    
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    })
                    
                }.padding(.vertical,20)
                
                
            }
            .padding(.vertical)
            .padding(.horizontal,20)
            .padding(.bottom,40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top,25)
        }
        
        
        Button(action: {
            session.signUp(name: userName,email: email, password: password)
        }, label: {
            Text("Sign Up")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: (UIScreen.main.bounds.width - 250))
                .padding(.vertical)
            
        }).background(
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            
        )
        .cornerRadius(8)
        .offset(y: -40)
        .padding(.bottom,-40)
        .shadow(radius: 8)
        
        
    }
}
