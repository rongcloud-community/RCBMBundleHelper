//
//  RCBMViewController.m
//  RCBMBundleHelper
//
//  Created by gongjiahao on 09/08/2022.
//  Copyright (c) 2022 gongjiahao. All rights reserved.
//

#import "RCBMViewController.h"
#import <RCBMBundleHelper/RCBMBundleHelper.h>

@interface RCBMViewController ()

@end

@implementation RCBMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage * image = [UIImage imageNamed:@"icon_next" formRCBMPod:@"RCBMBundleHelper"];
    UIImageView *imgview = [[UIImageView alloc] initWithImage:image];
    imgview.frame = CGRectMake(30, 64, 24, 42);
    [self.view addSubview:imgview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
