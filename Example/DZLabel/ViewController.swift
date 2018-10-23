//
//  ViewController.swift
//  DZLabel
//
//  Created by Darren Zheng on 09/27/2018.
//  Copyright (c) 2018 Darren Zheng. All rights reserved.
//

import UIKit
import DZLabel
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = DZLabel()
        label.dzFont = UIFont.systemFont(ofSize: 14)
        label.dzText = "testestesteststes[test],[test1],1888888888 http://www.baidu.com @darren"
        label.dzEnabledTypes = [
            .address,
            .phone,
            .mention,
            .url,
            .emoticon(pattern: nil, // By default: "[EmoticonName]"
                bounds: CGRect(x: 0, y: -2, width: 20, height: 20), // Position and Size
                imageNameBlock: ({ name in // Text -> Local Image Name
                    var imageName = name
                    if imageName.hasPrefix("[") { imageName.removeFirst() }
                    if imageName.hasSuffix("]") { imageName.removeLast() }
                    return imageName})),
            .regex(pattern: "AM|PM"),
        ]
        label.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: 200)
        view.addSubview(label)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

