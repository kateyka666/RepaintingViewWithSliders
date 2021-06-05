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

    @IBAction func goToSettingsVCItem(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC{
            settingsVC.mainColor = mainColor
            settingsVC.delegate = self
            navigationController?.pushViewController(settingsVC, animated: true)
        }
        
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
