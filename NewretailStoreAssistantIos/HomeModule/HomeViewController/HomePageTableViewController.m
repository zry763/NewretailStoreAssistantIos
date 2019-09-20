//
//  HomePageTableViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "HxListViewController.h"
#import "BorringHomeViewController.h"

@interface HomePageTableViewController ()

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
-(StoreDetailTableViewCell *)storeDetailCell{
    if (!_storeDetailCell) {
        
        [self registerCellWithNibName:NSStringFromClass([StoreDetailTableViewCell class]) reuseIdentifier:NSStringFromClass([StoreDetailTableViewCell class])];
        _storeDetailCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreDetailTableViewCell class])];
        
    }
    return _storeDetailCell;
}
-(FunctionTableViewCell *)functionCell{
    if (!_functionCell) {
        
        [self registerCellWithNibName:NSStringFromClass([FunctionTableViewCell class]) reuseIdentifier:NSStringFromClass([FunctionTableViewCell class])];
        _functionCell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FunctionTableViewCell class])];
        TRC_BLOCK_WEAK_SELF
        _functionCell.functionIndex = ^(NSInteger index) {
            NSString *backTitle;
            
            switch (index) {
                case 100:
                    backTitle = @"库存盘点";
                    [weakSelf resetBackButtonTitleWith:backTitle and:[UIColor clearColor]];

                    break;
                case 101:
                    backTitle = @"预约核销";
                    [weakSelf resetBackButtonTitleWith:backTitle and:[UIColor clearColor]];

                    [weakSelf.navigationController pushViewController:[[HxListViewController alloc]init] animated:YES];
                    break;

                case 102:
                    backTitle = @"图书借阅";
                    [weakSelf resetBackButtonTitleWith:backTitle and:[UIColor clearColor]];

                    [weakSelf.navigationController pushViewController:[[BorringHomeViewController alloc]init] animated:YES];
                    break;

                default:
                    break;
            }
            
            

            
        };

    }
    return _functionCell;
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    if (indexPath.row ==0) {
        return self.storeDetailCell;

    }else if (indexPath.row == 1){
    
        return self.functionCell;
    }
    
    return [BaseTableViewCell new];
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
