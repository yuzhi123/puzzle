//
//  PZPhotoTimelineVC.m
//  Puzzle
//
//  Created by 孙鲜艳 on 2017/4/10.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "PZPhotoTimelineVC.h"

#import "YLPhotoPickerController.h"

@interface PZPhotoTimelineVC ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationbarItem;
@property (nonatomic, strong) YLPhotoPickerController *ylPhotoPicker;
@end

@implementation PZPhotoTimelineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _ylPhotoPicker = [[YLPhotoPickerController alloc] init ];
//    _ylPhotoPicker.view.frame = CGRectMake(0, 49, self.view.bounds.size.height-49, self.view.bounds.size.width);
//    _ylPhotoPicker.isMultiselect = YES;
//    
//    [self addChildViewController:_ylPhotoPicker];
//    [self.view addSubview:_ylPhotoPicker.view];
}

- (IBAction)okButtonClick:(id)sender {
//    [_ylPhotoPicker determine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
