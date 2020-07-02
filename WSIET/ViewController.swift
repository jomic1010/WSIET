//
//  ViewController.swift
//  WSIET
//
//  Created by JomiC on 2020/06/30.
//  Copyright © 2020 JomiC. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    // 맵의 변수 선언
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var userLocation: UILabel!
    @IBOutlet var nowLocation: UIButton!
    
    // 위치 데이터를 받아오기 위한 LocationManager
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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

