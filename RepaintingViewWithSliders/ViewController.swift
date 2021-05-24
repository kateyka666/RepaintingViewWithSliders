//
//  ViewController.swift
//  RepaintingViewWithSliders
//
//  Created by Екатерина Боровкова on 22.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var repaintingView: UIView!
    
    @IBOutlet weak var redColorCountLabel: UILabel!
    @IBOutlet weak var greenColorCountLabel: UILabel!
    @IBOutlet weak var blueColorCountLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    //    MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startValueForSliders()
        
    }
    override func viewWillLayoutSubviews() {
        repaintingView.layer.cornerRadius = 10
    }
    
    @IBAction func dragSliders(_ sender: Any) {
        assignmentColor()
        assigmentColorCountToLabel()
    }
    private func startValueForSliders() {
        redColorSlider.value = 0
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.value = 0
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.value = 0
        
    }
    private func calculationColor() ->UIColor {
        
        let red : CGFloat
        let green : CGFloat
        let blue : CGFloat
        
        red = CGFloat(redColorSlider.value)
        green = CGFloat(greenColorSlider.value)
        blue = CGFloat(blueColorSlider.value)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 0.8)
        
        return color
    }
    
    private func assignmentColor() {
        let color = calculationColor()
        repaintingView.backgroundColor = color
    }
    
    private func assigmentColorCountToLabel() {
        //        преобразование в три символа для лейбла с подсчетом цвета
        redColorCountLabel.text = transformationToString(valueFrom: redColorSlider)
        greenColorCountLabel.text = transformationToString(valueFrom: greenColorSlider)
        blueColorCountLabel.text = transformationToString(valueFrom: blueColorSlider)
    }
    private func transformationToString(valueFrom slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
    
}

