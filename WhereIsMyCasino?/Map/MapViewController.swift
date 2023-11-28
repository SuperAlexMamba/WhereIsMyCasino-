//
//  MapViewController.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 29.11.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var cityString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = cityString
        
    }    
}
