//
//  SearchViewController.swift
//  WSIET
//
//  Created by JomiC on 2020/07/07.
//  Copyright © 2020 JomiC. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import GoogleMaps
import CoreLocation
import AddressBookUI

class SearchViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    // 맵의 변수 선언
    var myMap: GMSMapView!
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        var location = CLLocationCoordinate2D()
        
        if let coor = locationManager.location?.coordinate {
            location.longitude = coor.longitude
            location.latitude = coor.latitude
        }
        
        // print("\nlatitude: \(coordinate?.latitude), longitude: \(coordinate?.longitude)")
        
        self.original_address_lati = location.latitude
        self.original_address_long = location.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: self.original_address_lati, longitude: self.original_address_long, zoom: 16)
        
        self.myMap = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 59, width: 320, height: 211), camera: camera)
        
        self.myMap?.delegate = self
        self.locationManager.delegate = self
        // location Author Dialog
        self.locationManager.requestAlwaysAuthorization()
        // Change Map Type to Normal
        self.myMap?.mapType = GMSMapViewType(rawValue: 1)!
        // Inside Map on/off setting
        self.myMap?.isIndoorEnabled = false
        // My location setting
        self.myMap?.isMyLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = self.locationName
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = self.myMap
        
        self.myMap?.settings.compassButton = true
        self.myMap?.settings.myLocationButton = true
        
        
        self.view.addSubview(self.myMap!)
        
        
        /*
        CLGeocoder().geocodeAddressString(locationName, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error)
                return
            }
            if (placemarks?.count)! > 0 {
                
            }
        })
         */
    }
    
    /*
 func setNowLocation(lat: CLLocationDegrees,
                        lon: CLLocationDegrees,
                        delta span: Double) -> CLLocationCoordinate2D{
        let location = CLLocationCoordinate2DMake(lat, lon)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region = MKCoordinateRegion(center: location, span: spanValue)
        //myMap.setRegion(region, animated: true)
        
        return location
    }
 */

    @IBAction func goNowLocation(){
        
    }

}
