//
//  StartVC.swift
//  RepaintingViewWithSliders
//
//  Created by Екатерина Боровкова on 03.06.2021.
//

import UIKit

class StartVC: UIViewController {

   
    @IBOutlet weak var startView: UIView!
    
    var mainColor = Color.makeColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUIView()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsVC else { return }
        settingsVC.mainColor = mainColor
        settingsVC.delegate = self
    }
    @IBAction func goToSettingsVCItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SettingsVC", sender: nil)
    }
    private func setupUIView() {
        startView.backgroundColor = UIColor(red: CGFloat(mainColor.redColor), green: CGFloat(mainColor.greenColor), blue: CGFloat(mainColor.blueColor), alpha: CGFloat(mainColor.alpha))
    }
}
extension StartVC : SettingsVCDelegate {
    func update(model: Color) {
        self.mainColor = model
    }
    
    
}
