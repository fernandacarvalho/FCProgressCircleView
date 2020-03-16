//
//  ViewController.swift
//  FCProgressCircleViewExample
//
//  Created by Fernanda Carvalho on 10/03/20.
//  Copyright © 2020 FernandaCarvalho. All rights reserved.
//

import UIKit
import FCProgressCircleView

class ViewController: UIViewController, FCCircleViewDelegate {

    var circleView: FCProgressCircleView!
    var percentage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addCircleView()
    }


    func addCircleView() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let circleSize = screenWidth/2.0
        self.circleView = FCProgressCircleView(frame: CGRect(x: 0, y: 0, width: circleSize, height: circleSize), lineWidth: 7.0)
        self.circleView.delegate = self
        self.circleView.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        self.view.addSubview(circleView)
        self.circleView.animateCircle(byDuration: 2.0, andPercentage: self.percentage, withColor: .cyan)
    }
    
    func animationDidEnd() {
        self.percentage += 10
        if self.percentage <= 100 {
            self.circleView.animateCircle(byDuration: 2.0, andPercentage: self.percentage, withColor: .cyan)
        }
    }
}

