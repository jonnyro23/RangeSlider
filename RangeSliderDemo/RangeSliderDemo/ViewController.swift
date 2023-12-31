//
//  ViewController.swift
//  RangeSliderDemo
//
//  Created by Roma Dudka on 31.08.2023.
//

import UIKit
import RangeSlider

class ViewController: UIViewController {
    
    let rangeSlider = RangeSlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(rangeSlider)
        rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rangeSlider.topAnchor.constraint(equalTo: view.topAnchor),
            rangeSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rangeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rangeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rangeSlider.configuration = .init(range: 10 ... 17000,
                                          bounds: 0 ... 20000,
                                          step: 1,
                                          distance: 10 ... .infinity,
                                          lowerThumbSize: .init(width: 50, height: 50),
                                          upperThumbSize: .init(width: 50, height: 50),
                                          trackHeight: 8,
                                          trackCornerRadius: 4,
                                          trackBackgroundColor: .cyan,
                                          trackForegroundColor: .red)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rangeSlider.configuration = rangeSlider.configuration
    }
}

