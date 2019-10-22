//
//  String+DZ.swift
//  DZLabel
//
//  Created by Xu Zheng on 2019/10/22.
//

import Foundation

extension String
{
    func hostEncodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlHostAllowed)
    }
    func hostDecodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
