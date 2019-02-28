//
//  MapViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 27/02/19.
//  Copyright © 2019 FIAP. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        mapView.delegate = self
        mapView.userTrackingMode = .follow
        requestAuthorization()
    }
    
    func loadPOIs(text: String){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.region = mapView.region
        
        let search  = MKLocalSearch(request: request)
        search.start { (response, error) in
            if error == nil {
                guard let response = response else {return}
                for item in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.url?.absoluteString
                    self.mapView.addAnnotation(annotation)
                }
                
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                
            }
        }
    }
    
    func requestAuthorization(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
    }

}


extension MapViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        loadPOIs(text: searchBar.text!)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {return}
        let coordinates = annotation.coordinate
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let response = response, let route = response.routes.first else {return}
        }
        
    }
}
