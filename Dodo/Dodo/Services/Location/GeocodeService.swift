//
//  GeocodeService.swift
//  Dodo
//
//  Created by Tia M on 10/20/24.
//

import Foundation
import CoreLocation

class GeocodeService {
    
    var currentPlacemark: CLPlacemark?
    
    var geoCoder = CLGeocoder()
    
    func fetchLocationFromAddress(_ addressText: String, completion: @escaping (CLLocation) -> Void) {
        
        let addressString = addressText
        geoCoder.geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemarks found")
                return
            }
            let location = placemark.location
            print("Latitude: \(location?.coordinate.latitude ?? 0), Longtitude: \(location?.coordinate.longitude ?? 0)")
            if let location = location {
                completion(location)
            }
        }
    }
    
    func fetchAddressFromLocation(_ location: CLLocation, completion: @escaping (String) -> Void) {
        geoCoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ru_RU")) { placemarks, error in
            
            if let place = placemarks?.first {
                self.currentPlacemark = place
//                                print(place.country) // страна
//                                print(place.administrativeArea)
//                                print(place.locality)
//                
//                                print(place.name) //Манеж
//                                print(place.subAdministrativeArea)
//                                print(place.subLocality) //Tverskoy District
//                                print(place.thoroughfare) //Манежная улица
//                                print(place.subThoroughfare) //номер дома
                
                var address: [String] = []
                
                if let locality = place.locality { //
                    address += [locality]
                }
                
                //                if let subLocality = place.subLocality {
                //                    address += [subLocality]
                //                }
                
                if let thoroughfare = place.thoroughfare {
                    address += [thoroughfare]
                }
                
                if let subThoroughfare = place.subThoroughfare {
                    address += [subThoroughfare]
                }
                
                let result = address.joined(separator: ", ")
                
                completion(result)
                
                
                print("->", result)
            }
        }
    }
}
