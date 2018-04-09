//
//  ViewController.m
//  画板
//
//  Created by Sdr on 2018/4/9.
//  Copyright © 2018年 com.msxf. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clear:(id)sender {
  [self.drawView  clear];
  

}

- (IBAction)undo:(id)sender {
  [self.drawView undo];

}
//橡皮擦
- (IBAction)eraser:(id)sender {
  [self.drawView earear];

}
- (IBAction)choosePic:(id)sender {

  UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
  //设置照片的来源
  pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  pickVC.delegate = self;
  [self presentViewController:pickVC animated:YES completion:nil];
  
  
}

- (IBAction)save:(id)sender {
  //把画板上东西生成一张图片保存
  UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 1);
  CGContextRef ctx =  UIGraphicsGetCurrentContext();
  [self.drawView.layer renderInContext: ctx];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  //保存到系统相册中 成功调用系统方法必须
  UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
  NSLog(@"保存成功");
}

//设置线宽
- (IBAction)valueChange:(UISlider *)sender {
  
  [self.drawView setLineWidth:sender.value * 20];
}
//设置线的颜色

- (IBAction)setColor:(UIButton *)sender {

  [self.drawView setLineColor:sender.backgroundColor];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
  
  NSLog(@"%@",info);
  UIImage *image = info[UIImagePickerControllerOriginalImage];
  NSData *data = UIImagePNGRepresentation(image);
  [data writeToFile:@"/Users/nbj/Desktop/image.pngc" atomically:YES];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
