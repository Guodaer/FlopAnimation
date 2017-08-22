//
//  ViewController.swift
//  翻牌
//
//  Created by moqing on 2017/8/22.
//  Copyright © 2017年 guoda. All rights reserved.
//

import UIKit
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
class ViewController: UIViewController {
    
    var nowIndex:NSInteger = 0
    
    let duration:CGFloat = 0.5
    
    var isPlaceholder:Bool = true
    
    var pockerArray = [GDPockerView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var btnX = (ScreenWidth-200)/3
        let btnInterval = (ScreenWidth-200)/3
        for i in 0..<2 {
            let button = UIButton(type: .custom)
            
            button.frame = CGRect.init(x: btnX, y: ScreenHeight-60, width: 100, height: 50)
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            view.addSubview(button)
            button.backgroundColor = UIColor.gray
            btnX += (100 + btnInterval)
            if i == 0 {
                button.setTitle("放", for: UIControlState())
            }else{
                button.setTitle("收", for: UIControlState())
            }
            button.tag = i
            button.addTarget(self, action: #selector(ViewController.changeBtnClick(_:)), for: .touchUpInside)
            
        }
        
        
        
        let array = ["2.jpg","3.jpg","4.jpg","3.jpg","2.jpg","4.jpg","3.jpg","4.jpg","2.jpg"]
        
        let interval:CGFloat = 30
        let width:CGFloat = (ScreenWidth - interval*4)/3
        let height:CGFloat = width * 1.5
        
        for i in 0..<array.count {
            
            let pockerView = GDPockerView(frame: CGRect.init(x: 0, y: 0, width: width, height: height), imageName: array[i])
            view.addSubview(pockerView)
            pockerView.center = CGPoint.init(x: ScreenWidth/2, y: ScreenHeight+height)
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapClick(_:)))
            pockerView.addGestureRecognizer(tap)
            pockerView.tag = 1000 + i
            
            pockerArray.append(pockerView)
        }
        
        
    }
    //MARK:变换按钮
    func changeBtnClick(_ sender:UIButton) {
        var i = 0
        let interval:CGFloat = 30
        var x:CGFloat = 30                                  
        var y:CGFloat = 50
        let width:CGFloat = (ScreenWidth - interval*4)/3
        let height:CGFloat = width * 1.5
        
        if sender.tag == 0{
            
            for pockerView in pockerArray {
                let rect = CGRect.init(x: x, y: y, width: width, height: height)
                if i%3 == 2,i>1{
                    x = 30
                    y += (height + interval)
                }else {
                    x += (width + interval)
                }
                self.perform(#selector(ViewController.changePosition(_:)), with: [rect,pockerView], afterDelay: Double(i)*0.2)
                i += 1
            }
        }else {
            
            let array = pockerArray
            for pockerView in array.reversed() {
                let point = CGPoint.init(x: ScreenWidth/2, y: ScreenHeight+height)
                self.perform(#selector(ViewController.zeroPosition(_:)), with: [point,pockerView], afterDelay: Double(i)*0.1)
                i += 1
            }
            
        }
        
        
        
    }
    //MARK:收
    func zeroPosition(_ array:[Any]) {
        let pockerView = array[1] as! GDPockerView
        let point = array[0] as! CGPoint
        
        UIView.animate(withDuration: 0.3, animations: { 
            pockerView.center = point
        }) { (finished) in
            pockerView.contentimageView?.removeFromSuperview()
            pockerView.addSubview(pockerView.placeholderImgView!)

        }
        pockerView.isUserInteractionEnabled = true
        
    }
    //MARK:放
    func changePosition(_ array:[Any]) {
        
        let pockerView = array[1] as! GDPockerView
        let rect = array[0] as! CGRect
        UIView.animate(withDuration: TimeInterval(duration)) {
            pockerView.frame = rect
        }
    
    }
    //MARK:点击牌
    func tapClick(_ tap:UITapGestureRecognizer) {
        
        let tapView = tap.view as! GDPockerView
        
        tapView.isUserInteractionEnabled = false
        animationWithView(tapView)
        
    }
    //MARK:翻单张牌
    func animationWithView(_ popView:GDPockerView) {
        
        
        let option = UIViewAnimationOptions.transitionFlipFromLeft
        UIView.transition(with: popView, duration: TimeInterval(self.duration), options: option, animations: {
            
            popView.placeholderImgView?.removeFromSuperview()
            popView.addSubview(popView.contentimageView!)
            
        }) {[weak self](finish) in
            if let weakSelf = self{
                weakSelf.finishTap(popView)
                weakSelf.perform(#selector(ViewController.toastViewToShow), with: self, afterDelay: TimeInterval(weakSelf.duration*2))
            }
        }
    }
    //结束翻牌后，把其他牌翻过来
    func finishTap(_ popView:GDPockerView) {
        
        for otherView in pockerArray {
            if popView.tag != otherView.tag {
                otherView.isUserInteractionEnabled = false
                let option = UIViewAnimationOptions.transitionFlipFromLeft
                UIView.transition(with: otherView, duration: 0.5, options: option, animations: {
                    otherView.placeholderImgView?.removeFromSuperview()
                    otherView.addSubview(otherView.contentimageView!)

                }, completion: nil)
                
            }
        }
    }
    func toastViewToShow() {
        
        let alertViewController = UIAlertController.init(title: "卧槽", message: "您中了一个亿，点击确认领取", preferredStyle: .alert)
        let sureBtn = UIAlertAction(title: "我领了", style: .default) { (finish) in
            
        }
        alertViewController.addAction(sureBtn)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

