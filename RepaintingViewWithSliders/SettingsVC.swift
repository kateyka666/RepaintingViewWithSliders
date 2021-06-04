//
//  ViewController.swift
//  RepaintingViewWithSliders
//
//  Created by Екатерина Боровкова on 22.05.2021.
//

import UIKit
protocol SettingsVCDelegate {
    func update(model: Color)
}

class SettingsVC: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var repaintingView: UIView!
    
    @IBOutlet weak var redColorCountLabel: UILabel!
    @IBOutlet weak var greenColorCountLabel: UILabel!
    @IBOutlet weak var blueColorCountLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var mainColor : Color!
    
    var delegate : SettingsVCDelegate?
    
    //    MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startValueForSliders()
        setupTexFields()
        dissmissBackButtonItem()
    }
    override func viewWillLayoutSubviews() {
        repaintingView.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startValueForSliders()
        setupTexFields()
        dissmissBackButtonItem()
        assigmentColorCountToLabel()
        assigmentTextField()
    }
    
    @IBAction func dragSliders(_ sender: Any) {
        assignmentColor()
        assigmentColorCountToLabel()
        assigmentTextField()
    }
    @IBAction func doneBtnPressed() {
        print(mainColor ?? 0)
        view.endEditing(true)
        navigationController?.popToRootViewController(animated: true)
        
        delegate?.update(model: mainColor )
    }
    private func dissmissBackButtonItem() {
        navigationItem.hidesBackButton = true
    }
    private func startValueForSliders() {
        redColorSlider.value = mainColor.redColor
        redColorSlider.minimumTrackTintColor = .red
        greenColorSlider.value = mainColor.greenColor
        greenColorSlider.minimumTrackTintColor = .green
        blueColorSlider.value = mainColor.blueColor
        
    }
    private func setupTexFields() {
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        redTextField.text = redColorCountLabel.text
        greenTextField.text =  greenColorCountLabel.text
        blueTextField.text = blueColorCountLabel.text
    }
    private func calculationColor() -> UIColor {
        
        let red : CGFloat
        let green : CGFloat
        let blue : CGFloat
        
        red = CGFloat(redColorSlider.value)
        green = CGFloat(greenColorSlider.value)
        blue = CGFloat(blueColorSlider.value)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 0.8)
        
        mainColor.redColor = Float(color.cgColor.components![0] )
        mainColor.greenColor = Float(color.cgColor.components![1] )
        mainColor.blueColor = Float(color.cgColor.components![2] )
        mainColor.alpha = Float(color.cgColor.components![3] )
        
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
    private func assigmentTextField() {
//        устанавливаем значение в текстфилдах в зависимости от значения слайдера
        redTextField.text = transformationToString(valueFrom: redColorSlider)
        greenTextField.text = transformationToString(valueFrom: greenColorSlider)
        blueTextField.text = transformationToString(valueFrom: blueColorSlider)
    }
    private func transformationToString(valueFrom slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }

}
extension SettingsVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redColorCountLabel.text = redTextField.text
                redColorSlider.value = currentValue
                mainColor.redColor = currentValue
            case greenTextField:
                greenColorCountLabel.text = greenTextField.text
                greenColorSlider.value = currentValue
                mainColor.blueColor = currentValue
            case blueTextField: blueColorCountLabel.text = blueTextField.text
                blueColorSlider.value = currentValue
                mainColor.blueColor = currentValue
            default:
                break
            }
        }
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}


