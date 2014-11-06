//
//  QuxianView.m
//  BeisaierquxianDemo
//
//  Created by student on 14-5-30.
//  Copyright (c) 2014年 JL. All rights reserved.
//

#import "QuxianView.h"
#define kPointWidth 20
#define kCurvePointWidth 24
#define kNumberOfPount 5 //可点击的总次数

@interface QuxianView (){
    int _numberOfTouch;//点击过的次数
    float _startTime;//点击开始的时间
    CGPoint _zhongdianPoint;
}

@property (nonatomic,assign) CGPoint fristPoint;//起点
@property (nonatomic,assign) CGPoint lastPoint;//终点
@property (nonatomic,assign) CGPoint currentPoint1;//控制点1
@property (nonatomic,assign) CGPoint currentPoint2;//控制点2

@property (nonatomic,strong) UIView *activeView;
@property (nonatomic,strong) UIView *activeCurrentView;

@property (nonatomic,strong) NSMutableArray *allPointList;//存放所有view的点

@property (nonatomic,strong) NSMutableArray *quxianPointList;//存放曲线所有的点

@end

@implementation QuxianView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.allPointList = [NSMutableArray array];
        _numberOfTouch = 0;
    }
    return self;
}

-(void)awakeFromNib{
    self.pointView = [[PointView alloc] init];
    self.allPointList = [NSMutableArray array];
    _numberOfTouch = 0;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self draw:context];
    CGContextStrokePath(context);
    
}

- (void)draw:(CGContextRef)context
{
    // set the line properties
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 3);
    CGContextSetAlpha(context, 1.0);
    
    // 画曲线
    if (self.allPointList.count==4) {
        UIView *viewPoint0 = self.allPointList[0];
        self.fristPoint  = viewPoint0.center;
        UIView *viewPoint1 = self.allPointList[1];
        self.currentPoint1  = viewPoint1.center;
        UIView *viewPoint2 = self.allPointList[2];
        self.currentPoint2  = viewPoint2.center;
        UIView *viewPoint3 = self.allPointList[3];
        self.lastPoint  = viewPoint3.center;
/*
        UIView *curentOne = nil;
        UIView *curentTwo = nil;
        UIView *startView = self.allPointList[0];
        
        CGContextMoveToPoint(context, startView.frame.origin.x + kPointWidth/2, startView.frame.origin.y + kPointWidth/2);//圆弧的起始点
        for (int i= 1; i<self.allPointList.count; i++) {
            if (i%3==0) {//得到普通点
                curentOne = self.allPointList[i-1];
                curentTwo = self.allPointList[i-2];
                
                for (float ti= 0.0; ti<1.0; ti+=0.05) {
                    CGPoint quxianPoint;
                    
                    quxianPoint.x = (1-ti)*(1-ti)*(1-ti)*startView.frame.origin.x + 3*ti*(1-ti)*(1-ti)*curentOne.frame.origin.x  + 3*ti*ti*(1-ti)*curentTwo.frame.origin.y + ti*ti*ti*self.lastPoint.x;//三阶贝塞尔曲线计算方法
                    quxianPoint.y = (1-ti)*(1-ti)*(1-ti)*startView.frame.origin.y + 3*ti*(1-ti)*(1-ti)*curentOne.frame.origin.y + 3*ti*ti*(1-ti)*curentTwo.frame.origin.y + ti*ti*ti*self.lastPoint.y;
                    
                    CGContextAddLineToPoint(context, quxianPoint.x, quxianPoint.y);
                }//内部 for end
            }
        }//外部 for end
*/
    }
    
    CGContextMoveToPoint(context, self.fristPoint.x, self.fristPoint.y);
    for (float ti= 0.0; ti<1.0; ti+=0.05) {
        CGPoint quxianPoint;
        
        quxianPoint.x = (1-ti)*(1-ti)*(1-ti)*self.fristPoint.x + 3*ti*(1-ti)*(1-ti)*self.currentPoint1.x + 3*ti*ti*(1-ti)*self.currentPoint2.x + ti*ti*ti*self.lastPoint.x;//三阶贝塞尔曲线计算方法
        quxianPoint.y = (1-ti)*(1-ti)*(1-ti)*self.fristPoint.y + 3*ti*(1-ti)*(1-ti)*self.currentPoint1.y + 3*ti*ti*(1-ti)*self.currentPoint2.y + ti*ti*ti*self.lastPoint.y;
        
        CGContextAddLineToPoint(context, quxianPoint.x, quxianPoint.y);
    }
    
    CGContextStrokePath(context);
    
    // http://blog.csdn.net/jy578154186_/article/details/9840307
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint locationPoint= [[touches anyObject] locationInView:self];
    
//    for (UIView *pointView in self.allPointList) {
//        if (locationPoint.x - pointView.center.x>10 && locationPoint.y - pointView.center.y>10) {
//            
//        }
//    }
    //控制点的移动
    int i = 1;
    for(UIView *pointView in self.allPointList)
    {
        CGPoint viewPoint = [pointView convertPoint:locationPoint fromView:self];
        
        if (i % 2)
        {
            if([pointView pointInside:viewPoint withEvent:event])
            {
                self.activeView = pointView;
                self.activeCurrentView.backgroundColor = [UIColor redColor];
                break;
            }
        }
        else
        {
            if([pointView pointInside:viewPoint withEvent:event])
            {
                self.activeView = pointView;
                self.activeCurrentView.backgroundColor = [UIColor redColor];
                break;
            }
        }
        i ++;
    }
    
    
    if (self.allPointList.count<4) {
        
        UIView *pointView = [self.pointView addPointViewByPoint:locationPoint andNum:_numberOfTouch];
//        if () {
//            
//        }
        [self.allPointList addObject:pointView];
        [self addSubview:pointView];
    }

    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    if (self.activeView)
    {
        self.activeView.frame = CGRectMake(locationPoint.x - kPointWidth/2.0, locationPoint.y - kPointWidth/2.0, kPointWidth, kPointWidth);
    } else if (self.activeCurrentView) {
        self.activeCurrentView.frame = CGRectMake(locationPoint.x - kCurvePointWidth/2.0, locationPoint.y - kCurvePointWidth/2.0, kCurvePointWidth, kCurvePointWidth);
    } else {
        for (UIView *point in self.allPointList)
        {
            point.frame = CGRectOffset(point.frame, locationPoint.x - self.lastPoint.x, locationPoint.y - self.lastPoint.y);
        }
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}


@end
