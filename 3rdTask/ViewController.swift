//
//  ViewController.swift
//  3rdTask
//
//  Created by Руслан Гайфуллин on 08.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var animator = UIViewPropertyAnimator(duration: 0.6, curve: .linear)
    
    private lazy var rectangle: UIView = {
       let vc = UIView(frame: CGRect(x: view.layoutMargins.left, y: 80, width: 100, height: 100))
        vc.backgroundColor = .systemBlue
        vc.layer.cornerRadius = 10
        return vc
    }()
    
    private lazy var slider: UISlider = {
        let slide = UISlider(frame: CGRect(x: view.layoutMargins.left, y: 250, width: UIScreen.main.bounds.width - view.layoutMargins.right - view.layoutMargins.left, height: 30))
        slide.isContinuous = true
        slide.sizeToFit()
        slide.minimumValue = 0.0
        slide.maximumValue = 1.0
        slide.addTarget(self, action: #selector(sliderValueChanged(_ :)), for: .valueChanged)
        return slide
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutMargins = UIEdgeInsets(top: self.view.layoutMargins.top, left: 20, bottom: self.view.layoutMargins.bottom, right: 20)

        setupView()
        animator.addAnimations {
            self.rectangle.frame = CGRect(x: UIScreen.main.bounds.width - (self.rectangle.frame.width * 1.5) - self.view.layoutMargins.right, y: 80, width: self.rectangle.frame.width * 1.5, height: self.rectangle.frame.height * 1.5)
            self.rectangle.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            self.slider.addTarget(self, action: #selector(self.startAnimationSlider), for: [.touchUpInside, .touchUpOutside])
            self.animator.pausesOnCompletion = true
                   }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layoutMarginsDidChange()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(rectangle)
        view.addSubview(slider)
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider!) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc private func startAnimationSlider() {
        animator.startAnimation()
        slider.setValue(self.slider.maximumValue, animated: true)
    }
}
