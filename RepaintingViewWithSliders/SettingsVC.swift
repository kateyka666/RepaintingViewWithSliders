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
        addDoneButtonOnKeyboard()
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
        view.endEditing(true)
        navigationController?.popToRootViewController(animated: true)
        
        delegate?.update(model: mainColor )
    }

}

extension SettingsVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = textField.text!.replacingOccurrences(of: ",", with: ".")
              return true
         
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if addDoneButtonOnKeyboard() {
            guard let text = textField.text else { return }
            if let currentValue = Float(text) {
                switch textField {
                case redTextField:
                    redColorCountLabel.text = redTextField.text
                    redColorSlider.value = currentValue
                    mainColor.redColor = currentValue
                    mainColor.blueColor = currentValue
                    mainColor.blueColor = currentValue
                    assignmentColor()
                case greenTextField:
                    greenColorCountLabel.text = greenTextField.text
                    greenColorSlider.value = currentValue
                    mainColor.redColor = currentValue
                    mainColor.blueColor = currentValue
                    mainColor.blueColor = currentValue
                    assignmentColor()
                case blueTextField: blueColorCountLabel.text = blueTextField.text
                    blueColorSlider.value = currentValue
                    mainColor.redColor = currentValue
                    mainColor.blueColor = currentValue
                    mainColor.blueColor = currentValue
                    assignmentColor()
                default:
                    break
                }
            }
        }
    }
  
    private func addDoneButtonOnKeyboard() -> Bool
    {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = UIBarStyle.black
        
        let placeFromLeading = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "DONE", style: .done, target: nil, action: #selector(donePressed))
        
        
        doneToolbar.setItems([placeFromLeading, done], animated: true)
        doneToolbar.isUserInteractionEnabled = true
        doneToolbar.sizeToFit()
        
        self.redTextField.inputAccessoryView = doneToolbar
        self.greenTextField.inputAccessoryView = doneToolbar
        self.blueTextField.inputAccessoryView = doneToolbar
        
    return true
    }
    
    @objc func donePressed() {
        guard let textRed = redTextField.text else { return }
        guard let textGreen = greenTextField.text else { return }
        guard let textBlue = blueTextField.text else { return }
        if let currentValue1  = Float(textRed),
           let currentValue2  = Float(textGreen),
           let currentValue3  = Float(textBlue) {
            if  currentValue1 <= 1, currentValue2 <= 1, currentValue3 <= 1
            {
                self.view.endEditing(true)
            }
        }
    }
}

extension SettingsVC {
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
        
        redTextField.keyboardType = .decimalPad
        greenTextField.keyboardType = .decimalPad
        blueTextField.keyboardType = .decimalPad
        redTextField.keyboardAppearance = .dark
        greenTextField.keyboardAppearance = .dark
        blueTextField.keyboardAppearance = .dark
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
