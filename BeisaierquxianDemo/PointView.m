//
//  PointView.m
//  beisaierDemo
//
//  Created by 楊盧银Mac on 14-5-10.
//  Copyright (c) 2014年 com.yly16. All rights reserved.
//

#import "PointView.h"


#define kPointWidth 20
#define kCurvePointWidth 24


@implementation PointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pointColor = [UIColor redColor];
        self.curvePointColor = [UIColor blueColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)awakeFromNib{
    self.pointColor = [UIColor redColor];
    self.curvePointColor = [UIColor blueColor];
    self.userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}
 */

-(UIView *)addPointViewByPoint:(CGPoint)point andNum:(int)number{
    self.pointView = [[UIView alloc] initWithFrame:CGRectMake(point.x-kPointWidth/2, point.y-kPointWidth/2, kPointWidth, kPointWidth)];
    self.pointView.alpha = 0.6;
    self.pointView.backgroundColor = self.pointColor;
    self.pointView.layer.borderColor = [UIColor yellowColor].CGColor;
    self.pointView.layer.borderWidth = 2;
    self.pointView.layer.cornerRadius = kPointWidth/2;
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kCurvePointWidth, kCurvePointWidth)];
    numberLabel.text = [NSString stringWithFormat:@"%d",number];
    numberLabel.textColor = [UIColor blueColor];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    
    [self.pointView addSubview:numberLabel];
    
    return self.pointView;
}

-(UIView *)addCurvePointViewByPoint:(CGPoint)point{
    self.curvePointView = [[UIView alloc] initWithFrame:CGRectMake(point.x-kPointWidth/2, point.y-kPointWidth/2, kPointWidth, kPointWidth)];
    self.curvePointView.alpha = 0.6;
    self.curvePointView.backgroundColor = self.curvePointColor;
    self.curvePointView.layer.borderColor = [UIColor redColor].CGColor;
    self.curvePointView.layer.borderWidth = 2;
    self.curvePointView.layer.cornerRadius = kPointWidth/2;
    
    return self.curvePointView;
}

-(BOOL)removeThePointViewByPoint:(UIView *)pointView{
    [pointView removeFromSuperview];
    return YES;
}

-(BOOL)moveTheView:(UIView *)pointView andNewCenter:(CGPoint)newCenter{
    pointView.center = newCenter;
    return YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    self.pointView.center = [[touches anyObject] locationInView:self.superview];
    NSLog(@"点的视图在移动");
}

@end
