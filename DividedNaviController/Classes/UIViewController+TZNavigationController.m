//
//  UIViewController+TZNavigationController.m
//  Pods
//
//  Created by Tom.Zid on 19/08/2017.
//
//

#import "UIViewController+TZNavigationController.h"
#import <objc/runtime.h>
@implementation UIViewController (TZNavigationController)
- (TZNavigationController *)tzNavigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTzNavigationController:(TZNavigationController *)tzNavigationController {
    objc_setAssociatedObject(self, @selector(tzNavigationController), tzNavigationController, OBJC_ASSOCIATION_ASSIGN);
}
@end
