#import "TZNavigationController.h"
#import "TZWrapViewController.h"

@interface TZNavigationController () <UINavigationControllerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) id<UIGestureRecognizerDelegate> panGestureDelete;
@end

@implementation TZNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.viewControllers = @[
                                 [TZWrapViewController wrapViewControllerWithViewController:rootViewController]
                                 ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    _panGestureDelete = self.interactivePopGestureRecognizer.delegate;
    
    SEL sel = NSSelectorFromString(@"handleNavigationTransition:");
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:_panGestureDelete action:sel];
    _panGesture.maximumNumberOfTouches = 1;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL root = viewController == navigationController.viewControllers.firstObject;
    if (root) {
        [self.view removeGestureRecognizer:_panGesture];
    }else {
        [self.view addGestureRecognizer:_panGesture];
    }
}

@end
