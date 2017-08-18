//
//  TZWrapViewController.m
//  TZNavigationViewController
//
//  Created by Tom.Zid on 17/08/2017.
//  Copyright © 2017 TZ. All rights reserved.
//

#import "TZWrapViewController.h"

@interface TZWrapNavigationController : UINavigationController @end

@implementation TZWrapNavigationController
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *vc = (UIViewController*)[TZWrapViewController wrapViewControllerWithViewController:viewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

@end

@interface TZWrapViewController () @end

@implementation TZWrapViewController
+ (UIViewController*)wrapViewControllerWithViewController:(UIViewController*)viewController {
    
    TZWrapNavigationController *navi = [TZWrapNavigationController new];
    navi.viewControllers = @[
                             viewController
                             ];
    
    TZWrapViewController *vc = [TZWrapViewController new];
    [vc.view addSubview:navi.view];
    [vc addChildViewController:navi];
    
    return vc;
}

@end
