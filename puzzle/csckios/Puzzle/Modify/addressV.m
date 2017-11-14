//
//  addressV.m
//  Puzzle
//
//  Created by 王飞 on 2017/11/6.
//  Copyright © 2017年 mushoom. All rights reserved.
//

#import "addressV.h"

@interface addressV ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UITextField* nameTF;

@property (nonatomic,strong) UITextField* phoneTF;

@property (nonatomic,strong) UIButton* provinceBt;

@property (nonatomic,strong) UILabel* provinceLabel;

@property (nonatomic,strong) UIButton* streetBt;

@property (nonatomic,strong) UILabel* streetLabel;

@property (nonatomic,strong) UITextView* detailAddressTV;

@property (nonatomic,strong) WWUI* UIManager;

@property (nonatomic,strong) UIPickerView* pickerView;

@property (nonatomic,strong) UIView* pickerHeaderView;

@property (nonatomic,strong) NSArray* addressArray;

@property (nonatomic,strong) NSMutableArray* provinceArray;  // 省

@property (nonatomic,strong) NSMutableArray* allCityArray;  //所有的市

@property (nonatomic,strong) NSMutableArray* cityArray;  // 市

@property (nonatomic,strong) NSMutableArray* countyArray; //县

@property (nonatomic,strong) NSMutableArray* streetArray; //街道

@property (nonatomic,assign) NSInteger numberOfProvince;   // 当前省的序号

@property (nonatomic,assign) NSInteger numberOfCity;   //当前城市序号

@property (nonatomic,assign) NSInteger numberOfCounty; //当前县的序号

@end

@implementation addressV



-(UIPickerView*)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor colorWithRed:232.0/255 green:235.0/255 blue:235.0/255 alpha:232.0/255];
    }
    return _pickerView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    UIView* personView = [[UIView alloc]init];
    [self addSubview: personView];
    personView.backgroundColor = [UIColor whiteColor];
    [personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(rate(50));
        make.left.offset(0);
        make.top.offset(10);
    }];
   
    //姓名
    UILabel* nameTitle = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:0 font:[UIFont systemFontOfSize:17] textColor:USER_NAME_COLOR text:@"接收人"];
    [personView addSubview:nameTitle];
    [nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(personView);
        make.left.offset(15);
        make.top.offset(0);
    }];


    _UIManager = [[WWUI alloc]init];
    _nameTF = [_UIManager creatTextField:CGRectZero andBorderStyle:UITextBorderStyleNone andDelegate:_UIManager andKeyBord:UIKeyboardTypeDefault andNormalFont:17 andNorfontColor:USER_NAME_COLOR andPlaceColor:USER_NAME_COLOR andPlaceFont:17 andplaceHoder:@"请输入收件人姓名" andMaxNumberWord:8];
    _nameTF.textAlignment = 2;
    [personView addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(personView);
        make.centerY.mas_equalTo(nameTitle);
        make.right.mas_equalTo(personView.mas_right);
         make.width.mas_equalTo(self);
    }];
    
    UIView* nameLineView = [[UIView alloc]init];
    nameLineView.backgroundColor = USER_ORDER_COLOR;
    [self addSubview:nameLineView];
    [nameLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.right.mas_offset(-10);
        make.left.mas_offset(15);
        make.bottom.mas_equalTo(_nameTF.mas_bottom);
    }];
    
    // 联系电话
    UIView* phoneV = [[UIView alloc]initWithFrame:CGRectZero];
    phoneV.backgroundColor = [UIColor whiteColor];
    [self addSubview:phoneV];
    [phoneV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(personView);
        make.height.mas_equalTo(rate(50));
        make.left.offset(0);
        make.top.mas_equalTo(personView.mas_bottom);
    }];
    
    UILabel* phoneTitleLabel = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:1 font:[UIFont systemFontOfSize:17] textColor:USER_NAME_COLOR text:@"联系电话"];
    [phoneV addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(phoneV);
        make.left.offset(15);
        make.top.offset(0);
    }];
    
    
    _phoneTF = [_UIManager creatTextField:CGRectZero andBorderStyle:UITextBorderStyleNone andDelegate:self andKeyBord:UIKeyboardTypeDefault andNormalFont:17 andNorfontColor:USER_NAME_COLOR andPlaceColor:USER_NAME_COLOR andPlaceFont:17 andplaceHoder:@"请输入手机号" andMaxNumberWord:11];
    [_phoneTF setValue:[NSNumber numberWithInt:0] forKey:@"paddingRight"];
    _phoneTF.textAlignment = 2;
    [phoneV addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(phoneV);
        make.top.mas_equalTo(phoneV.mas_top);
        make.right.mas_equalTo(phoneV.mas_right);
        make.width.mas_equalTo(self);
    }];
    
    UIView* phoneLineV = [[UIView alloc]initWithFrame:CGRectZero];
    phoneLineV.backgroundColor = USER_ORDER_COLOR;
    [self addSubview:phoneLineV];
    [phoneLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-10);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(_phoneTF.mas_bottom);
    }];
    
    //地区
    _provinceBt = [WWUI creatButton:CGRectZero targ:self sel:@selector(provinceAction) titleColor:nil font:nil image:nil backGroundImage:nil title:nil];
    _provinceBt.backgroundColor = [UIColor whiteColor];
    [self addSubview:_provinceBt];
    [_provinceBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(phoneV);
        make.height.mas_equalTo(rate(50));
        make.left.offset(0);
        make.top.mas_equalTo(phoneV.mas_bottom);
    }];
    
    UILabel* titleLable = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:1 font:[UIFont systemFontOfSize:17] textColor:USER_NAME_COLOR text:@"所在地区"];
    [_provinceBt addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(phoneV);
        make.left.offset(15);
        make.top.offset(0);
    }];
  
    UIImageView* provinceImagev = [WWUI creatImageView:CGRectZero backGroundImageV:@"user_go"];
    [self addSubview:provinceImagev];
    [provinceImagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.mas_equalTo(-18);
        make.centerY.mas_equalTo(titleLable);
    }];
    
    _provinceLabel = [WWUI creatLabel:CGRectZero backGroundColor:nil textAligment:2 font:[UIFont systemFontOfSize:17] textColor:USER_NAME_COLOR text:@"请选择"];
    [_provinceBt addSubview:_provinceLabel];
    [_provinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.height.mas_equalTo(_provinceBt);
        make.right.mas_equalTo(provinceImagev.mas_left).offset(-5);
    }];
    
    
    // pickerView
    [self addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(rate(240));
        make.left.offset(0);
        make.bottom.offset(0);
    }];
    
    
    //pickerView head
    _pickerHeaderView = [[UIView alloc]init];
    _pickerHeaderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickerHeaderView];
    [_pickerHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(rate(40));
        make.width.mas_equalTo(WIDE);
        make.bottom.mas_equalTo(_pickerView.mas_top);
        make.left.offset(0);
    }];
    
    UIButton* cancelBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(cancelAction) titleColor:[UIColor colorWithRed:11.0/255 green:83.0/255 blue:1 alpha:1] font:[UIFont systemFontOfSize:18] image:nil backGroundImage:nil title:@"取消"];
    [_pickerHeaderView addSubview:cancelBt];
    [cancelBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(_pickerHeaderView);
        make.top.offset(0);
        make.left.offset(0);
    }];
    
    UIButton* confirmBt = [WWUI creatButtonWithHight:CGRectZero targ:self sel:@selector(confirmAction) titleColor:[UIColor colorWithRed:11.0/255 green:83.0/255 blue:1 alpha:1] font:[UIFont systemFontOfSize:18] image:nil backGroundImage:nil title:@"确认"];
    [_pickerHeaderView addSubview:confirmBt];
    [confirmBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(cancelBt);
        make.height.mas_equalTo(_pickerHeaderView);
        make.right.offset(0);
        make.centerY.mas_equalTo(cancelBt);
    }];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    _addressArray = [NSArray arrayWithContentsOfFile:filePath];

    _provinceArray = [NSMutableArray array];
    _allCityArray = [NSMutableArray array];
    _cityArray = [NSMutableArray array];
    _countyArray = [NSMutableArray array];
    
    
    for (NSDictionary* dic in _addressArray) {
        [_provinceArray addObject:[dic objectForKey:@"state"]];
        NSArray* citySubDicArray = [dic objectForKey:@"cities"];
        NSMutableArray* citySubArray = [NSMutableArray array];
        for (NSDictionary* dic in citySubDicArray) {
            [citySubArray addObject:[dic objectForKey:@"city"]];
        }
        [self.allCityArray addObject:citySubArray];
        
    }
    
    self.cityArray = self.allCityArray.firstObject;
    
    
}

#pragma mark -- picker代理
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return WIDE/3.0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return rate(36);
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:  //省
            {
                return self.provinceArray[row];
              
            }
            break;
        case 1: // 市
            {
                return self.cityArray[row];
            }
            break;
        case 2:  //县
            {
                return @"222";
            }
            break;
            
        default:
            break;
    }
    return @"333";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:  //省  取城市
        {
            self.cityArray = self.allCityArray[row];
              [self.pickerView reloadComponent:1];
        }
            break;
        case 1: // 市
        {
            
        }
            break;
        case 2:  //县
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    switch (component) {
        case 0:  //省
        {
            return self.provinceArray.count;
        }
            break;
        case 1: // 市
        {
            return self.cityArray.count;
        }
            break;
        case 2:  //县
        {
            return self.countyArray.count;
        }
            break;
            
        default:
            break;
    }
    return 0;
}



#pragma mark -- action
-(void)provinceAction{
    NSLog(@"地区选择");
}

-(void)streetAction{
    NSLog(@"街道选择");
}

-(void)cancelAction{
    NSLog(@"pickerView取消");
}

-(void)confirmAction{
    NSLog(@"pickerView确定");
}

#pragma mark -- pickerView


@end
