//
//  LandMarkAnnotation.swift
//  VetApp
//
//  Created by Khomsan Bangbor  on 2021-02-26.
//

import Foundation
import MapKit

final class LandMarkAnnotation: NSObject, MKAnnotation{
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: LandMark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinator
    }
    
}
