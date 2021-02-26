//
//  AcccountView.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import Foundation
import SwiftUI
import MapKit

struct Acccount: View {
    
    @ObservedObject var ChatModel = ChatRoomViewModel()
    
    init() {
        ChatModel.fetchData()
    }
    
    
    @ObservedObject var session = Session()
    var body : some View {
        
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                TopView()
                    .padding(.top,100)
                MainView()
            }
            
            
            
            
        }
        
        
    }
    
    
}


struct AcccountView_Previews: PreviewProvider {
    static var previews: some View {
        Acccount()
    }
}


struct TopView: View {
    var body: some View{
        
        
        VStack {
            HStack{
                ZStack{
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 130, height: 130, alignment: .center)
                    Circle()
                        .fill(LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 120, height: 120, alignment: .center)
                    Image("frog")
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                    
                }
            }
            Text("Dom")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }.padding(.vertical,10)
        
        
    }
}

struct MainView: View {
    
    let iconImage = ["user-2","settings","layer","insurance","group","placeholder"]
    
    @AppStorage("DarkMode") private var Mode = false
    
    @ObservedObject var session = Session()
    
    @State var isOn: Bool = false
    @State var setting: Bool = false
    @State var security: Bool = false
    @State var map: Bool = false
    
    
    var body: some View{
        
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundColor(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                    .shadow(radius: 4)
                    .frame(width: UIScreen.main.bounds.width, height: 600, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                ScrollView{
                    
                    ForEach(0..<6){ i in
                        HStack{
                            ZStack {
                                
                                if (i == 0){
                                    
                                    
                                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                                        .frame(width: 350, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                        .padding(.top,15)
                                    
                                    HStack{
                                        Image("\(iconImage[i])")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        Spacer()
                                        if i == 0 {
                                            TextUserInfo()
                                        }
                                        else if i == 5{
                                            Button(action: {
                                                self.map = true
                                              
                                            }, label: {
                                                Text("Map")
                                                    .fontWeight(.bold)
                                                    .padding(.trailing,100)
                                                    .padding(40)
                                                    .font(.system(size: 20))
                                                    .font(.title)
                                                    .foregroundColor(.black)
                                                
                                            })
                                            .sheet(isPresented: $map, content: {
                                                VetMap()
                                                
                                            })
                                            
                                        }
                                        
                                    }.padding()
                                    
                                }
                                else if i == 5{
                                    
                                    
                                    
                                    
                                    Button(action: {
                                        self.map = true
                                    }, label: {
                                        
                                        ZStack{
                                            Image("apple-maps-duckduckgo-100785363-large")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 350, height: 150)
                                                .cornerRadius(30)
                                                .shadow(radius: 5)
                                                .padding(.top,10)
                                                .padding(.bottom,10)
                                            
                                            HStack {
                                                Image("placeholder")
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                    .padding()
                                                Spacer()
                                                Text("Map")
                                                    .fontWeight(.bold)
                                                    .padding(.trailing,150)
                                                    .font(.system(size: 20))
                                                    .font(.title)
                                                    .foregroundColor(.black)
                                            }
                                            
                                        }
                                        
                                    })
                                    .sheet(isPresented: $map, content: {
                                       VetMap()
                                    })
                                    
                                }
                                else{
                                    
                                    
                                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                                        .frame(width: 350, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                    
                                    HStack{
                                        Image("\(iconImage[i])")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        Spacer()
                                        
                                        
                                        if i == 1{
                                            
                                            Button(action: {
                                                self.setting = true
                                            }, label: {
                                                Text("   Setting ").padding(.trailing,195)
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.black)
                                                
                                            }).sheet(isPresented: $setting, content: {
                                                
                                            })
                                            
                                        }
                                        else if i == 2{
                                            Text("Theme").padding()
                                                .font(.system(size: 20))
                                            Toggle(isOn: $isOn){
                                                
                                            }
                                        }
                                        else if i == 3{
                                            Button(action: {
                                                self.security = true
                                            }, label: {
                                                
                                                Text("Security").padding(.trailing,195)
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.black)
                                            }).sheet(isPresented: $security, content: {
                                                
                                            })
                                            
                                        }
                                        else{
                                            Button(action: {
                                                session.signOut()
                                            }, label: {
                                                Text("Sign out").padding(.trailing,195)
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.black)
                                                
                                            })
                                        }
                                        
                                        
                                        
                                    }.padding()
                                }
                                
                                
                                
                            }
                        }.padding(.vertical,5)
                        .padding(.horizontal)
                        
                    }
                }.padding(.top,5)
                .padding(.bottom,130)
                
                
            }
            
        }
        
        
    }
}

struct Blur : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Blur>) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialLight))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Blur>) {
        
    }
    
}

struct TextUserInfo : View {
    
    var body: some View{
        VStack(spacing:10){
            HStack{
                Text("Dom khomsan Bangbor")
                    .padding(.trailing,60)
                
            }
            Text("domkhomsan789@hotmail.com")
        }
    }
}
