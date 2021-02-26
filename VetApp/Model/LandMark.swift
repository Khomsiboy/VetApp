//
//  LandMark.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-26.
//

import Foundation
import MapKit

struct LandMark {
    
    let placemark : MKPlacemark
    
    var id : UUID{
        return UUID()
    }
    
    var name : String{
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinator : CLLocationCoordinate2D{
        self.placemark.coordinate
    }
    
}
