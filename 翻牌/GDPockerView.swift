//
//  GDPockerView.swift
//  翻牌
//
//  Created by moqing on 2017/8/22.
//  Copyright © 2017年 guoda. All rights reserved.
//

import UIKit

class GDPockerView: UIView {

    
    var placeholderImgView:UIImageView?
    
    var contentimageView:UIImageView?
    
    init(frame: CGRect ,imageName:String) {
        super.init(frame: frame)
        
        createUI(imageName)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func createUI(_ imageName:String) {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize (width: 0, height: 0)
        layer.shadowOpacity = 0.3

        //背面
        placeholderImgView = UIImageView(frame: self.bounds)
        placeholderImgView?.backgroundColor = UIColor.white
        placeholderImgView?.image = UIImage.init(named: "1.jpeg")
        placeholderImgView?.layer.cornerRadius = 10
        placeholderImgView?.clipsToBounds = true
        placeholderImgView?.layer.borderColor = UIColor.white.cgColor
        placeholderImgView?.layer.borderWidth = 5
        self.addSubview(placeholderImgView!)
        //正面
        contentimageView = UIImageView(frame: self.bounds)
        contentimageView?.backgroundColor = UIColor.white
        contentimageView?.image = UIImage.init(named: imageName)
        contentimageView?.layer.cornerRadius = 10
        contentimageView?.clipsToBounds = true
        contentimageView?.layer.borderColor = UIColor.white.cgColor
        contentimageView?.layer.borderWidth = 5
        
    }
    
    
    
}
