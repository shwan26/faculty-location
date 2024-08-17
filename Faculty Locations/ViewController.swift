//
//  ViewController.swift
//  Faculty Locations
//
//  Created by Giyu Tomioka on 8/17/24.
//
import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locations: [AUPlace] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        readData()
        setInitialMapRegion()
        loadFacultyLocations()
    }
    
    func setInitialMapRegion() {
            let initialLocation = CLLocationCoordinate2D(latitude: 13.612320, longitude: 100.836808)
            let region = MKCoordinateRegion(center: initialLocation, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
    }
    
    func readData() {
        guard let url = Bundle.main.url(forResource: "Locations", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(LocationsModal.self, from: data)
            self.locations = decoded.Places
            
        }
        catch {
            print("Error: \(error)")
        }
    }

    func loadFacultyLocations() {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.facultyName
            annotation.subtitle = location.abbreviation
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.locationLat, longitude: location.locationLong)
            mapView.addAnnotation(annotation)
        }
        print("Loaded \(locations.count) places")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
                return nil
            }
            
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView.canShowCallout = true
            
            let detailButton = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = detailButton
            
            return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation, let facultyName = annotation.title {
            let faculty = locations.first { $0.facultyName == facultyName }
            let alert = UIAlertController(title: faculty?.facultyName, message: "Abbreviation: \(faculty?.abbreviation ?? "")\nCoordinates: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
