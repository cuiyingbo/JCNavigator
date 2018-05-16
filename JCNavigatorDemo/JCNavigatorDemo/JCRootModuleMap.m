//
//  JCRootModuleMap.m
//  JCNavigatorDemo
//
//  Created by ChenJianjun on 2018/5/5.
//  Copyright © 2018 Joych<https://github.com/imjoych>. All rights reserved.
//

#import "JCRootModuleMap.h"

@implementation JCRootModuleMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{@"JC_root": NSClassFromString(@"ViewController")};
}

@end
