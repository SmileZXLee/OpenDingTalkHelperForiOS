//
//  ZXEmptyActionButton.m
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/2.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import "ZXEmptyActionButton.h"
@interface ZXEmptyActionButton()
@property(copy,nonatomic)zx_clickedBlock block;
@end
@implementation ZXEmptyActionButton

- (void)zx_addTarget:(id)target action:(SEL)sel{
    _zx_addedClickCallBackOrAction = YES;
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if(self.zx_hanldeClickedBlock){
        self.zx_hanldeClickedBlock(self);
    }
    [super sendAction:action to:target forEvent:event];
}

- (void)zx_clickedBlock:(zx_clickedBlock)block{
    _zx_addedClickCallBackOrAction = YES;
    _block = block;
    [self addTarget:self action:@selector(clickedAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickedAction:(UIButton *)button{
    if(self.block){
        self.block(button);
    }
}

@end
