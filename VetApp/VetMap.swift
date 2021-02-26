//
//  VetMap.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-26.
//

import SwiftUI
import MapKit

struct VetMap: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var locationManager = LocationManager()
    @State private var search : String = "Djursjukhus"
    
    @State private var landMark: [LandMark] = [LandMark]()
    
    private func getNearByLandMark(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, err) in
            if let response = response{
                let mapItem = response.mapItems
                self.landMark = mapItem.map{
                    LandMark(placemark: $0.placemark)
                }
            }
        }
    }

    var body: some View {
        ZStack(alignment: .top){
            
            MapView(landMark: landMark)
                .ignoresSafeArea()
            
            HStack{
                Button("Back") {
                   presentationMode.wrappedValue.dismiss()
                   
                }
                Spacer()
            }.padding()
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        self.getNearByLandMark()
                    }, label: {
                       Image(systemName: "location.viewfinder")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.green)
                    })
                }.padding(.bottom,60)
            }
            
           
        }
    }
}

struct VetMap_Previews: PreviewProvider {
    static var previews: some View {
        VetMap()
    }
}
