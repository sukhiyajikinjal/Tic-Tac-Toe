//
//  T3Cell.swift
//  TicTacToc
//
//  Created by DCS on 06/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class T3Cell: UICollectionViewCell {
    private let myimageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    func setupCell(with status:Int){
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.backgroundColor = .lightGray
        
        contentView.addSubview(myimageView)
        myimageView.frame = CGRect(x: 6,y:6,width:60,height:60)
        let name = (status == 0 ? "circle" : status == 1 ? "multiply" : "")
        myimageView.image = UIImage(named: name)
    }
}

