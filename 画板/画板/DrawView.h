//
//  DrawView.h
//  画板
//
//  Created by Sdr on 2018/4/9.
//  Copyright © 2018年 com.msxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

//清楚
- (void)clear;
//撤销
-(void)undo;
//橡皮擦
-(void)earear;
//设置线的宽度
-(void)setLineWidth:(CGFloat )width;
//设置线的颜色
- (void)setLineColor:(UIColor *)color;

@end
