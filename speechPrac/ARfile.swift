//
//  ARfile.swift
//  speechPrac
//
//  Created by Ali on 20/11/1439 AH.
//  Copyright © 1439 정기웅. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation


class ARfile: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var sceneView: ARSCNView!
    var chosenNode = SCNNode()
    let myItem = itemList()
    
    let locationManager:CLLocationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/AR.dae")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        
        //====== MAP
        
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
        locationManager.distanceFilter = 100
        
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(21.616842, 39.156313), radius: 10, identifier: "Boise")
        
        locationManager.startMonitoring(for: geoFenceRegion)
        
        
        // Do any additional setup after loading the view.
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let la = "aaa"
        var MyList3: [String]
        MyList3 = ["aa" , "a"]
        MyList3.append(la)
        
        for currentLocation in locations{
            print(" lat \(currentLocation.coordinate.latitude) long \(currentLocation.coordinate.longitude) لقد خرجت من منطقة منى ")
            // "0: [locations]"
                label.text = " \(currentLocation.coordinate.latitude)"
            
            MyList3.append(label.text!)
            
            if MyList3.count > 5 {
                label2.text = "لقد خرجت من منطقة منى"
            }
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        label.text = "دخلت المنطقة"
        print("دخلت: \(region.identifier)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        label.text = "خرجت من المنطقة"
        print("خرجت: \(region.identifier)")
        
        
    }
    
    @IBAction func btn6(_ sender: Any) {
        label2.text = "لقد خرجت من منطقة منى"

    }
    
    
}
