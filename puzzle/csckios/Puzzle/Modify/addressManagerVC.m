//
//  addressManagerVC.m
//  Puzzle
//
//  Created by 王飞 on 2017/11/6.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "addressManagerVC.h"
#import "addressManagerCell.h"
#import "addressModel.h"

@interface addressManagerVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;

@property (nonatomic,strong) NSMutableArray* dataArray;

@property (nonatomic, strong) addressManagerCell *tempCell;

@end

@implementation addressManagerVC

#pragma mark -- property
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDE, HIGH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = USER_BACK_COLOR;
    self.title = @"管理收货地址";
    
    // 模拟一些数据源
    NSArray *nameArr = @[@"张三：",
                         @"李四：",
                         @"王五：",
                         @"陈六：",
                         @"吴老二："];
    NSArray *messageArr = @[@"ash快点回家爱是妒忌哈市党和国家按时到岗哈时代光华撒国会大厦国会大厦国会大厦更好的噶山东黄金撒旦哈安师大噶是个混蛋撒",
                            @"傲世江湖点撒恭候大驾水草玛瑙现在才明白你个坏蛋擦边沙尘暴你先走吧出现在",
                            @"撒点花噶闪光灯",
                            @"按时间大公司大概好久撒大概好久撒党和国家按时到岗哈师大就萨达数据库化打算几点撒谎就看电视骄傲的撒金葵花打暑假工大撒比的撒谎讲大话手机巴士差距啊市场报价啊山东黄金as擦伤擦啊as擦肩时擦市场报价按时VC阿擦把持啊三重才撒啊双层巴士吃按时吃啊双层巴士擦报啥错",
                            @"as大帅哥大孤山街道安师大好噶时间过得撒黄金国度"];
    // 向数据源中随机放入500个Model
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<15; i++) {
        addressModel *model = [[addressModel alloc] init];
        model.name = nameArr[arc4random()%nameArr.count];
        model.address = messageArr[arc4random()%messageArr.count];
        [self.dataArray addObject:model];
    }
    self.tempCell = [[addressManagerCell alloc] initWithStyle:0 reuseIdentifier:@"addressMangerCell"];
    
    [self creatUI];
}

-(void)creatUI{
    
    [self.view addSubview:self.tableView];
}


#pragma mark -- tableView 代理


#pragma mark -- action

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    //return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    addressManagerCell* cell = [tableView dequeueReusableCellWithIdentifier:@"addressMangerCell"];
    if (!cell) {
        cell = [[addressManagerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressMangerCell"];
    }
    [cell configModel:self.dataArray[indexPath.row]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    addressModel *model = self.dataArray[indexPath.row];
    
    if (model.cellHeight == 0) {
        CGFloat cellHeight = [self.tempCell getHeightWithModel:self.dataArray[indexPath.row]];
        
        // 缓存给model
        model.cellHeight = cellHeight;
        
        return cellHeight;
    } else {
        return model.cellHeight;
    }
    
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
