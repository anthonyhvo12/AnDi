//
//  HomeViewController.swift
//  AnDi
//
//  Created by Trần Sỹ Quyết on 6/15/19.
//  Copyright © 2019 Trần Sỹ Quyết. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "CustomPin"
class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var myLocationButton: UIButton!

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        menuButton.addTarget(self, action: #selector(clickMenu), for: .touchUpInside)
        menuButton.layer.cornerRadius = 4.0
        menuButton.clipsToBounds = true

        let image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        menuButton.setImage(image, for: .normal)
        menuButton.tintColor = UIColor(rgb: kColor)

        mapView.delegate = self

        let currentLocation: CLLocation!
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        }

        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

            currentLocation = locationManager.location
            guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            // 1
            let location = CLLocationCoordinate2D(latitude: locValue.latitude,
                                                  longitude: locValue.longitude)

            // 2
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)

            //3
            let customAnnotation = Annotation(coordinate: location)
            self.mapView.addAnnotation(customAnnotation)
            self.mapView.showAnnotations([customAnnotation], animated: true)
        }

        myLocationButton.addTarget(self, action: #selector(clickMyLocation), for: .touchUpInside)
        requestGet()
    }

    let baseUrl = "http://192.168.13.185:8080/report/within3kmRange?posX=105.84770441661124&posY=21.003753662109375"

    func requestGet(){
        // Alamofire 4
        AF.request(baseUrl).responseString(completionHandler: { (response) in
            let jsonResponse = Utility.convertStringToJson(response.value ?? "")
//            print(jsonResponse)
            var arrObject = [ReportModel]()
            for (key,subJson):(String, JSON) in jsonResponse {

                print((key,subJson).0)
                let str: String = (key,subJson).0
                
                let i: Int = Int(str)!
                var object = ReportModel()
                object.lights = jsonResponse[i]["lights"].intValue
                object.id = jsonResponse[i]["id"].intValue
                object.width = jsonResponse[i]["width"].intValue
                object.police = jsonResponse[i]["police"].intValue
                object.positionY = jsonResponse[i]["positionY"].doubleValue
                object.positionX = jsonResponse[i]["positionX"].doubleValue
                object.updatedAt = jsonResponse[i]["updatedAt"].string!
                object.createdAt = jsonResponse[i]["createdAt"].string!
                arrObject.append(object)
                // 1
                let location = CLLocationCoordinate2D(latitude: object.positionY,
                                                      longitude: object.positionX)

                // 2
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: location, span: span)
                self.mapView.setRegion(region, animated: true)

                //3
                let customAnnotation = Annotation(coordinate: location)
                self.mapView.addAnnotation(customAnnotation)
                self.mapView.showAnnotations([customAnnotation], animated: true)
            }
        })
    }

    @objc func clickMenu(){
        self.frostedViewController.presentMenuViewController()
    }

    @objc func clickMyLocation(){
        locationManager.startUpdatingLocation()
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        // 1
        let location = CLLocationCoordinate2D(latitude: locValue.latitude,
                                              longitude: locValue.longitude)

        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

}

extension HomeViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "pin")?.withRenderingMode(.alwaysTemplate)
        annotationView?.tintColor = UIColor(rgb: kColor)
        return annotationView
    }
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView)
    {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.layer.cornerRadius = 8
        calloutView.clipsToBounds = true
        // 3
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        calloutView.starRateView.rating = 1
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
}
