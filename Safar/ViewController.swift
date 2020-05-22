//
//  ViewController.swift
//  Safar
//
//  Created by Hiloni Mehta on 16/11/18.
//  Copyright © 2018 Hiloni Mehta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
        
        weak var timer: Timer?
        var startTime: Double = 0
        var time: Double = 0
        var elapsed: Double = 0
        var status: Bool = false
        
        @IBOutlet weak var labelMinute: UILabel!
        @IBOutlet weak var labelSecond: UILabel!
        @IBOutlet weak var labelMillisecond: UILabel!
        @IBOutlet weak var resetBtn: UIButton!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            // No point enabling reset until stopwatch actually started
            resetBtn.isEnabled = false
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func toggleStartStop(_ sender: UIButton!) {
            
            // If button status is true use stop function, relabel button and enable reset button
            if (status) {
                stop()
                sender.setTitle("START", for: .normal)
                resetBtn.isEnabled = true
                
                // If button status is false use start function, relabel button and disable reset button
            } else {
                start()
                sender.setTitle("STOP", for: .normal)
                resetBtn.isEnabled = false
            }
            
        }
        
        @IBAction func resetBtn(_ sender: Any) {
            
            // Invalidate timer
            timer?.invalidate()
            
            // Reset timer variables
            startTime = 0
            time = 0
            elapsed = 0
            status = false
            
            // Reset all three labels to 00
            let strReset = String("00")
            labelMinute.text = strReset
            labelSecond.text = strReset
            labelMillisecond.text = strReset
            
        }
        
        func start() {
            
            startTime = Date().timeIntervalSinceReferenceDate - elapsed
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            
            // Set Start/Stop button to true
            status = true
            
        }
        
        func stop() {
            
            elapsed = Date().timeIntervalSinceReferenceDate - startTime
            timer?.invalidate()
            
            // Set Start/Stop button to false
            status = false
            
        }
        
    @objc func updateCounter() {
            
            // Calculate total time since timer started in seconds
            time = Date().timeIntervalSinceReferenceDate - startTime
            
            // Calculate minutes
            let minutes = UInt8(time / 60.0)
            time -= (TimeInterval(minutes) * 60)
            
            // Calculate seconds
            let seconds = UInt8(time)
            time -= TimeInterval(seconds)
            
            // Calculate milliseconds
            let milliseconds = UInt8(time * 100)
            
            // Format time vars with leading zero
            let strMinutes = String(format: "%02d", minutes)
            let strSeconds = String(format: "%02d", seconds)
            let strMilliseconds = String(format: "%02d", milliseconds)
            
            // Add time vars to relevant labels
            labelMinute.text = strMinutes
            labelSecond.text = strSeconds
            labelMillisecond.text = strMilliseconds
            

   /* override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
}
}


