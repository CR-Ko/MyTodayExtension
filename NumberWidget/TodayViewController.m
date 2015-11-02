//
//  TodayViewController.m
//  NumberWidget
//
//  Created by ko on 2015/9/23.
//  Copyright © 2015年 KK. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

@implementation TodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.preferredContentSize = CGSizeMake(320, 320);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Press Me" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button sizeToFit];
    button.center = CGPointMake(320/2, 60);
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    
    [self updateNumberLabelText];
}

- (void)buttonPressed:(UIButton *)button {
    NSLog(@"Button Pressed");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateNumberLabelText];
}

- (void)updateNumberLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.ko.TodayExtensionSharingDefaults"];
    NSInteger number = [defaults integerForKey:@"MyNumberKey"];
    self.numberLabel.text = [NSString stringWithFormat:@"%d", number];
}

@end
