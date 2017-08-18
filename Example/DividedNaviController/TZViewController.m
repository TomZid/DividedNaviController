#import "TZViewController.h"

@interface TZViewController ()

@end

@implementation TZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [self randomColor];
    self.navigationController.navigationBar.barTintColor = [self randomColor];
}

- (UIColor*)randomColor {
    CGFloat red = arc4random() % 177 / 255.0, green = arc4random() % 177 / 255.0, blue = arc4random() % 177 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (IBAction)push:(id)sender {
    TZViewController *vc = [[TZViewController alloc] initWithNibName:@"TZViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
