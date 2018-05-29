//
//  JCRootModuleMap.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCRootModuleMap.h"

NSString *const JCRootMapKey = @"JC_root";

@implementation JCRootModuleMap

- (NSDictionary<NSString *,Class> *)classesForMapKeys
{
    return @{JCRootMapKey: NSClassFromString(@"ViewController")};
}

@end
