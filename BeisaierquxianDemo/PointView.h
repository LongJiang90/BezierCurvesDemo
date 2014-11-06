//
//  PointView.h
//  beisaierDemo
//
//  Created by 楊盧银Mac on 14-5-10.
//  Copyright (c) 2014年 com.yly16. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointView : UIView

//控制点的颜色
@property (nonatomic,strong) UIColor *pointColor;
@property (nonatomic,strong) UIColor *curvePointColor;
@property (nonatomic,strong) UIView *pointView;
@property (nonatomic,strong) UIView *curvePointView;

//添加一个点的view
-(UIView *)addPointViewByPoint:(CGPoint)point andNum:(int)number;
-(UIView *)addCurvePointViewByPoint:(CGPoint)point;
//删除一个点的view
-(BOOL)removeThePointViewByPoint:(UIView *)pointView;
//移动一个点的view
-(BOOL)moveTheView:(UIView *)pointView andNewCenter:(CGPoint)newCenter;

@end
