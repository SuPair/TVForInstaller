//
//  AppTableViewController.m
//  TVForInstaller
//
//  Created by AlienLi on 15/5/20.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import "AppTableViewController.h"

#import "ComminUtility.h"

#import "AppOneInstallCell.h"
#import "AppCollectionTableCell.h"
#import "APPCollectionViewCell.h"

#import "NetworkingManager.h"
#import <JGProgressHUD.h>

#import <UIImageView+WebCache.h>

@interface AppTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong) NSMutableArray *appLists;

@end

@implementation AppTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [ComminUtility configureTitle:@"应用" forViewController:self];
    self.navigationItem.leftBarButtonItem = nil;
    
    
    
    [self fetchApplicationList];
    
}

-(void)fetchApplicationList{
    
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    hud.textLabel.text = @"正在获取应用列表";
    [hud showInView:self.view];
    
    
    
    [NetworkingManager fetchApplicationwithCompletionHandler:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"success"] integerValue] == 0) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                hud.indicatorView = nil;
                hud.textLabel.text =@"列表获取失败";
                [hud dismissAfterDelay:2.0];
            });
            
            
        } else{
            //获取成功
            
            
            [hud dismissAfterDelay:2.0];
            
            NSArray *temp = responseObject[@"obj"];
            [self dealResponseData:temp];

            
        }
        
        
        
        
    } failHandler:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud dismiss];
    }];
}

-(void)dealResponseData:(NSArray *)obj{

    if (obj.count >0) {
        
        _appLists = [obj mutableCopy];
        
        [self.tableView reloadData];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _appLists.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    
    if (indexPath.section == 0) {
        AppOneInstallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppOneInstallCell" forIndexPath:indexPath];
        
        return cell;
    } else{
        AppCollectionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppCollectionTableCell" forIndexPath:indexPath];
        
        cell.collectionView.tag = indexPath.section -1;
        
        return cell;

    }
    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
 
    if (section ==0 ) {
        return nil;
    } else{
        return _appLists[section -1][@"classify"];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 83;
    }else {
        return 150;
    }
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *softList = _appLists[collectionView.tag][@"softlist"];
    return softList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    APPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"APPCollectionViewCell" forIndexPath:indexPath];
    
    cell.appImageView  = [UIImageView ]
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
