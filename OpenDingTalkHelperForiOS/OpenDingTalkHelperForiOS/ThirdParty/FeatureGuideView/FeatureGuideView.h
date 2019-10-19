//
//  FeatureGuideView.h
//  FeatureGuideView
//
//  Created by Yee on 2018/3/20.
//  Copyright © 2018年 Yee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FeatureGuideViewStyle)
{
    FeatureGuideViewNoneStyle  = 0,
    FeatureGuideViewUpStyle    = 1 << 1,
    FeatureGuideViewDownStyle  = 1 << 2,
    FeatureGuideViewLeftStyle  = 1 << 3,
    FeatureGuideViewRightStyle = 1 << 4,
};
@interface FeatureGuideObject : NSObject
@property(nonatomic,retain)UIView   *targetView;
@property(nonatomic,assign)CGRect   targetViewFrame;
@property(nonatomic,assign)CGFloat  cornerRadius;
@property(nonatomic,assign)UIEdgeInsets targetViewInset;
@property(nonatomic,  copy)NSString *indicatorImageName;
@property(nonatomic,assign)CGRect   indicatorFrame;
@property(nonatomic,assign)CGRect   introduceViewFrame;
@property(nonatomic,strong)NSString *introduce;
@property(nonatomic,strong)UIFont   *introduceFont;
@property(nonatomic,strong)UIColor  *introduceTextColor;
@property (nonatomic, copy)void(^action)(id sender);
@property(nonatomic,  copy)NSString *buttonTitle;
@property(nonatomic,retain)UIColor  *buttonTitleColor;
@property(nonatomic,  copy)NSString *buttonBackgroundImageName;
@end

@interface FeatureGuideView : UIView
@property(nonatomic,retain)UIColor *fillColor;
@property(nonatomic,assign)CGFloat opacity;

+(BOOL)CheckGuideViewInOnlyVersion:(NSString*)appVersion indentify:(NSString*)Indentifystring;

+(FeatureGuideView*)showGuideViewWithObjects:(NSArray<FeatureGuideObject *>*)objects version:(NSString*)appversion  identify:(NSString*)identifyString   InView:(UIView*)inView;

+(FeatureGuideView*)showGuideViewWithObjects:(NSArray<FeatureGuideObject *>*)objects  InView:(UIView*)inView;

-(instancetype)initWithObjects:(NSArray<FeatureGuideObject *>*)objects InView:(UIView*)inView;

-(void)removeObjectsFromContainViewAnimated:(BOOL)animate;

-(void)removeObjectsFromContainView;

@end
