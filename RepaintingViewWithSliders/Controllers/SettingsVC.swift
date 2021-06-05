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
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet var colorCountLabels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet var textFields: [UITextField]!
    
    
    var mainColor : Color!
    
    var delegate : SettingsVCDelegate?
    
    //    MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        startValueForSliders()
        setupTexFields()
        dissmissBackButtonItem()
        addDoneButtonOnKeyboard()
        hideKeyboardByUserTap()
    }
    
    override func viewWillLayoutSubviews() {
        repaintingView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startValueForSliders()
        setupTexFields()
        dissmissBackButtonItem()
        assignmentColor()
        assigmentColorCountToLabel()
        assigmentTextField()
        hideKeyboardByUserTap()
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
        for textField in textFields {
            textField.delegate = self
            textField.keyboardType = .decimalPad
            textField.keyboardAppearance = .dark
        }
        for (textfield, colorCountLabel) in zip(textFields, colorCountLabels){
            textfield.text = colorCountLabel.text
        }
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
        for (colorCountLabel, slider) in zip(colorCountLabels, sliders) {
            colorCountLabel.text = transformationToString(valueFrom: slider)
        }
    }
    
    private func assigmentTextField() {
//        устанавливаем значение в текстфилдах в зависимости от значения слайдера
        for (textfield, slider) in zip(textFields, sliders) {
            textfield.text = transformationToString(valueFrom: slider)
        }
    }
    
    private func transformationToString(valueFrom slider: UISlider) -> String {
        return String(format: "%.2f", slider.value)
    }
    private func hideKeyboardByUserTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
    }
    @objc private func tapOnView(gesture:UITapGestureRecognizer) {
        view.endEditing(true)
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
                    redColorSlider.value = currentValue
                case greenTextField:
                    greenColorSlider.value = currentValue
                case blueTextField:
                    blueColorSlider.value = currentValue
                default:
                    break
                }
                assignmentColor()
                assigmentColorCountToLabel()
            }
        }
    }
  
    private func addDoneButtonOnKeyboard() -> Bool {
        let doneToolbar: UIToolbar = UIToolbar()
        doneToolbar.barStyle = UIBarStyle.black
        let placeFromLeading = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                               target: nil,
                                               action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "DONE",
                                                    style: .done,
                                                    target: nil,
                                                    action: #selector(donePressed))
        doneToolbar.setItems([placeFromLeading, done], animated: true)
        doneToolbar.isUserInteractionEnabled = true
        doneToolbar.sizeToFit()
        for textField in textFields {
            textField.inputAccessoryView = doneToolbar
        }
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
