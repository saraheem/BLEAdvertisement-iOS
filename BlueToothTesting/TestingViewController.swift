//
//  TestingViewController.swift
//  BlueToothTesting
//
//  Created by afnan khan on 25/03/2020.
//  Copyright © 2020 afnan khan. All rights reserved.
//

import UIKit
import CoreBluetooth


class TestingViewController: UIViewController ,  CBPeripheralDelegate, CBCentralManagerDelegate {
    
    var centralManager: CBCentralManager?
    
    var peripherals:[CBPeripheral] = []
       var manager: CBCentralManager? = nil

   
    func BlueToothDeviceViewController(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
     print("Discover Peripheral")
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scanBLEDevice()
    }
    

    func scanBLEDevice(){
        centralManager?.scanForPeripherals(withServices: nil, options: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0) {
            self.stopScanForBLEDevice()
        }

    }
    func stopScanForBLEDevice(){
        manager?.stopScan()
        print("scan stopped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
     
    

 

    //CBCentralMaganerDelegate code
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (!peripherals.contains(peripheral)){
        peripherals.append(peripheral)
            }
         }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print(central.state)
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // pass reference to connected peripheral to parentview
        

        
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(error!)
    }

}
