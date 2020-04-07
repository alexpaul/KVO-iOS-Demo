//
//  SettingsViewController.swift
//  KVO-iOS-Project
//
//  Created by Alex Paul on 4/7/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

struct Icon {
  var name: String // sun.haze.fill
  var color: UIColor // .yellow
}

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var fontSizeLabel: UILabel!
  @IBOutlet weak var pickerView: UIPickerView!
  
  private var fontSizeObservation: NSKeyValueObservation?
  
  // data for the picker view
  private let iconNames = ["sun.haze.fill", "moon", "globe", "icloud"] // SFSymbol image names e.g "moon"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurePickerView()
    configureFontSizeObservation()
  }
  
  private func configurePickerView() {
    pickerView.dataSource = self
    pickerView.delegate = self
  }
  
  private func configureFontSizeObservation() {
    fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
      guard let newSize = change.newValue else { return }
      self?.fontSizeLabel.text = newSize.description
    })
  }
  
  
  @IBAction func sliderChanged(_ sender: UISlider) {
    let newSize = Int(sender.value) // cast Float to Int as our Settings fontSize is an Int
    Settings.shared.fontSize = newSize
    // after setting the fontSize on the Settings class
    // the WelcomeViewController will be udpated via KVO
    // observation
  }
}

extension SettingsViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1 // number of columns
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return iconNames.count // number of rows
  }
}

extension SettingsViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return iconNames[row] // indexPath.row
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let iconName = iconNames[row]
    Settings.shared.iconName = iconName
    // after setting the iconName on the Settings class
    // the WelcomeViewController will be udpated via KVO
    // observation
  }
}


