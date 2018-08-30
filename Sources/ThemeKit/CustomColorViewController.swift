//
//  CustomColorViewController.swift
//  PilgrimageKit-iOS
//
//  Created by Paul Schifferer on 8/28/18.
//

import UIKit
import KBRoundedButton


public class CustomColorViewController : UIViewController {

    public var label : String = "WTF"
    public var color : UIColor = .black

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var currentColor: KBRoundedButton!
    @IBOutlet var currentColorGesture: UITapGestureRecognizer!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateControls()
    }


    private func updateControls() {

        self.colorLabel.text = label

        self.currentColor.backgroundColor = color 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
