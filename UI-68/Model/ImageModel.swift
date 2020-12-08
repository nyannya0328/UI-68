//
//  ImageModel.swift
//  UI-68
//
//  Created by にゃんにゃん丸 on 2020/12/08.
//

import SwiftUI

struct ImageModel: Codable,Identifiable {
    var id : String
    var download_url : String
    var onHover : Bool?
}

