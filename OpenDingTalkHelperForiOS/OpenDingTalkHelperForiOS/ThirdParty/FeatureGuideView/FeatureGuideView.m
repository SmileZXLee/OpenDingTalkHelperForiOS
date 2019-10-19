//
//  FeatureGuideView.m
//  FeatureGuideView
//
//  Created by Yee on 2018/3/20.
//  Copyright © 2018年 Yee. All rights reserved.
//
#import "FeatureGuideView.h"

@implementation FeatureGuideObject


@end

@interface FeatureGuideView ()

@property(nonatomic,retain)CAShapeLayer   *maskLayer;
@property(nonatomic,weak)  UIView         *containView;
@property(nonatomic,retain)UIView         *introduceView;
@property(nonatomic,retain)UIButton       *skipButton;
@property(nonatomic,retain)UIImageView    *indicatorImageView;
@property(nonatomic,retain)NSArray        *objectItems;
@property(nonatomic,assign)NSInteger      currentIndex;
@end
@implementation FeatureGuideView
+(BOOL)CheckGuideViewInOnlyVersion:(NSString*)appVersion indentify:(NSString*)Indentifystring
{
    //只在特定版本才会显示
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    bool isExit = [[NSUserDefaults standardUserDefaults] boolForKey:[Indentifystring stringByAppendingString:@"_FeatureGuideView"]];
    if ([appVersion isEqualToString:app_Version]&&isExit==NO)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[Indentifystring stringByAppendingString:@"_FeatureGuideView"]];
        return YES;
    }
    return NO;
}
#pragma mark removeObject
-(void)removeObjectsFromContainViewAnimated:(BOOL)animate
{
    if (animate==NO)
    {
        [self.skipButton removeFromSuperview];
        self.containView = nil;
        [self removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha =0.0;
    } completion:^(BOOL finished)
     {
        [self.skipButton removeFromSuperview];
        self.containView = nil;
        [self removeFromSuperview];
    }];
}
-(void)removeObjectsFromContainView
{
    [self removeObjectsFromContainViewAnimated :NO];
}
+(FeatureGuideView*)showGuideViewWithObjects:(NSArray<FeatureGuideObject *>*)objects version:(NSString*)appversion identify:(NSString*)identifyString InView:(UIView*)inView
{
    if ([FeatureGuideView CheckGuideViewInOnlyVersion:appversion indentify:identifyString])
    {
      return [FeatureGuideView showGuideViewWithObjects:objects InView:inView];
    }else
    {
        return [FeatureGuideView new];
    }
}
+(FeatureGuideView*)showGuideViewWithObjects:(NSArray<FeatureGuideObject *>*)objects  InView:(UIView*)inView
{
    return [[FeatureGuideView alloc] initWithObjects:objects InView:inView];
}
-(instancetype)initWithObjects:(NSArray<FeatureGuideObject *>*)objects InView:(UIView*)inView{
    
    if (inView == nil) inView = [[UIApplication sharedApplication].windows lastObject];
    if (inView.frame.size.width==0|inView.frame.size.height==0)inView.bounds=[UIScreen mainScreen].bounds;
    if (self=[super initWithFrame:inView.bounds])
    {
        NSAssert(objects.count>0,@"(NSArray<GuideObject *>*)objects  must be not nil");
        self.containView  =inView;
        self.objectItems  =objects;
        self.currentIndex = 0;
        [self add_OwnView];
        [self goToCoachMarkIndexed:self.currentIndex];
    }
    return self;
}
#pragma mark private method
-(void)add_OwnView{
    
    [self.containView addSubview:self];
    [self setBackgroundColor:[UIColor clearColor]];
    [self.layer addSublayer:self.maskLayer];
    //ges
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGuideViewTodoNextGes:)];
    [self addGestureRecognizer:tapGes];
    
}
#pragma mark clickGuideView next
-(void)clickGuideViewTodoNextGes:(UIGestureRecognizer*)ges
{
    self.currentIndex++;
    [self goToCoachMarkIndexed:self.currentIndex];
}
//递归进入这个方法
- (void)goToCoachMarkIndexed:(NSUInteger)index{
    
    if (self.currentIndex>=self.objectItems.count)
    {
        [self removeObjectsFromContainView];
        return;
    }
    FeatureGuideObject *object=self.objectItems[index];
    CGRect targetFrame = object.targetView ?[object.targetView convertRect:object.targetView.bounds toView:self] :object.targetViewFrame;
    UIBezierPath *bezierPath=[UIBezierPath bezierPathWithRect:self.bounds];
    targetFrame.origin.x += object.targetViewInset.left;
    targetFrame.origin.y += object.targetViewInset.top;
    targetFrame.size.width += object.targetViewInset.right - object.targetViewInset.left;
    targetFrame.size.height += object.targetViewInset.bottom - object.targetViewInset.top;
    [bezierPath appendPath:[UIBezierPath bezierPathWithRoundedRect:targetFrame cornerRadius:object.cornerRadius]];
    self.maskLayer.path =bezierPath.CGPath;
    [self update_subViewsConstanit:object];
}
#pragma mark layout SubViews
-(void)update_subViewsConstanit:(FeatureGuideObject*)object{
 
    [self.introduceView removeFromSuperview];
    [self.skipButton removeFromSuperview];
    self.indicatorImageView.transform = CGAffineTransformIdentity;
    self.introduceView=nil;
    self.skipButton =nil;
    CGRect targetFrame = object.targetView?[object.targetView convertRect:object.targetView.bounds toView:self]:object.targetViewFrame;
    if (object.action|| object.introduce)
    {
        NSString *imageName = object.indicatorImageName ?: @"icon_ea_indicator";
        UIImage *indicatorImage = [UIImage imageNamed:imageName];
        CGSize imageSize = CGSizeMake(indicatorImage.size.width, indicatorImage.size.height);
        self.indicatorImageView.image =indicatorImage;
        self.indicatorImageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        [self addSubview :self.indicatorImageView];
        //布局介绍文案
        if(object.introduce)
        {
            NSString *typeString = [[[object.introduce componentsSeparatedByString:@"."] lastObject] lowercaseString];
            if([typeString isEqualToString:@"png"] || [typeString isEqualToString:@"jpg"] || [typeString isEqualToString:@"jpeg"])
            {
                UIImage *introduceImage = [UIImage imageNamed:object.introduce];
                
                imageSize = CGSizeMake(introduceImage.size.width, introduceImage.size.height);
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:introduceImage];
                
                imageView.clipsToBounds = YES;
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                
                self.introduceView = imageView;
            }
            else
            {
                UILabel *introduceLabel = [[UILabel alloc] init];
                introduceLabel.backgroundColor = [UIColor clearColor];
                introduceLabel.numberOfLines = 0;
                introduceLabel.text = object.introduce;
                
                introduceLabel.font = object.introduceFont ?: [UIFont systemFontOfSize:13];
                
                introduceLabel.textColor = object.introduceTextColor ?: [UIColor whiteColor];
                
                self.introduceView = introduceLabel;
            }
            [self addSubview :self.introduceView];
        }
        //布局按钮
        if(object.action || object.buttonTitle)
        {
            [self.skipButton setBackgroundImage:[[UIImage imageNamed:object.buttonBackgroundImageName ?:  @"icon_ea_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)] forState:UIControlStateNormal];
            
            if(object.buttonTitle.length <= 0)
            {
                 object.buttonTitle = @"知道了";
            }
            self.skipButton.backgroundColor = ODMainColor;
            self.skipButton.layer.cornerRadius = 4;
            [self.skipButton setTitle:object.buttonTitle forState:UIControlStateNormal];
            [self.skipButton sizeToFit];
            [self.skipButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            CGRect frame = self.skipButton.frame;
            frame.size.width += 20;
            frame.size.height += 10;
            self.skipButton.frame = frame;
            [self addSubview :self.skipButton];
        }
    }
    FeatureGuideViewStyle location = [self calculateSkipBtnStylewithObject:object];
    CGRect introduceFrame =self.introduceView.frame;
    const CGFloat verticalSpacing = 10;
    if (location & FeatureGuideViewUpStyle || location == FeatureGuideViewNoneStyle)
    {
        //将箭头的锚点移动到顶部中间
        self.indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 0);
        self.indicatorImageView.center = CGPointMake(CGRectGetMinX(targetFrame) + CGRectGetWidth(targetFrame) / 2, CGRectGetMinY(targetFrame) + CGRectGetHeight(targetFrame) + verticalSpacing);
        //箭头方向左上
        if(location & FeatureGuideViewLeftStyle)
        {
            CGAffineTransform transform = self.indicatorImageView.transform;
            self.indicatorImageView.transform = CGAffineTransformRotate(transform, - M_PI / 4);
            //计算介绍的位置
            if([self.introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = self.indicatorImageView.frame.origin.x;
                introduceFrame.origin.y = CGRectGetMaxY(self.indicatorImageView.frame) + verticalSpacing;
                self.introduceView.frame = introduceFrame;
            }
            else if([self.introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [object.introduce boundingRectWithSize:CGSizeMake(self.bounds.size.width - self.indicatorImageView.frame.origin.x * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)self.introduceView).font} context:nil];
                
                self.introduceView.frame = CGRectMake(self.indicatorImageView.frame.origin.x, CGRectGetMaxY(self.indicatorImageView.frame) + verticalSpacing, rect.size.width, rect.size.height);
            }
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的右端
            if(self.introduceView.frame.size.width < self.indicatorImageView.frame.size.width)
            {
                CGPoint center = self.introduceView.center;
                center.x = self.indicatorImageView.frame.origin.x + self.indicatorImageView.frame.size.width;
                self.introduceView.center = center;
            }
        }
        //箭头方向右上
        else if(location&FeatureGuideViewRightStyle)
        {
            CGAffineTransform transform = self.indicatorImageView.transform;
            self.indicatorImageView.transform = CGAffineTransformRotate(transform,M_PI / 4);
            //计算介绍的位置
            if([self.introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = self.indicatorImageView.frame.origin.x + self.indicatorImageView.frame.size.width - introduceFrame.size.width;
                
                introduceFrame.origin.y = CGRectGetMaxY(self.indicatorImageView.frame) + verticalSpacing;
                
                self.introduceView.frame = introduceFrame;
            }
            else if([self.introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [object.introduce boundingRectWithSize:CGSizeMake( self.bounds.size.width - (self.bounds.size.width - self.indicatorImageView.frame.origin.x - self.indicatorImageView.frame.size.width) * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)self.introduceView).font} context:nil];
                
                self.introduceView.frame = CGRectMake(self.indicatorImageView.frame.origin.x + self.indicatorImageView.frame.size.width - rect.size.width, CGRectGetMaxY(self.indicatorImageView.frame) + verticalSpacing, rect.size.width, rect.size.height);
            }
            
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的右端
            if(self.introduceView.frame.size.width < self.indicatorImageView.frame.size.width)
            {
                CGPoint center =self.introduceView.center;
                center.x = self.indicatorImageView.frame.origin.x;
                self.introduceView.center = center;
            }
        }
        else //垂直向上
        {
            //计算介绍的位置
            if([self.introduceView isKindOfClass:[UIImageView class]])
            {
                self.introduceView.center = CGPointMake(self.indicatorImageView.center.x, CGRectGetMaxY(self.indicatorImageView.frame) + verticalSpacing + introduceFrame.size.height / 2);
            }
            else if([self.introduceView isKindOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel *)self.introduceView;
                label.textAlignment = NSTextAlignmentCenter;
                CGRect rect = [object.introduce boundingRectWithSize:CGSizeMake(self.bounds.size.width * 3 / 4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)self.introduceView).font} context:nil];
                self.introduceView.frame = CGRectMake((self.bounds.size.width - rect.size.width) / 2, CGRectGetMaxY(self.indicatorImageView.frame) + verticalSpacing, rect.size.width, rect.size.height);
            }
        }
    }
    //箭头方向下,布局方式是先布局介绍文案->布局按钮
    else if (location&FeatureGuideViewDownStyle){
        //是否需要布局按钮
        CGFloat buttonVerticalOccupySpace = (object.action || object.buttonTitle)? CGRectGetHeight(self.skipButton.frame) + verticalSpacing : 0;
        
        //箭头方向左下
        if(location&FeatureGuideViewLeftStyle)
        {
            //将箭头的锚点移动到低部中间
            self.indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 1.f);
            //计算箭头的位置
            self.indicatorImageView.center = CGPointMake(CGRectGetMinX(targetFrame) + CGRectGetWidth(targetFrame) / 2, CGRectGetMinY(targetFrame) - CGRectGetHeight(self.indicatorImageView.frame));
            CGAffineTransform transform = self.indicatorImageView.transform;
            transform = CGAffineTransformTranslate(transform, CGRectGetHeight(self.indicatorImageView.frame) * sinf(M_PI / 4), 0);
            self.indicatorImageView.transform = CGAffineTransformRotate(transform,  - M_PI * 3 / 4);
            //计算介绍的位置
            if([self.introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = self.indicatorImageView.frame.origin.x;
                introduceFrame.origin.y = CGRectGetMinY(self.indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - CGRectGetHeight(self.introduceView.frame);
                self.introduceView.frame = introduceFrame;
            }
            else if([self.introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [object.introduce boundingRectWithSize:CGSizeMake(self.bounds.size.width - self.indicatorImageView.frame.origin.x * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)self.introduceView).font} context:nil];
                
                self.introduceView.frame = CGRectMake(self.indicatorImageView.frame.origin.x, CGRectGetMinY(self.indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - rect.size.height, rect.size.width, rect.size.height);
            }
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的右端
            if(self.introduceView.frame.size.width < self.indicatorImageView.frame.size.width)
            {
                CGPoint center = self.introduceView.center;
                center.x = self.indicatorImageView.frame.origin.x + self.indicatorImageView.frame.size.width;
                self.introduceView.center = center;
            }
        }
        //箭头方向右下
        else if(location & FeatureGuideViewRightStyle)
        {
            //将箭头的锚点移动到低部中间
            self.indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 1.f);
            //计算箭头的位置
            self.indicatorImageView.center = CGPointMake(CGRectGetMinX(targetFrame) + CGRectGetWidth(targetFrame) / 2, CGRectGetMinY(targetFrame) - CGRectGetHeight(self.indicatorImageView.frame));
            CGAffineTransform transform = self.indicatorImageView.transform;
            transform = CGAffineTransformTranslate(transform, - CGRectGetHeight(self.indicatorImageView.frame) * sinf(M_PI / 4), 0);
            self.indicatorImageView.transform = CGAffineTransformRotate(transform, M_PI * 3 / 4);
            //计算介绍的位置
            if([self.introduceView isKindOfClass:[UIImageView class]])
            {
                introduceFrame.origin.x = self.indicatorImageView.frame.origin.x + self.indicatorImageView.frame.size.width - introduceFrame.size.width;
                
                introduceFrame.origin.y = CGRectGetMinY(self.indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - CGRectGetHeight(self.introduceView.frame);
                
                self.introduceView.frame = introduceFrame;
            }
            else if([self.introduceView isKindOfClass:[UILabel class]])
            {
                CGRect rect = [object.introduce boundingRectWithSize:CGSizeMake(self.bounds.size.width - (self.bounds.size.width -self.indicatorImageView.frame.origin.x - self.indicatorImageView.frame.size.width) * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)self.introduceView).font} context:nil];
                
                self.introduceView.frame = CGRectMake(self.indicatorImageView.frame.origin.x + self.indicatorImageView.frame.size.width - rect.size.width, CGRectGetMinY(self.indicatorImageView.frame) - verticalSpacing - buttonVerticalOccupySpace - rect.size.height, rect.size.width, rect.size.height);
            }
            
            //如果文案的宽度小于箭头指示器的宽度,则将文案的中心设置成指示器的左端
            if(self.introduceView.frame.size.width < self.indicatorImageView.frame.size.width)
            {
                CGPoint center = self.introduceView.center;
                center.x = self.indicatorImageView.frame.origin.x;
                self.introduceView.center = center;
            }
        }
        else //垂直向下
        {
            //将箭头的锚点移动到顶部中间
            //indicatorImageView.layer.anchorPoint = CGPointMake(.5f, 0.f);
            self.indicatorImageView.center = CGPointMake(CGRectGetMinX(targetFrame) + CGRectGetWidth(targetFrame) / 2, CGRectGetMinY(targetFrame) - verticalSpacing - CGRectGetHeight(self.indicatorImageView.bounds) / 2);
            CGAffineTransform transform = self.indicatorImageView.transform;
            self.indicatorImageView.transform = CGAffineTransformRotate(transform, M_PI);
            //计算介绍的位置
            if([self.introduceView isKindOfClass:[UIImageView class]])
            {
                self.introduceView.center = CGPointMake(self.indicatorImageView.center.x, CGRectGetMinY(self.indicatorImageView.frame) - buttonVerticalOccupySpace - verticalSpacing - introduceFrame.size.height / 2);
            }
            else if([self.introduceView isKindOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel *)self.introduceView;
                label.textAlignment = NSTextAlignmentCenter;
                
                CGRect rect = [object.introduce boundingRectWithSize:CGSizeMake(self.bounds.size.width * 3 / 4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: ((UILabel *)self.introduceView).font} context:nil];
                self.introduceView.frame = CGRectMake((self.bounds.size.width - rect.size.width) / 2, CGRectGetMinY(self.indicatorImageView.frame)  - buttonVerticalOccupySpace - verticalSpacing - rect.size.height, rect.size.width, rect.size.height);
            }
        }
    }
    self.skipButton.center = CGPointMake(self.introduceView.center.x, CGRectGetMaxY(self.introduceView.frame) + verticalSpacing + self.skipButton.frame.size.height / 2);
}
#pragma mark clickBtn action
-(void)buttonAction:(UIButton *)btn
{
    FeatureGuideObject *object = self.objectItems[self.currentIndex];
    if (object.action)
    {
        object.action(self);
    }
    self.currentIndex++;
    [self goToCoachMarkIndexed:self.currentIndex];
}
-(FeatureGuideViewStyle)calculateSkipBtnStylewithObject:(FeatureGuideObject*)object
{
    FeatureGuideViewStyle viewStyle =FeatureGuideViewNoneStyle;
    CGRect frame = object.targetView ? [object.targetView convertRect:object.targetView.bounds toView:self] : object.targetViewFrame;
    const NSInteger split = 16;
    //将展示区域分割成16*16的区域
    CGFloat squareWidth = self.window.bounds.size.width / split;
    CGFloat squareHeight = self.window.bounds.size.height / split;
    
    CGFloat leftSpace = frame.origin.x;
    CGFloat rightSpace = self.window.bounds.size.width - (frame.origin.x + frame.size.width);
    CGFloat topSpace = frame.origin.y;
    CGFloat bottomSpace = self.window.bounds.size.height - (frame.origin.y + frame.size.height);
    //如果focusView的x轴上的宽占据了绝大部分则认为是横向居中的
    if(frame.size.width <= squareWidth * (split - 1))
    {
        //左边
        if((leftSpace - rightSpace) >= squareWidth)
        {
            viewStyle |= FeatureGuideViewRightStyle;
        }
        //右边
        else if((rightSpace - leftSpace) >= squareWidth)
        {
            viewStyle |= FeatureGuideViewLeftStyle;
        }
    }
    //上边
    if((topSpace - bottomSpace) > squareHeight)
    {
        viewStyle |= FeatureGuideViewDownStyle;
    }
    //下边
    else if((bottomSpace - topSpace) > squareHeight)
    {
        viewStyle |= FeatureGuideViewUpStyle;
    }
    else
    {
        viewStyle |= FeatureGuideViewDownStyle;
    }
    return viewStyle;
}
#pragma mark set method
-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    self.maskLayer.fillColor = fillColor.CGColor;
}
-(void)setOpacity:(CGFloat)opacity{
    _opacity = opacity;
    self.maskLayer.opacity = opacity;
}
#pragma mark lazyMethod
-(UIButton*)skipButton{
    
    if (_skipButton==nil)
    {
        _skipButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton setTitle:@"知道了" forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton .titleLabel.font =[UIFont systemFontOfSize:14];
    }
    return _skipButton;
}
-(UIImageView *)indicatorImageView{
    
    if (_indicatorImageView==nil)
    {
        _indicatorImageView=[[UIImageView alloc] init];
        _indicatorImageView.clipsToBounds = YES;
        _indicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _indicatorImageView;
}
-(CAShapeLayer*)maskLayer
{
    if (_maskLayer==nil)
    {
        _maskLayer=[CAShapeLayer layer];
        _maskLayer.fillRule = kCAFillRuleEvenOdd;
        _maskLayer.fillColor =[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.8f].CGColor;
        _maskLayer.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        _maskLayer.opacity = 0.9;
    }
    return _maskLayer;
}
-(void)dealloc
{
    NSLog(@"dealloc");
}
@end
