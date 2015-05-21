//
//  InstallViewController.m
//  TVForInstaller
//
//  Created by AlienLi on 15/5/18.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import "InstallViewController.h"
#import "InstallSegmentViewController.h"

#import "S1ViewController.h"
#import "InstallHistoryViewController.h"

#import "ComminUtility.h"

#import "InstallHistoryDetailController.h"
#import "S1DetailController.h"

@interface InstallViewController ()<InstallSegmentViewControllerDelegate,S1SelectionDelegate>

@end



@implementation InstallViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Install" bundle:nil];
    
    InstallSegmentViewController *navigationController = [[InstallSegmentViewController alloc]initWithRootViewController:pageController];
    
    
    
    S1ViewController *vc1 = [sb instantiateViewControllerWithIdentifier:@"S1ViewController"];
    vc1.delegate = self;

    InstallHistoryViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"InstallHistoryViewController"];
    vc2.delegate = self;
    
    [navigationController.viewControllerArray addObjectsFromArray:@[vc1,vc2]];
    
    
    [self addChildViewController:navigationController];
    
    navigationController.view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64 - 44);
    
    [self.view addSubview:navigationController.view];
    
    
    
    [navigationController willMoveToParentViewController:self];
    [navigationController didMoveToParentViewController:self];
    
    [ComminUtility configureTitle:@"装机" forViewController:self];
    
    self.navigationItem.leftBarButtonItem = nil;

}

-(void)needToShowViewController:(NSIndexPath *)path{
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Install" bundle:nil];
    
    InstallHistoryDetailController *detail = [sb instantiateViewControllerWithIdentifier:@"InstallHistoryDetailController"];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController showViewController:detail sender:nil];
}
-(void)didSelectionDelegate:(NSIndexPath *)indexPath{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Install" bundle:nil];
    
    S1DetailController *detail = [sb instantiateViewControllerWithIdentifier:@"S1DetailController"];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController showViewController:detail sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end