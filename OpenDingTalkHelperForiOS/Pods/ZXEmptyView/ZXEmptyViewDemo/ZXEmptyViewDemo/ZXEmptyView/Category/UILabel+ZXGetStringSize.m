//
//  UILabel+ZXGetStringSize.m
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/4.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import "UILabel+ZXGetStringSize.h"

@implementation UILabel (ZXGetStringSize)


- (CGFloat)zx_getNormalStringWidth{
    return [self zx_getNormalStringWidthWithFixHeight:self.frame.size.height];
}

- (CGFloat)zx_getNormalStringWidthWithFixHeight:(CGFloat)fixHeight{
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, fixHeight)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font}
                                          context:nil].size;
    return size.width;
}

- (CGFloat)zx_getAttrStringWidth{
    return [self zx_getAttrStringWidthWithFixHeight:self.frame.size.height];
}

- (CGFloat)zx_getAttrStringWidthWithFixHeight:(CGFloat)fixHeight{
    CGSize size = [self.attributedText boundingRectWithSize:CGSizeMake(MAXFLOAT, fixHeight)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                    context:nil].size;
    return size.height;
}

- (CGFloat)zx_getNormalStringHeight{
    return [self zx_getNormalStringHeightWithFixWidth:self.frame.size.width];
}

- (CGFloat)zx_getNormalStringHeightWithFixWidth:(CGFloat)fixWidth{
    if(!fixWidth)return 0;
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(fixWidth, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font}
                                          context:nil].size;
    return size.height;
}

- (CGFloat)zx_getAttrStringHeight{
    return [self zx_getAttrStringHeightWithFixWidth:self.frame.size.width];
}

- (CGFloat)zx_getAttrStringHeightWithFixWidth:(CGFloat)fixWidth{
    if(!fixWidth)return 0;
    CGSize size = [self.attributedText boundingRectWithSize:CGSizeMake(MAXFLOAT, fixWidth)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                    context:nil].size;
    return size.height;
}




@end
