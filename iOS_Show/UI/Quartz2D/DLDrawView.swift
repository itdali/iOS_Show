//
//  DLDrawView.swift
//  UIShow_Swift
//
//  Created by dali on 16/7/29.
//  Copyright © 2016年 dali. All rights reserved.
//

import UIKit

class DLDrawView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        let pathLine = CGMutablePath()
        pathLine.move(to: CGPoint(x: 0, y: 0))
        pathLine.addLine(to: CGPoint(x:100, y:100))
        context!.addPath(pathLine)
        
        let pathRectangle = CGMutablePath()
        pathLine.move(to: CGPoint(x: 100, y: 120))
        pathLine.addLine(to: CGPoint(x:200, y:120))
        pathLine.addLine(to: CGPoint(x:200, y:220))
        pathLine.addLine(to: CGPoint(x:100, y:220))
        pathLine.addLine(to: CGPoint(x:100, y:120))
        context!.addPath(pathRectangle)
        
        
        context!.setFillColor(red: 1, green: 1, blue: 0, alpha: 1)   //设置填充色
        /*
        CGContextSetRGBStrokeColor(context, 1, 0, 1, 1) //设置笔触颜色
        CGContextSetRGBFillColor(context, 1, 1, 0, 1)   //设置填充色

        CGContextSetLineWidth(context, 5)   //设置线条宽度
        CGContextSetLineCap(context, CGLineCap.Round ) // 设置顶点样式
        CGContextSetLineJoin(context, CGLineJoin.Round) //设置连接点样式
        /*设置线段样式
        phase:虚线开始的位置  这里设置为0
        lengths:虚线长度间隔
        count:虚线数组元素个数
        */
        let lengths: [CGFloat] = [5,7] //长度间隔
        CGContextSetLineDash(context, 0 , lengths, 2)

        let color = UIColor.grayColor().CGColor //颜色转化，由于Quartz 2D跨平台，所以其中不能使用UIKit中的对象，但是UIkit提供了转化方法
        /*设置阴影
        context:图形上下文
        offset:偏移量
        blur:模糊度
        color:阴影颜色
        */
        CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color)
        
        */
        context!.drawPath(using: .fillStroke)
        context!.strokePath()
    }

}
