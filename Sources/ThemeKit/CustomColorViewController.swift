//
//  CustomColorViewController.swift
//  ThemeKit
//
//  Created by Paul Schifferer on 8/28/18.
//

import UIKit


public protocol CustomColorHandler : class {

    func colorTouched(for component : ThemeComponent, in viewController : CustomColorViewController)

}

public class CustomColorViewController : UIViewController {

    public var component : ThemeComponent = .tintColor
    public var label : String = "WTF"
    public var color : UIColor = .black

    public weak var handler : CustomColorHandler?

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var currentColor: UIButton!
//    @IBOutlet var currentColorGesture: UITapGestureRecognizer!

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateControls()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.currentColor.layer.cornerRadius = self.currentColor.bounds.width / 2.0
        self.currentColor.layer.borderColor = UIColor.lightGray.cgColor
        self.currentColor.layer.borderWidth = 1
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


    // MARK: - UI callbacks

    @IBAction func currentColorTouched(_ sender: UIButton) {
        self.handler?.colorTouched(for: component, in: self)
    }

}
