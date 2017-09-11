/**
 *  xib中设置TableView的HeaderView
 *  http://blog.csdn.net/ideaspress/article/details/48804939
 */
#import "TZViewController.h"

static CGFloat TZViewController_LeadingConstraint_Constant_original;
static CGFloat TZViewController_TopConstraint_Constant_original;

@interface TZViewController ()
{
    UILabel *TZViewController_TitleLabel;
    
    __weak IBOutlet NSLayoutConstraint *leadingConstraint;
    __weak IBOutlet UILabel *titleLabel;
}
@end

@implementation TZViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [self randomColor];
    self.navigationController.navigationBar.barTintColor = [self randomColor];
    
    TZViewController_LeadingConstraint_Constant_original = leadingConstraint.constant;
    TZViewController_TopConstraint_Constant_original = CGRectGetMinY(titleLabel.frame);
    
    // new label replaces the original titleLabel which in this case attached on the _UINavigationBarContentView
    TZViewController_TitleLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:titleLabel.frame];
        label.text = titleLabel.text;
        label.hidden = YES;
        label;
    });
    [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
            [self.navigationController.view insertSubview:TZViewController_TitleLabel aboveSubview:obj];
        }
    }];
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

- (void)configureTitleLabel:(CGPoint)contentOffset {
    CGFloat contentOffset_Y = contentOffset.y;
    CGFloat offset = contentOffset_Y + CGRectGetHeight(self.navigationController.navigationBar.bounds) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    
    // top offset
    if (offset >= TZViewController_TopConstraint_Constant_original) {
        TZViewController_TitleLabel.hidden = NO;
        titleLabel.hidden = YES;
        offset = TZViewController_TopConstraint_Constant_original;
    }else {
        TZViewController_TitleLabel.hidden = YES;
        titleLabel.hidden = NO;
    }
    
    // right offset
    leadingConstraint.constant = TZViewController_LeadingConstraint_Constant_original + offset;
    
    // convert rect from self.tableview to self.navigationController.navigationBar coordinate
    CGRect rect = [self.tableView.tableHeaderView convertRect:titleLabel.frame toView:self.navigationController.navigationBar];
    
    //constraint top of the rising label
    CGFloat y = MAX(rect.origin.y + 20, CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + CGRectGetMidY(self.navigationController.navigationBar.bounds) - CGRectGetMidY(TZViewController_TitleLabel.bounds));
    rect.origin.y = y;
    
    //assgin frame
    TZViewController_TitleLabel.frame = rect;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [self configureTitleLabel:[change[@"new"] CGPointValue]];
}

@end
