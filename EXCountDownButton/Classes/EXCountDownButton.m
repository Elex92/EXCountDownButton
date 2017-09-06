//
//  EXCountDownButton.m
//  Pods
//
//  Created by 沈丰元 on 2017/9/6.
//
//

#import "EXCountDownButton.h"

//默认的倒计时60s
static const NSInteger DefaultCount = 60;

//默认字体颜色
#define  DefaultNormalColor [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1]
//默认字体颜色
#define  DefaultDisableColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
//设置默认背景颜色
#define  DefaultBgColor   [UIColor clearColor]

@interface EXCountDownButton()
//剩余的时间
@property(nonatomic,assign)NSInteger remainCount;
//计时器
@property(nonatomic,strong)NSTimer *timer;
@end
#import "EXCountDownButton.h"

@implementation EXCountDownButton

-(instancetype)initWithIsAuto:(BOOL)isAuto{
    if (self = [super init]) {
        _count = DefaultCount;
        _remainCount = DefaultCount;
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        self.titleLabel.font=[UIFont systemFontOfSize:16];
        [self setTitleColor:DefaultNormalColor forState:UIControlStateNormal];
        [self setTitleColor:DefaultDisableColor forState:UIControlStateDisabled];
        [self setBackgroundColor:DefaultBgColor];
        
        
        if (isAuto) {
            [self setTitle:[NSString stringWithFormat:@"剩余%02ld秒",_count] forState:0];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
        }else{
            [self setTitle:@"获取验证码" forState:0];
        }
        
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withIsAuto:(BOOL)isAuto{
    if (self = [super initWithFrame:frame]) {
        _count = DefaultCount;
        _remainCount = DefaultCount;
        
        [self setTitleColor:DefaultNormalColor forState:UIControlStateNormal];
        [self setTitleColor:DefaultDisableColor forState:UIControlStateDisabled];
        [self setBackgroundColor:DefaultBgColor];
        
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        if (isAuto) {
            [self setTitle:[NSString stringWithFormat:@"剩余%02ld秒",_count] forState:0];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
        }else{
            [self setTitle:@"重新获取" forState:0];
        }
        
        
    }
    return self;
}


-(void)setCount:(NSInteger)count{
    _count = count;
    _remainCount = count;
}


-(void)timerStart:(NSTimer *)timer{
    if (_remainCount == 0) {
        _remainCount = _count;
        [self stop];
    }else{
        
        _remainCount --;
        [self setTitle:[NSString stringWithFormat:@"剩余%02ld秒",_remainCount] forState:0];
    }
}

-(void)click{
    if (_ClickButtonBlock) {
        self.ClickButtonBlock();
    }
}
-(void)start
{
    self.enabled = NO;
    [self setTitle:[NSString stringWithFormat:@"剩余%02ld秒",_count] forState:0];
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    }
}
-(void)stop{
    self.enabled = YES;
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
    }
    
    if (_CompleteBlock) {
        self.CompleteBlock();
    }
}



-(void)dealloc{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}


@end
