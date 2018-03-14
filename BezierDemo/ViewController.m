//
//  ViewController.m
//  BezierDemo
//
//  Created by tondy zhang on 2018/3/14.
//  Copyright © 2018年 tondy zhang. All rights reserved.
//

#import "ViewController.h"
#import "DrawBezierManager.h"
#import "UIView+Frame.h"

#define kScreenHeight self.view.frame.size.height
#define kScreenWidth self.view.frame.size.width

#define kLeftViewWidth (50)


@interface ViewController ()

@property(nonatomic, strong)UIView *leftView;

@property(nonatomic, strong)CAShapeLayer *shapeLayer;

@property(nonatomic, strong)UIView *line1;
@property(nonatomic, strong)UIView *line2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPanGesture];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    //    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)leftView
{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLeftViewWidth, self.view.frame.size.height)];
        _leftView.backgroundColor = [UIColor orangeColor];
//        [_leftView.layer addSublayer:self.shapeLayer];
        _leftView.layer.masksToBounds = NO;
        _leftView.clipsToBounds = NO;
    }
    return _leftView;
}

- (CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = self.leftView.backgroundColor.CGColor;
    }
    return _shapeLayer;
}

- (UIView *)line1
{
    if (_line1 == nil) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor blackColor];
    }
    return _line1;
}

- (UIView *)line2
{
    if (_line2 == nil) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor blackColor];
    }
    return _line2;
}

- (void)addPanGesture
{
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanGesture:)];
    [self.view addGestureRecognizer:panGes];
    self.view.userInteractionEnabled = YES;
}

- (void)didPanGesture:(UIPanGestureRecognizer*)gesture
{
    //根据手势获取曲线控制点
    NSArray<NSValue*> *points = [self getKeyPointsWithGesture:gesture];
    //根据曲线控制点生成n阶贝塞尔曲线
    DrawBezierManager *manager = [[DrawBezierManager alloc] init];
    UIBezierPath *bpath = [manager getPathWithPoints:points];
//    [bpath closePath];
//    self.shapeLayer.path = bpath.CGPath;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, self.leftView.y);
    CGPathAddLineToPoint(path, NULL, kLeftViewWidth, self.leftView.y);
    CGPathAddPath(path, NULL, bpath.CGPath);
    CGPathAddLineToPoint(path, NULL, kLeftViewWidth, self.leftView.maxY);
    CGPathAddLineToPoint(path, NULL, kLeftViewWidth, self.leftView.y);
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path;
    self.leftView.layer.mask = shape;
    
}


- (NSArray<NSValue*>*)getKeyPointsWithGesture:(UIPanGestureRecognizer*)gesture
{
    CGPoint location = [gesture locationInView:self.view];
    CGPoint translation = [gesture translationInView:self.view];
//    CGPoint velocity = [gesture velocityInView:self.view];
    //    NSLog(@"translation:%@",NSStringFromCGPoint(translation));
    //    NSLog(@"velocity:%@",NSStringFromCGPoint(velocity));
    //    if (<#condition#>) {
    //        <#statements#>
    //    }
    //计算当前手指所在y坐标
    CGFloat currentY = location.y ;//+ translation.y;
    NSLog(@"currentY:%f",currentY);
    //    if (currentY < kScreenHeight/2.0) {
    //        <#statements#>
    //    }
    //    UIBezierPath *path = [UIBezierPath bezierPath];
    //    [path moveToPoint:CGPointMake(kLeftViewWidth, 0)];
    //    [path addQuadCurveToPoint:CGPointMake(kLeftViewWidth, self.leftView.frame.size.height) controlPoint:CGPointMake(kLeftViewWidth + translation.x, currentY)];
    CGPoint point1 = CGPointMake(kLeftViewWidth, 0);
    CGPoint p1 = CGPointMake(kLeftViewWidth+translation.x/5.0, currentY-20);
    CGPoint point2 = CGPointMake(kLeftViewWidth + translation.x, currentY);
    CGPoint p2 = CGPointMake(p1.x, currentY+20);
    CGPoint point3 = CGPointMake(kLeftViewWidth, self.leftView.frame.size.height);
    NSMutableArray *pointArr = [[NSMutableArray alloc] init];
    [pointArr addObject:[NSValue valueWithCGPoint:point1]];
    [pointArr addObject:[NSValue valueWithCGPoint:p1]];
    [pointArr addObject:[NSValue valueWithCGPoint:point2]];
    [pointArr addObject:[NSValue valueWithCGPoint:p2]];
    [pointArr addObject:[NSValue valueWithCGPoint:point3]];
    return pointArr;
}

@end
