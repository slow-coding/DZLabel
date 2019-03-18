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
let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
//        tableView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }

        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        

   
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! MyCell
//        cell.label.dzTableView = tableView
//        cell.label.dzText = "范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把范把[test]范把范把范把范把范把范把范把范把范把范把范把范把"
        let attri = DZAttributedStringGenerator(text: "今天")
        attri.link(url: URL(fileURLWithPath: "123"))
        
        
        cell.label.attributedText = attri.generateAttributedString
 
        cell.label.dzHandlePreRenderTap { aaa in
            print(aaa)
        }
        return cell
    }
}

class MyCell: UITableViewCell {
    var label = DZLabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        label.dzFont = UIFont.systemFont(ofSize: 24)
        //        label.dzLinkFont = UIFont.systemFont(ofSize: 24)
        //        label.dzLinkColor = UIColor.red
 
//        label.dzEnabledTypes = [
//            .address,
//            .phone,
//            .mention,
//            .url,
//            .emoticon(pattern: nil, // By default: "[EmoticonName]"
//                bounds: nil, // Position and Size
//                imageNameBlock: ({ name in // Text -> Local Image Name
//                    var imageName = name
//                    if imageName.hasPrefix("[") { imageName.removeFirst() }
//                    if imageName.hasSuffix("]") { imageName.removeLast() }
//                    return imageName})),
//            .regex(pattern: "AM|PM"),
//        ]
//        label.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        contentView.addSubview(label)
        label.layer.borderWidth = 0.5
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
