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

class SearchViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, MTMapViewDelegate, XMLParserDelegate {

    @IBOutlet var myView: UIView!
    
    var mapView: MTMapView?
    
    // 맵의 변수 선언
    var myMap: GMSMapView!
    
    var locationName: String = "";
    
    var search_address_lati: CLLocationDegrees = 0.0
    var search_address_long: CLLocationDegrees = 0.0
    var original_address_lati: CLLocationDegrees = 0.0
    var original_address_long: CLLocationDegrees = 0.0
    
    // 위치 데이터를 받아오기 위한 LocationManager
    let locationManager: CLLocationManager = CLLocationManager()
    
    func parseXml() {
        let url = "https://www.google.co.kr/maps/search/%EC%9D%8C%EC%8B%9D%EC%A0%90/@37.5464364,126.8631848,16z/data=!4m2!2m1!6e5?hl=ko/output=xml"
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        xmlParser.delegate = self;
        xmlParser.parse()
    }
    /*
    private func getPlaces(searchString: String) {
      Alamofire.request(.GET,
        "https://maps.googleapis.com/maps/api/place/autocomplete/json",
        parameters: [
          "input": searchString,
          "type": "(\(placeType.description))",
          "key": apiKey ?? ""
        ]).responseJSON { request, response, json, error in
          if let response = json as? NSDictionary {
            if let predictions = response["predictions"] as? Array<AnyObject> {
              self.places = predictions.map { (prediction: AnyObject) -> Place in
                return Place(
                  id: prediction["id"] as String,
                  description: prediction["description"] as String
                )
              }
            }
          }

          self.searchDisplayController?.searchResultsTableView?.reloadData()
      }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        parseXml()
        
        locationManager.delegate = self
        // 정확도 설정 (최고)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 사용자에게 위치제공 승인 요청
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트
        locationManager.startUpdatingLocation()
        
        mapView = MTMapView(frame: self.view.bounds)
        
        
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            let nowLocation: MTMapPOIItem = MTMapPOIItem.init()
            let nowLong: Double
            let nowLati: Double
            if let coor = locationManager.location?.coordinate {
                nowLong = coor.longitude
                nowLati = coor.latitude
                let nowMapPoint: MTMapPointGeo = MTMapPointGeo.init(latitude: nowLati, longitude: nowLong)
                nowLocation.mapPoint = MTMapPoint.init(geoCoord: nowMapPoint)
            }
            nowLocation.draggable = false
            nowLocation.markerType = MTMapPOIItemMarkerType.bluePin
            mapView.add(nowLocation)
            mapView.fitAreaToShowAllPOIItems()
            mapView.showCurrentLocationMarker = true
            self.view.addSubview(mapView)
        }
        
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
    
    /*
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
        
        view = myMap
    }
    */

}
