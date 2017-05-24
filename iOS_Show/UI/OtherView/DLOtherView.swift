//
//  DLOtherView.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/22.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLOtherView: UIViewController {
    
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperShowLabel: UILabel!

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderShowLabel: UILabel!
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var switchShowLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var segmentedShowLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIStepper
        stepperConfig()
        
        // UISlider
        sliderConfig()
        
        // UISwitch
        switchButtonConfig()
        
        // UISegmentedControl
        segmentedControlConfig()
    }
    
    //MARK: UIStepper
    func stepperConfig(){
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.stepValue = 3
        stepper.tintColor = UIColor.orange
        stepperShowLabel.text = String(stepper.value)
        
        stepper.setDecrementImage(UIImage(named: "Arrow-Bottom"), for: UIControlState())
        stepper.setIncrementImage(UIImage(named: "Arrow-Top"), for: UIControlState())
    }
    @IBAction func stepperClick(_ sender: UIStepper) {
        DLprint(sender.value)
        stepperShowLabel.text = String(stepper.value)
    }
    
    
    //MARK: UISlider
    func sliderConfig() {
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = UIColor.orange
        slider.maximumTrackTintColor = UIColor.red
        slider.thumbTintColor = UIColor.green
    }
    @IBAction func sliderClick(_ sender: UISlider) {
        DLprint(sender.value)
        sliderShowLabel.text = String(sender.value)
    }
    @IBAction func sliderReset(_ sender: UIButton) {
        slider.setValue(0.5, animated: true)
        sliderShowLabel.text = String(slider.value)
    }
    
    
    //MARK: UISwitch
    func switchButtonConfig() {
        switchButton.tintColor = UIColor.orange
        switchButton.onTintColor = UIColor.orange
        switchShowLabel.text = String(switchButton.isOn)
    }
    @IBAction func switchButtonClick(_ sender: UISwitch) {
        DLprint(sender.isOn)
        switchShowLabel.text = String(sender.isOn)
    }

    
    //MARK: UISegmentedControl
    func segmentedControlConfig() {
        segmentedControl.setTitle("left", forSegmentAt: 0)
        segmentedControl.setTitle("right", forSegmentAt: 1)
        segmentedControl.tintColor = UIColor.orange
        segmentedShowLabel.text = String(segmentedControl.selectedSegmentIndex)
    }
    @IBAction func segmentedControlClick(_ sender: UISegmentedControl) {
        DLprint(sender.selectedSegmentIndex)
        segmentedShowLabel.text = String(sender.selectedSegmentIndex)
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
