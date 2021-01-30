//
//  Home.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-01-30.
//

import Foundation
import SwiftUI


extension Color {
    
    static let specialWhite =  Color(red: 224/255, green: 229/255, blue: 236/255)
    
}

struct MyButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal,100)
            .padding(.vertical,30)
           // .contentShape(Rectangle())
            .background(
                Group{
                    
                    if configuration.isPressed{
                        Rectangle()
                            .fill(Color.specialWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -8, y: -8)
                            .shadow(color: Color.white.opacity(0.7), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)
                            /*.overlay(
                             Rectangle()
                                .stroke(Color.gray,lineWidth: 4)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(Rectangle().fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                            )*/
                    }else{
                        Rectangle()
                            .fill(Color.specialWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -8.0, y: -8.0)
                    }
                    
                }
                
                .frame(width: 280, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                
            
            )
           
    }

}


struct Home: View {
    
    let textArray = ["Feber & trötthet","Hud & päls","Sår & skador","Luftvägar","Mage & tarm","Mun & Tänder","Övrig" ]
    let imageArray = [ "frog","dog","elizabethan-collar","kidneys","diarrhea","dog-2","vaccine"]
    
    var body : some View {
        
        ZStack{
            Color(red: 224/255, green: 229/255, blue: 236/255)
                .ignoresSafeArea()
           // VStack{
                    VStack{
                        ScrollView(.vertical, showsIndicators:false){
                            ForEach(0..<7){ i in
                                if i == 0{
                                    Text("Hej Dom")
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                        .padding(.top, 100.0)
                                    Text("Vad kan vi hjälpa Viper med?")
                                        .font(.callout)
                                        .foregroundColor(Color.gray)
                                        .padding(.bottom,50.0)
                                    //cardView(n: textArray[i])
                                }
                                cardView(n: textArray[i],image: imageArray[i])
                            }
                        }
                        
                        
                    }

           // }
            
        }
        
        
       
    
        /* ZStack{
            
            Color(red: 224/255, green: 229/255, blue: 236/255)
                .ignoresSafeArea()
            
            Button(action: {
                
                
            }){
               Image(systemName: "cross.fill")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                .foregroundColor(Color.green)
                /*
                    .shadow(color: Color.white, radius: 8, x: -8.0, y: -8.0)
                    .shadow(color: Color(red: 163/255, green: 177/255, blue: 198/255), radius: 8, x: 9.0, y: 9.0)
                    .padding()
                    .background(Color(red: 224/255, green: 229/255, blue: 236/255))
                    .cornerRadius(250.0)
                    .foregroundColor(.green)
                   
                    */
                    
            }/*.shadow(color: Color.white, radius: 8, x: -8.0, y: -8.8)
            .shadow(color: Color(red: 163/255, green: 177/255, blue: 198/255), radius: 8, x: 9.0, y: 9.0)*/
            .buttonStyle(MyButton())
            
        }*/
    }
    
    
}


struct cardView : View {
    
    var n : String
    var image: String
    var body: some View{
        
        ZStack{
            
            VStack{
                Button(action: {
                    
                }){
                    Image("\(image)")
                        .resizable()
                        .frame(width: 80, height: 80, alignment: .center)
                    .position(x: 10, y: 60)
                    //.foregroundColor(Color.green)
                }
                
            }
            .padding()
            .buttonStyle(MyButton())
            .frame(width: 390, height: 200, alignment: .center)
            Text("\(n)")
                .foregroundColor(Color.gray)
                .position(x: 140, y: 60)
                .frame(width: 200, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            /*.frame(width: 340, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(20)
            .contentShape(Rectangle())
            .padding(10)
            .shadow(color: Color.white, radius: 8, x: -8.0, y: -8.8)
            .shadow(color: Color(red: 163/255, green: 177/255, blue: 198/255), radius: 8, x: 9.0, y: 9.0)*/

   
        }
    }
        
       
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
