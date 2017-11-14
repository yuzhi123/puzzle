//
//  loadNav.m
//  Puzzle
//
//  Created by 王武 on 2017/9/12.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "loadNav.h"
#import "loginVC.h"

static loadNav* Nav;
@interface loadNav ()

@end

@implementation loadNav

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


+(loadNav*)shareLoadVC
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginVC* vc = [[loginVC alloc]init];
        Nav = [[loadNav alloc]initWithRootViewController:vc];
        [Nav.navigationBar setBarTintColor:[UIColor whiteColor]];
        Nav.navigationBar.translucent = NO;
    });
    return Nav;
}


-(void)setBarTinColor:(UIColor*) bartinColor withtitleFont:(NSInteger)fontSize andNavIsHidden:(BOOL)isHidden andtitle:(NSString*)title andTitleColor:(UIColor*)fontColor{
    
    [Nav.navigationBar setBarTintColor:bartinColor];
    [Nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:fontColor}];
    Nav.navigationItem.title = title;
    if (isHidden) {
        Nav.navigationBar.hidden = YES;
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
