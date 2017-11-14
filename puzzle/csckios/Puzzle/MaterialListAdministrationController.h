//
//  MaterialListAdministrationController.h
//  Puzzle
//
//  Created by yiliu on 16/9/29.
//  Copyright © 2016年 mushoom. All rights reserved.
//

//素材管理

#import <UIKit/UIKit.h>

@protocol MaterialListAdministrationDelegate <NSObject>

/** 删除了模板 */
- (void)deleteTemplate:(NSInteger)deleteNum;

@end


@interface MaterialListAdministrationController : UIViewController

@property (nonatomic, weak) id <MaterialListAdministrationDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 查看的类型 */
@property (nonatomic, strong) NSString *type;

/** 数据 */
@property (strong, nonatomic) NSArray *dataArray;

@end
