//
//  MapViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var selectedRegion: Region?
    var selectedCity: String?
    var casinosInCity: [Casino] = []

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        geocodeAndAddAnnotations()
    }

    func geocodeAndAddAnnotations() {
        guard let region = selectedRegion, let city = selectedCity else {
            return
        }

        let filteredCasinos = casinosInCity.filter { casino in
            return casino.location.country == region.country && casino.location.city == city
        }

        for casino in filteredCasinos {
            
            let geocoder = CLGeocoder()
            let addressString = casino.location.address!
            
            print(addressString)
            
            geocoder.geocodeAddressString(addressString) { (placemarks, error) in
                if let error = error {
                    print("Ошибка геокодра: \(error.localizedDescription)")
                    return
                }
                
                if let location = placemarks?.first?.location {
                    let annotation = MKPointAnnotation()
                    annotation.title = casino.title
                    annotation.coordinate = location.coordinate
    
                    self.mapView.addAnnotation(annotation)
                    
                    let annotations = self.mapView.annotations
                    self.mapView.showAnnotations(annotations, animated: true)

                    if let firstAnnotation = annotations.first {
                        let regionRadius: CLLocationDistance = 6500
                        let region = MKCoordinateRegion(
                            center: firstAnnotation.coordinate,
                            latitudinalMeters: regionRadius,
                            longitudinalMeters: regionRadius
                        )
                        self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
                    }
                }
            }
        }

        let annotations = mapView.annotations
        mapView.showAnnotations(annotations, animated: true)
    
    }
}
