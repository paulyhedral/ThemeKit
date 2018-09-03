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
    public var label : String = "WTF" {
        didSet {
            updateControls()
        }
    }
    public var color : UIColor = .black {
        didSet {
            updateControls()
        }
    }

    public weak var handler : CustomColorHandler?

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var currentColor: UIButton!

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

        self.colorLabel.textColor = color.isDark() ? .white : .black
    }


    // MARK: - UI callbacks

    @IBAction func currentColorTouched(_ sender: UIButton) {
        self.handler?.colorTouched(for: component, in: self)
    }

}
