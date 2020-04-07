//
//  ViewController.swift
//  KVO-iOS-Project
//
//  Created by Alex Paul on 4/7/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var welcomeLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  
  private var fontSizeObservation: NSKeyValueObservation?
  private var iconNameObeservation: NSKeyValueObservation?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureObservers()
  }
  
  private func configureObservers() {
    configureFontSizeObservation()
    configureIconNameObservation()
  }
  
  private func configureFontSizeObservation() {
    fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
      guard let newSize = change.newValue else { return }
      // update UI for font
      let fontSize = CGFloat(newSize)
      self?.welcomeLabel.font = UIFont.systemFont(ofSize: fontSize)
    })
  }
  
  private func configureIconNameObservation() {
    iconNameObeservation = Settings.shared.observe(\.iconName, options: [.old, .new], changeHandler: { [weak self] (settings, change) in
      // update ui for image icon
      guard let iconName = change.newValue else { return }
      self?.iconImageView.image = UIImage(systemName: iconName)
    })
  }
  
  /*
   Stack
   
   viewcontroller3
   viewcontroller2
   viewcontroller1
   navigation controller
   */
  
  
  deinit { // gets called when the object is not longer in memory
    fontSizeObservation?.invalidate()
    iconNameObeservation?.invalidate()
  }

}

