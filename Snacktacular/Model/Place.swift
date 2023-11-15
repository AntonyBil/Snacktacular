//
//  Place.swift
//  PlaceLookupDemo
//
//  Created by apple on 13.11.2023.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID().uuidString
    private var mapItem: MKMapItem
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    var name: String {
        self.mapItem.name ?? ""
    }
    
    var address: String {
        let placemark = self.mapItem.placemark
        var cityAndState = ""
        var address = ""
        
        cityAndState = placemark.locality ?? "" //city
        if let state = placemark.administrativeArea {
            //Show either state or city, state
            cityAndState = cityAndState.isEmpty ? state : "\(cityAndState) \(state)"
        }
        
        address = placemark.subThoroughfare ?? "" //addres #
        if let street = placemark.thoroughfare {
            //Show the street unless there is a street # hen add space + street
            address = address.isEmpty ? street : "\(address) \(street)"
        }
        
        if address.trimmingCharacters(in: .whitespaces).isEmpty && !cityAndState.isEmpty {
            //No adress? Then just cityAndStatewith no space
            address = cityAndState
        } else {
            //No sityAndState? Then just address, otherwise address, cityAndState
            address = cityAndState.isEmpty ? address : "\(address), \(cityAndState)"
        }
        
        return address
    }
    
    var latitude: CLLocationDegrees {
        self.mapItem.placemark.coordinate.latitude
    }
    var longitude: CLLocationDegrees {
        self.mapItem.placemark.coordinate.longitude
    }
    
}
