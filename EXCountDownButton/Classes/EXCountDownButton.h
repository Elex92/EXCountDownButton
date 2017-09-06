//
//  EXCountDownButton.h
//  Pods
//
//  Created by 沈丰元 on 2017/9/6.
//
//  APP常用发送验证码倒计时按键

#import <UIKit/UIKit.h>

@interface EXCountDownButton : UIButton
//设置开始倒计时的时间 默认是60s
@property(nonatomic,assign)NSInteger count;
//点击按钮
@property(nonatomic,copy)void(^ClickButtonBlock)();
//倒计时完成后的回调
@property(nonatomic,copy)void(^CompleteBlock)();
/**
 *  初始化
 *
 *  @param isAuto 是否自动倒计时
 *
 *  @return 实例对象
 */
-(instancetype)initWithIsAuto:(BOOL)isAuto;
/**
 *  初始化
 *
 *  @param frame  坐标
 *  @param isAuto 是否自动倒计时
 *
 *  @return 实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame withIsAuto:(BOOL)isAuto;
/**
 *  手动触发-开始倒计时
 */
-(void)start;
/**
 *  手动触发-结束倒计时
 */
-(void)stop;
@end
