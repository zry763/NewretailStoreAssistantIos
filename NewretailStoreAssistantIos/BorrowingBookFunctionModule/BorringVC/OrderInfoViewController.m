//
//  OrderInfoViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/24.
//  Copyright © 2019 zry. All rights reserved.
//

#import "OrderInfoViewController.h"
#import "OrderInfoTableViewCell.h"

@interface OrderInfoViewController ()
@property (strong , nonatomic) UIButton *closeBt;
@property (strong , nonatomic) UILabel *bookNum;

@end

@implementation OrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[TRCColor colorFromHexCode:@"#F2F2F2"];
    
    [self registerCellWithNibName:NSStringFromClass([OrderInfoTableViewCell class]) reuseIdentifier:NSStringFromClass([OrderInfoTableViewCell class])];
    
    // Do any additional setup after loading the view.
}
-(void)setupTableView{
    [super setupTableView];
    
    [self.view addSubview:self.closeBt];
    [self.closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-10);
        make.top.equalTo(self.view).with.offset(10);
    }];
    UILabel *titleLable =[[UILabel alloc]init];
    [titleLable setFont:[UIFont systemFontOfSize:18]];
    [titleLable setText:@"借阅的书籍"];
    [self.view addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(self.view).with.offset(30);
    }];
    
    [self.view addSubview:self.bookNum];
    
    [self.bookNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLable.mas_right).with.offset(10);
        make.centerY.equalTo(titleLable);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLable).with.offset(30);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView.backgroundColor = [TRCColor colorFromHexCode:@"#F2F2F2"];
 
}

-(UILabel *)bookNum{
    if (!_bookNum) {
        _bookNum = [[UILabel alloc]init];
        _bookNum.text=@"(4)";
        [_bookNum setFont:[UIFont systemFontOfSize:18]];
        [_bookNum setTextColor:[TRCColor colorFromHexCode:@"#D33A31"]];
    }
    return _bookNum;
}
-(UIButton *)closeBt{
    if (!_closeBt) {
        _closeBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBt setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
        [_closeBt addTarget:self action:@selector(closeCurrentView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBt;
}

-(void)closeCurrentView{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderInfoTableViewCell class]) forIndexPath:indexPath];
    return cell;
}
//
- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler (YES);
        [self.tableView reloadData];
    }];
    deleteRowAction.title = @"左滑删除";
    deleteRowAction.backgroundColor = [UIColor redColor];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
