//
//  HXStateViewController.m
//  NewretailStoreAssistantIos
//
//  Created by zry on 2019/9/18.
//  Copyright © 2019 zry. All rights reserved.
//

#import "HXStateViewController.h"
#import "HXTableViewCell.h"
#import "HXDetailsViewController.h"
#import "HXSearchViewController.h"

@interface HXStateViewController ()

@property(strong ,nonatomic) THCustomSegmentView *segmentView;
@property(assign,nonatomic) NSInteger selectIndex;
@property(strong ,nonatomic) UIButton *scrollTopBT;

@end

@implementation HXStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self registerCellWithNibName:NSStringFromClass([HXTableViewCell class]) reuseIdentifier:NSStringFromClass([HXTableViewCell class])];

    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setupSubviews{
    [self.view addSubview:self.segmentView];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchSomeDetail)];
    self.navigationItem.rightBarButtonItem = searchItem;
    self.scrollToTopEnable = YES;
    [self.view addSubview:self.scrollTopBT];


    [self.scrollTopBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-50);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
    }];

}
-(void)searchSomeDetail{
    NSLog(@"搜索");
    
    [self.navigationController pushViewController:[[HXSearchViewController alloc]init] animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.scrollTopBT];

}

-(UIButton *)scrollTopBT{
    
    if (!_scrollTopBT) {
        _scrollTopBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scrollTopBT setImage:[UIImage imageNamed:@"backTop"] forState:UIControlStateNormal];
        [_scrollTopBT addTarget:self action:@selector(scrollToTop:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _scrollTopBT;
    
}
-(THCustomSegmentView *)segmentView{
    
    if (!_segmentView) {
        
        NSArray *titleArray = @[@"待核销",@"已核销"];
        self.segmentView = [[THCustomSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,40 ) withTitleArray:titleArray block:^(id segment, NSInteger index) {
            
            if (self.selectIndex == index) {
                return ;
            }

            [self requestTableViewDataSource];
        }];
        
        _segmentView.titleSelectColor = [TRCColor colorFromHexCode:@"#D33A31"];
        _segmentView.indictorColor =[TRCColor colorFromHexCode:@"#D33A31"];
        _segmentView.isShowButtomLine = YES;
    }
    return _segmentView;
}
- (void)setupTableView {
    [super setupTableView];
   
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).with.offset(45);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HXTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXTableViewCell class]) forIndexPath:indexPath];
    cell.hxItemStateImage.hidden = YES;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self resetBackButtonTitleWith:@"预约详情"and:[UIColor clearColor]];
    [self.navigationController pushViewController:[[HXDetailsViewController alloc]init] animated:YES];
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
