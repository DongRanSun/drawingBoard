//
//  DrawView.m
//  画板
//
//  Created by Sdr on 2018/4/9.
//  Copyright © 2018年 com.msxf. All rights reserved.
//

#import "DrawView.h"
#import "MyBezierPath.h"

@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *path ;
@property (nonatomic, strong) NSMutableArray *pathArray;
@property (nonatomic,assign) CGFloat Width;
@property (nonatomic, strong) UIColor *color;
@end
@implementation DrawView


- (void)drawRect:(CGRect)rect {
    // Drawing code
  for (MyBezierPath *path in self.pathArray) {
    [path.color set];
    [path stroke];

  }

}


//清楚
- (void)clear{
  [self.pathArray removeAllObjects];
  [self setNeedsDisplay];
}
//撤销
-(void)undo{
  
  [self.pathArray removeLastObject];
  [self setNeedsDisplay];
  
}
//橡皮擦
-(void)earear{
  
  [self setLineColor:[UIColor whiteColor]];
  [self setNeedsDisplay];
}
//设置线的宽度
-(void)setLineWidth:(CGFloat )width{
  self.Width = width;
  [self setNeedsDisplay];
}
//设置线的颜色
- (void)setLineColor:(UIColor *)color{
  
  self.color = color;
  [self setNeedsDisplay]; 
}

-(NSMutableArray *)pathArray{
  if (_pathArray == nil) {
    _pathArray = [NSMutableArray array];
  }
  return _pathArray;
  
}

- (void)awakeFromNib{
  [super awakeFromNib];
  self.lineWidth = 1;
  self.color = [UIColor blackColor];
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
  [self addGestureRecognizer:pan];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
  
  CGPoint curP = [pan locationInView:self];
  if (pan.state == UIGestureRecognizerStateBegan) {
    MyBezierPath *path = [[MyBezierPath alloc]init];
    //设置线宽
    [path setLineWidth:self.Width];
    [self.pathArray addObject:path];
    path.color = self.color;
    self.path = path;
    [path moveToPoint:curP];
    
  }else if (pan.state == UIGestureRecognizerStateChanged){
    
    [self.path addLineToPoint:curP];

    [self setNeedsDisplay];
    
  }

  
}

@end
