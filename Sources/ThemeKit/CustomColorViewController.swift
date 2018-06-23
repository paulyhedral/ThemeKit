//
//  ColorDisplayViewController.swift
//  InitiativeTracker-iOS
//
//  Created by Paul Schifferer on 5/31/18.
//  Copyright © 2018 Pilgrimage Software. All rights reserved.
//

import UIKit
import PilgrimageKit


class CustomColorViewController : UIViewController {

    @IBOutlet weak var currentColor : UIView!
    @IBOutlet var currentColorGesture: UITapGestureRecognizer!
    @IBOutlet weak var colorLabel : UILabel!

    var type : ThemeColorType = .tint
    var colorTitle : String = ""
    var color : UIColor = .black

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateControls()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


    // MARK: - Private methods

    private func updateControls() {
        self.colorLabel.text = colorTitle

        self.currentColor.backgroundColor = self.color
    }


    // MARK: - UI callbacks



}
