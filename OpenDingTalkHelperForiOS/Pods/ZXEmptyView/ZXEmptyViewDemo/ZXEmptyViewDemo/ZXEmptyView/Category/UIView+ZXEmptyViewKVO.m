//
//  UIView+ZXEmptyViewKVO.m
//  ZXEmptyView
//
//  Created by ZXLee on 2019/10/4.
//  Copyright © 2019 ZXLee. All rights reserved.
//  https://github.com/SmileZXLee/ZXEmptyView

#import "UIView+ZXEmptyViewKVO.h"
#import "NSObject+ZXEmptySwizzleMethod.h"
#import <objc/runtime.h>
static NSString *zx_observingKeyPathDictionaryKey = @"zx_observingKeyPathDictionaryKey";
@implementation UIView (ZXEmptyViewKVO)
+ (void)load{
    zx_swizzleMethod(self, NSSelectorFromString(@"dealloc"), @selector(zx_dealloc));
}

- (void)zx_dealloc{
    if(self.zx_observingKeyPathDictionary){
        for (NSString *key in self.zx_observingKeyPathDictionary.allKeys) {
            [self removeObserver:self forKeyPath:key];
        }
    }
    [self zx_dealloc];
}

- (void)setZx_observingKeyPathDictionary:(NSMutableDictionary *)zx_observingKeyPathDictionary{
    objc_setAssociatedObject(self, &zx_observingKeyPathDictionaryKey, zx_observingKeyPathDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)zx_observingKeyPathDictionary{
    return objc_getAssociatedObject(self, &zx_observingKeyPathDictionaryKey);
}

-(void)zx_obsKey:(NSString *)key handler:(obsResultHandler)handler{
    [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:(__bridge_retained void *)([handler copy])];
    if(!self.zx_observingKeyPathDictionary){
        self.zx_observingKeyPathDictionary = [NSMutableDictionary dictionary];
    }
    [self.zx_observingKeyPathDictionary setValue:handler forKey:key];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if(object == self){
        obsResultHandler handler = (__bridge obsResultHandler)context;
        handler(change[@"new"],change[@"old"],self);
    }
}
@end
