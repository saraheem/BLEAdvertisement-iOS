//
//  ViewController.swift
//  BlueToothTesting
//
//  Created by afnan khan on 25/03/2020.
//  Copyright © 2020 afnan khan. All rights reserved.
//

import UIKit
import CoreBluetooth



class ViewController: UIViewController {
    
    //MARK: -  IBOutlet

    
    @IBOutlet weak var startButton :                     UIButton!
    @IBOutlet weak var stopButton :                     UIButton!


    @IBOutlet weak var myTextView: UITextView!
    
    //MARK: -  Variables

    var centralManager: CBCentralManager?
    var peripheralManager = CBPeripheralManager()
    
    var peripherals = Array<CBPeripheral>()
    
    private var service: CBUUID!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Initialise CoreBluetooth Central Manager
        startButton.isEnabled = false
        stopButton.isEnabled = false

        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {[weak self] in
            // your code here
            self?.centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
            
        }
    }
    
    //MARK: -  Button clicked
    @IBAction func startBroadCcastingButtonClicked(_ sender: Any) {
        
       
        startBroadcasting(peripheral: peripheralManager)
    }
    
    @IBAction func stopBroadCcastingButtonClicked(_ sender: Any) {
        peripheralManager.stopAdvertising()
        
    }
    
    
    
}



extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == .poweredOn){
            
           
            self.centralManager?.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey : "1"])
        }
        else {
            // do something like alert the user that ble is not on
        }
    }
    
    func BlueToothDeviceViewController(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discover Peripheral")
        peripherals.append(peripheral)
    }
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        print("request \(request.value)")
        
    }
    
}



 
extension ViewController : CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        if (peripheral.state == .poweredOn){
            
            startButton.isEnabled = true
            stopButton.isEnabled = true

        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        for request in requests {
            if let value = request.value {
                print("Request")
            }
            self.peripheralManager.respond(to: request, withResult: .success)
        }
    }
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("Did find Characterstics")
        
    }
}




extension ViewController {
    
    func startBroadcasting(peripheral: CBPeripheralManager!) {
        
        peripheral.delegate = self
        
        var localName = "01234567";
        
        localName = myTextView.text
        
        peripheral.startAdvertising([
          CBAdvertisementDataLocalNameKey :  localName ,
          CBAdvertisementDataServiceUUIDsKey : [CBUUID(string:"1852BC70-3848-4F5C-B0A2-F45B4746F3D4")]
        ])

        
    }
    
    
    
    
    
}


