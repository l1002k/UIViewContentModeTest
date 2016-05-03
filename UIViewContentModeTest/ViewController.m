//
//  ViewController.m
//  ImageContentMode
//
//  Created by leikun on 16/4/29.
//  Copyright © 2016年 leikun. All rights reserved.
//

#import "ViewController.h"

@interface myImageView : UIImageView

@end

@implementation myImageView



@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic)IBOutlet UIView *contentModeView;
@property(nonatomic)IBOutlet UITableView *contentModeTableView;
@property(nonatomic)IBOutlet NSLayoutConstraint *contentModeTableViewTop;
@property(nonatomic)IBOutlet UIButton *contentModeButton;
@property(nonatomic)IBOutlet UIButton *contentModeMaskButton;


@property(nonatomic)IBOutlet UIView *maskView;
@property(nonatomic)IBOutlet UIPanGestureRecognizer *panGesture;

@property(nonatomic)IBOutlet UIImageView *imageView;
@property(nonatomic)IBOutlet NSLayoutConstraint *imageViewWidth;
@property(nonatomic)IBOutlet NSLayoutConstraint *imageViewHeight;

@property(nonatomic)IBOutlet UILabel *imageSizeLabel;
@property(nonatomic)IBOutlet UILabel *imageViewFrameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.contentModeTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"contentModeTableViewCellIdentifier"];
    self.imageSizeLabel.text = [NSString stringWithFormat:@"image size : %@", NSStringFromCGSize(self.imageView.image.size)];
    self.imageViewFrameLabel.text = [NSString stringWithFormat:@"imageView frame : %@", NSStringFromCGRect(self.imageView.frame)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)panAction:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint velocity = [pan velocityInView:pan.view];
        CGPoint point = [pan translationInView:pan.view];
        CGFloat constant = 0.f;
        if (ABS(velocity.x) >= ABS(velocity.y)) {
            constant = self.imageViewWidth.constant + point.x;
            constant = constant > 0.f ? constant : 0.f;
            self.imageViewWidth.constant = constant;
        } else {
            constant = self.imageViewHeight.constant + point.y;
            constant = constant > 0.f ? constant : 0.f;
            self.imageViewHeight.constant = constant;
        }
        self.imageViewFrameLabel.text = [NSString stringWithFormat:@"imageView frame : %@", NSStringFromCGRect(self.imageView.frame)];
        [pan setTranslation:CGPointZero inView:pan.view];
    }
}

- (IBAction)contentModeMaskButtonAction:(id)tap {
    [self hiddenContentModeView];
}

- (IBAction)contentModeButtonAction:(id)sender {
    [self showContentModeView];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13; // UIViewContentModeBottomRight
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentModeTableViewCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [self getContentModeStringByIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.imageView.contentMode = indexPath.row;
    self.imageViewWidth.constant = 198;
    self.imageViewHeight.constant = 288.f;
    [self.contentModeButton setTitle:[self getContentModeStringByIndexPath:indexPath] forState:UIControlStateNormal];
    self.imageViewFrameLabel.text = [NSString stringWithFormat:@"imageView frame : %@", NSStringFromCGRect(self.imageView.frame)];
    [self hiddenContentModeView];
}

#pragma mark - contentMode改变相关UI
- (void)showContentModeView {
    self.contentModeView.hidden = NO;
    self.contentModeMaskButton.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.contentModeTableViewTop.constant = 0.f;
        [self.view layoutIfNeeded];
    }];
}

- (void)hiddenContentModeView {
    [UIView animateWithDuration:0.2 animations:^{
        self.contentModeTableViewTop.constant = -128.f;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.contentModeView.hidden = YES;
        self.contentModeMaskButton.hidden = YES;
    }];
}

- (NSString *)getContentModeStringByIndexPath:(NSIndexPath *)indexPath {
    NSString *textString = @"UIViewContentModeScaleToFill";
    switch (indexPath.row) {
        case 0:
            textString = @"UIViewContentModeScaleToFill";
            break;
        case 1:
            textString = @"UIViewContentModeScaleAspectFit";
            break;
        case 2:
            textString = @"UIViewContentModeScaleAspectFill";
            break;
        case 3:
            textString = @"UIViewContentModeRedraw";
            break;
        case 4:
            textString = @"UIViewContentModeCenter";
            break;
        case 5:
            textString = @"UIViewContentModeTop";
            break;
        case 6:
            textString = @"UIViewContentModeBottom";
            break;
        case 7:
            textString = @"UIViewContentModeLeft";
            break;
        case 8:
            textString = @"UIViewContentModeRight";
            break;
        case 9:
            textString = @"UIViewContentModeTopLeft";
            break;
        case 10:
            textString = @"UIViewContentModeTopRight";
            break;
        case 11:
            textString = @"UIViewContentModeBottomLeft";
            break;
        case 12:
            textString = @"UIViewContentModeBottomRight";
            break;
        default:
            break;
    }
    return textString;
}

@end
