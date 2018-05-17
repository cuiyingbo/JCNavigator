# JCNavigator
A decoupled navigator framework of jumping between modules or apps for iOS development. 

## Features
This framework supports the development of iOS 8.0+ in ARC.

* JCNavigator configs.
* Implement module maps.
* Jump operations with method openURL: or openProtocol:.

### JCNavigator configs

Set URL jump rules with hostList for scheme
```objective-c
[[JCNavigator sharedNavigator] addURLScheme:@"joych" hostList:@[@"com.joych.JCNavigatorDemo"]];
```

Module maps configs
```objective-c
[[JCNavigator sharedNavigator] addModuleMap:[JCRootModuleMap new]];
[[JCNavigator sharedNavigator] addModuleMap:[JCTestModuleMap new]];
[JCModuleMap setProtocolPrefix:@"JC"];
```

Navigation configs
```objective-c
[[JCNavigator sharedNavigator] setNavigationControllerClass:[JCNavigationController class]];
```

Set rootViewController
```objective-c
ViewController *vc = [[ViewController alloc] init];
[[JCNavigator sharedNavigator] setRootViewController:vc];
```

### Implement module maps

JCRootModuleMap class
```objective-c
@implementation JCRootModuleMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{@"JC_root": NSClassFromString(@"ViewController")};
}

@end
```

JCTestModuleMap class
```objective-c
@implementation JCTestModuleMap

- (NSDictionary<NSString *,Class> *)classesForProtocols
{
    return @{@"JC_firstLevel": NSClassFromString(@"JCFirstLevelViewController"),
            @"JC_secondLevel": NSClassFromString(@"JCSecondLevelViewController"),
            @"JC_thirdLevel": NSClassFromString(@"JCThirdLevelViewController"),
            @"JC_contentDetail": NSClassFromString(@"JCContentDetailViewController"),
            };
}

- (BOOL)presentedForClass:(Class)viewControllerClass
{
    if ([viewControllerClass isEqual:NSClassFromString(@"JCContentDetailViewController")]) {
        return YES;
    }
    return NO;
}

- (NSArray *)reuseViewControllerClasses
{
    return @[NSClassFromString(@"JCFirstLevelViewController")];
}

- (NSDictionary<NSString *,NSDictionary *> *)propertiesMapOfURLQueryForClasses
{
    return @{@"JCContentDetailViewController": @{@"pageindex": @"currentIndex"}};
}

@end
```

JC_contentDetail protocol
* Properties are suggested to be declared as NSString class because openURL: method only supports this data type.
* Properties also can be declared as NSArray / NSDictionary / NSSet / UIImage and so on data types, which can be used for openProtocol: method. For decoupling between modules, although you can use a custom object, it is not recommended.
```objective-c
@protocol JC_contentDetail <NSObject>

@property (nonatomic, strong) NSString *currentIndex;
@property (nonatomic, strong) NSString *testId;
@property (nonatomic, strong) NSArray *testArray;

@end
```

### Jump operations with method openURL: or openProtocol:

Open URL between modules or apps
```objective-c
[[JCNavigator sharedNavigator] openURL:[NSURL URLWithString:@"joych://com.joych.JCNavigatorDemo/secondlevel"]];

[[JCNavigator sharedNavigator] openURLString:@"joych://com.joych.jcnavigatordemo/contentdetail?pageindex=1"];

[[JCNavigator sharedNavigator] openURLString:UIApplicationOpenSettingsURLString];
```
```objective-c
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    return [[JCNavigator sharedNavigator] openURL:url options:options];
}
```

Open protocol between modules
```objective-c
[[JCNavigator sharedNavigator] openProtocol:NSProtocolFromString(@"JC_firstLevel")];

[[JCNavigator sharedNavigator] openProtocol:@protocol(JC_contentDetail) propertiesBlock:^NSDictionary *{
    return @{@"currentIndex": @"3"};
} presented:YES];
```

## CocoaPods
To integrate JCNavigator into your iOS project, specify it in your Podfile:

    pod 'JCNavigator'

## Contacts
If you have any questions or suggestions about the framework, please E-mail to contact me.

Author: [Joych](https://github.com/imjoych)    
E-mail: imjoych@gmail.com

## License
JCNavigator is released under the [MIT License](https://github.com/imjoych/JCNavigator/blob/master/LICENSE).

