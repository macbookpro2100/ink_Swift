//
//  SuperSong.swift
//  ink_Swift
//
//  Created by liyan on 2017/8/21.
//  Copyright © 2017年 李砚. All rights reserved.
//

import UIKit

class Song {
    var title : String = ""
}

class SuperSong: Song {
    var artist : String = ""
    var url : URL? = URL(string: "")
    var imageUrl : URL? = URL(string: "")
    var previewUrl : URL? = URL(string: "")

}
