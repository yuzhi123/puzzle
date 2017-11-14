//
//  AddStorySetController.m
//  Puzzle
//
//  Created by yiliu on 2016/10/20.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "AddStorySetController.h"
#import "StorySetHeadView.h"
#import "StorySetView.h"
#import "TimeView.h"

@interface AddStorySetController ()<StorySetHeaderDelegate,TimeViewDelegate>{

    //故事头
    StorySetHeadView *storySetHeadView;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AddStorySetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    storySetHeadView = [[StorySetHeadView alloc] initWithFrame:CGRectMake(17, 17, WIDE-34, (WIDE/320)*370)];
    storySetHeadView.delegate = self;
    storySetHeadView.imageArry = self.imagesArray;
    [_scrollView addSubview:storySetHeadView];
    
    _scrollView.contentSize = CGSizeMake(WIDE, HIGH);
    
}

#pragma -mark StorySetHeaderDelegate 编辑时间
- (void)editTimeHeader {
    TimeView *timeView = [[TimeView alloc] init];
    timeView.delegate = self;
    [self.view addSubview:timeView];
}

#pragma -mark TimeViewDelegate 选择时间
- (void)choiceTime:(NSString *)time {
    storySetHeadView.time = time;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)imagesArray {
    if (!_imagesArray) {
        _imagesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _imagesArray;
}

@end
