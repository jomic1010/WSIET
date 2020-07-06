//
//  ViewController.swift
//  WSIET
//
//  Created by JomiC on 2020/06/30.
//  Copyright © 2020 JomiC. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import CoreLocation
import AddressBookUI

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    // 맵의 변수 선언
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var userLocation: UILabel!
    @IBOutlet var nowLocation: UIButton!
    
    var locationName: String = "";
    
    var search_address_lati: CLLocationDegrees = 0.0
    var search_address_long: CLLocationDegrees = 0.0
    var original_address_lati: CLLocationDegrees = 0.0
    var original_address_long: CLLocationDegrees = 0.0
    
    // 위치 데이터를 받아오기 위한 LocationManager
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        // 기본 Map -> Change GoogleMap, To use Geocoding
        locationManager.delegate = self
        // 정확도 설정 (최고)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 사용자에게 위치제공 승인 요청
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트
        locationManager.startUpdatingLocation()
        
        var location = CLLocationCoordinate2D()
        if let coor = locationManager.location?.coordinate {
            location.longitude = coor.longitude
            location.latitude = coor.latitude
        }
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
        myMap.setRegion(region, animated: false)
        myMap.showsUserLocation = true
         */
        CLGeocoder().geocodeAddressString(locationName, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                print("\nlatitude: \(coordinate?.latitude), longitude: \(coordinate?.longitude)")
                
                self.original_address_lati = coordinate!.latitude
                self.original_address_long = coordinate!.longitude
            }
            
        })
    }
    
    func setNowLocation(lat: CLLocationDegrees,
                        lon: CLLocationDegrees,
                        delta span: Double) -> CLLocationCoordinate2D{
        let location = CLLocationCoordinate2DMake(lat, lon)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region = MKCoordinateRegion(center: location, span: spanValue)
        myMap.setRegion(region, animated: true)
        
        return location
    }

    @IBAction func goNowLocation(){
        
    }

}

