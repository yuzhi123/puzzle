//
//  myAddressVC.m
//  Puzzle
//
//  Created by 王武 on 2017/10/26.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "myAddressVC.h"
#import "addressModel.h"
#import "addressCell.h"
#import "addressManagerVC.h"


@interface myAddressVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView* tabelView;

@property (nonatomic,strong) NSMutableArray* dataArrayCount;

@property (nonatomic, strong) addressCell *tempCell;

@end

@implementation myAddressVC



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"我的地址";
    self.view.backgroundColor = USER_BACK_COLOR;
    
    UIScrollView* scollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    scollV.backgroundColor = [UIColor redColor];
    [self.view addSubview:scollV];
    // 创建
    self.tempCell = [[addressCell alloc] initWithStyle:0 reuseIdentifier:@"addressCell"];
    
    
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
    self.dataArrayCount = [[NSMutableArray alloc] init];
    for (int i=0; i<15; i++) {
        addressModel *model = [[addressModel alloc] init];
        model.name = nameArr[arc4random()%nameArr.count];
        model.address = messageArr[arc4random()%messageArr.count];
        [self.dataArrayCount addObject:model];
    }

    UIButton* rightBT = [WWUI creatButton:CGRectMake(0, 0, 40, 40) targ:self sel:@selector(enterManager) titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] image:nil backGroundImage:nil title:@"管理 "];
    
    UIBarButtonItem* rightBarBt = [[UIBarButtonItem alloc]initWithCustomView:rightBT];
    
    self.navigationItem.rightBarButtonItem = rightBarBt;
    
    [self creatUI];
    
}

-(void)creatUI{
    [self.view addSubview:self.tabelView];
}

-(UITableView*)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDE, HIGH-64) style:UITableViewStylePlain];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        _tabelView.tableFooterView = [UIView new];
        _tabelView.showsVerticalScrollIndicator = NO;
        //_tabelView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tabelView;
}


// 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  return   self.dataArrayCount.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    addressCell* cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"] ;
    if (!cell) {
        cell = [[addressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addressCell"];
      
    }
      [cell configModel:self.dataArrayCount[indexPath.row]]; 
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    addressModel *model = self.dataArrayCount[indexPath.row];
    
    if (model.cellHeight == 0) {
        CGFloat cellHeight = [self.tempCell getHeightWithModel:self.dataArrayCount[indexPath.row]];
        
        // 缓存给model
        model.cellHeight = cellHeight;
        
        return cellHeight;
    } else {
        return model.cellHeight;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}



#pragma mark -- action
-(void)enterManager{
    addressManagerVC* vc = [[addressManagerVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES
     ];
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
