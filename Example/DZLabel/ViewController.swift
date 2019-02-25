//
//  ViewController.swift
//  DZLabel
//
//  Created by Darren Zheng on 09/27/2018.
//  Copyright (c) 2018 Darren Zheng. All rights reserved.
//

import UIKit
import DZLabel
import SnapKit
class ViewController: UIViewController {
    
    let attri = DZLabel.prepareAttributedText(
        text: "fawefawefewfewfwefwaefawef[baiyan]fawefawefwaefwefwfwaefwefw",
        font: UIFont.systemFont(ofSize: 24),
        textColor: nil,
        textAlignment: .left,
        enabledTypes: [
            .address,
            .phone,
            .mention,
            .url,
            .emoticon(
                pattern: nil,
                bounds: nil,
                imageNameBlock: ({ name in
                    var imageName = name
                    if imageName.hasPrefix("[") { imageName.removeFirst() }
                    if imageName.hasSuffix("]") { imageName.removeLast() }
                    return imageName})
            ),
            .regex(pattern: "AM|PM"),
            ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = DZLabel()
    
        label.isScrollEnabled = false
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(-0)
        }
        label.dzAttributedText = attri
        label.layer.borderWidth = 0.5

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

