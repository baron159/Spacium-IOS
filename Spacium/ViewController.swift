//
//  ViewController.swift
//  Spacium
//
//  Created by Scott Baron on 6/2/17.
//  Copyright © 2017 Scott Baron. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var cogElement: UIImageView!
    
    var rVal: Double = 0
    var gVal: Double = 255
    var bVal: Double = 0
    
    var rIncreaseFlag:Bool = true
    var gIncreaseFlag:Bool = false
    var bIncreaseFlag:Bool = true
    
    let motionManager = CMMotionManager()


    override func viewDidLoad() {
        UIApplication.shared.isIdleTimerDisabled = true
        motionManager.gyroUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdates(to:OperationQueue.current!) { (data, error) in
            if let myData = data {
                print(myData.acceleration.x)
                if fabs(myData.acceleration.x) > 0.3 {
                    let rRateX = fabs(myData.acceleration.x) * 3
                    
                    //This is the red value check and change code
                    if !self.rIncreaseFlag{
                        self.rVal -= rRateX
                        if self.rVal < 0 {
                            self.rVal = 0
                            self.rIncreaseFlag = true
                        }
                    }else{
                        self.rVal += rRateX
                        if self.rVal > 255 {
                            self.rVal = 255
                            self.rIncreaseFlag = false
                        }
                    }
                    
                    //This is the green value check and change code
                    if !self.gIncreaseFlag{
                        self.gVal -= rRateX
                        if self.gVal < 0 {
                            self.gVal = 0
                            self.gIncreaseFlag = true
                        }
                    }else{
                        self.gVal += rRateX
                        if self.gVal > 255 {
                            self.gVal = 255
                            self.gIncreaseFlag = false
                        }
                    }
                    
                    //This is the blue value check and change code
                    if !self.bIncreaseFlag{
                        self.bVal -= rRateX
                        if self.bVal < 0 {
                            self.bVal = 0
                            self.bIncreaseFlag = true
                        }
                    }else{
                        self.bVal += rRateX
                        if self.bVal > 255 {
                            self.bVal = 255
                            self.bIncreaseFlag = false
                        }
                    }
                    let rNum:CGFloat = CGFloat(self.rVal/255)
                    let bNum:CGFloat = CGFloat(self.bVal/255)
                    let gNum:CGFloat = CGFloat(self.gVal/255)
                    
                    let cogR:CGFloat = CGFloat((255-self.rVal)/255)
                    let cogG:CGFloat = CGFloat((255-self.rVal)/255)
                    let cogB:CGFloat = CGFloat((255-self.rVal)/255)

                    //let aNum:CGFloat = CGFloat(1.0)
                    print(rRateX)
                    self.view.backgroundColor = UIColor.init(red: rNum, green: gNum, blue: bNum, alpha: 1.0)
                    self.cogElement.tintColor = UIColor.init(red: cogR, green: cogG, blue: cogB, alpha: 1.0)
                }
            }
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

