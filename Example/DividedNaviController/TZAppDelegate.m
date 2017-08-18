#import "TZAppDelegate.h"
#import <DividedNaviController/TZNavigationController.h>
#import "TZViewController.h"

@implementation TZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    TZViewController *vc = [[TZViewController alloc] initWithNibName:@"TZViewController" bundle:nil];
    TZNavigationController *navi = [[TZNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
