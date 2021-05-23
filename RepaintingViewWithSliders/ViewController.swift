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
    func startValueForSliders() {
        redColorSlider.value = 0
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.value = 0
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.value = 0
        blueColorSlider.minimumTrackTintColor = .blue
    }
    func calculationColor() ->UIColor {
        
        let red : CGFloat
        let green : CGFloat
        let blue : CGFloat
        let colorCount: Float = 255.0
        let percent : Float = 100.0
        
        red = CGFloat(redColorSlider.value * percent / colorCount  )
        green = CGFloat(greenColorSlider.value * percent / colorCount )
        blue = CGFloat(blueColorSlider.value * percent / colorCount)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 0.8)
        
        return color
    }
    func assignmentColor() {
        let color = calculationColor()
        repaintingView.backgroundColor = color
    }
    func assigmentColorCountToLabel() {
        let red  = redColorSlider.value
        let green = greenColorSlider.value
        let blue = blueColorSlider.value
        
        //        преобразование в три символа для лейбла с подсчетом цвета
        redColorCountLabel.text = String(format: "%.2f", red)
        greenColorCountLabel.text = String(format: "%.2f", green)
        blueColorCountLabel.text = String(format: "%.2f", blue)
    }
    @IBAction func dragSliders(_ sender: Any) {
        assignmentColor()
        assigmentColorCountToLabel()
    }
    
    
}

