//
//  AddressController.m
//  Puzzle
//
//  Created by yiliu on 16/9/12.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "AddressController.h"
#import "AButton.h"
#import "Auxiliary.h"
#import "MBProgressHUD.h"

@interface AddressController ()<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>{
    
    NSString *type;

    NSInteger provinceIndex;
    NSInteger cityIndex;
    NSInteger quyuIndex;
    
}

@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet AButton *provinceBtn;
@property (weak, nonatomic) IBOutlet AButton *cityBtn;
@property (weak, nonatomic) IBOutlet AButton *quyuBtn;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UIView *bkPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *apickerView;


@property (strong, nonatomic) NSArray *addressArray;
@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *quyuArray;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation AddressController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_selectAddress) {
        _choiceBtn.hidden = NO;
    }
    
    provinceIndex = 0;
    cityIndex = 0;
    quyuIndex = 0;
    
    _addressTextView.delegate = self;
    _addressTextView.textColor = RGBACOLOR(200, 200, 200, 1);
    
    _provinceBtn.title.text = @"请选择省份";
    _cityBtn.title.text = @"请选择城市";
    _quyuBtn.title.text = @"请选择区/县";
    
    _nameField.delegate = self;
    _phoneNumField.delegate = self;
    _apickerView.dataSource = self;
    _apickerView.delegate = self;
    
    [self getProvince];
    
    NSDictionary *addressDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ReceiptAddress"];
    if (addressDict) {
        _nameField.text = addressDict[@"name"];
        _phoneNumField.text = addressDict[@"phoneNumber"];
        _provinceBtn.title.text = addressDict[@"province"];
        _cityBtn.title.text = addressDict[@"city"];
        _quyuBtn.title.text = addressDict[@"quyu"];
        _addressTextView.text = addressDict[@"address"];
        _addressTextView.textColor = [UIColor blackColor];
    }
    
}

#pragma mark - 获取城市数据
-(void)getProvince{
    
    //从文件读取地址字典
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    _addressArray = [dict objectForKey:@"address"];
    
}

#pragma -mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _bkPickerView.hidden = YES;
}

#pragma -mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _bkPickerView.hidden = YES;
    if([textView.text isEqual:@"详细地址"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text isEqual:@""]){
        textView.text = @"详细地址";
        textView.textColor = RGBACOLOR(200, 200, 200, 1);
    }
}

// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
}

// UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

//内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([type isEqual:@"省份"]) {
        provinceIndex = row;
    }else if ([type isEqual:@"城市"]) {
        cityIndex = row;
    }else if ([type isEqual:@"区县"]) {
        quyuIndex = row;
    }
}

//省
- (IBAction)provinceView:(id)sender {
    
    [self.view endEditing:YES];
    _bkPickerView.hidden = NO;
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:@"请选择省份"];
    for (NSDictionary *dict in _addressArray) {
        [self.dataArray addObject:dict[@"name"]];
    }
    
    type = @"省份";
    [_apickerView selectRow:0 inComponent:0 animated:NO];
    [_apickerView reloadAllComponents];
    
}

//城市
- (IBAction)cityView:(id)sender {
    
    if (provinceIndex == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请先选择省份";
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1];
        return;
    }
    
    [self.view endEditing:YES];
    _bkPickerView.hidden = NO;
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:@"请选择城市"];
    for (NSDictionary *dict in _addressArray[provinceIndex-1][@"sub"]) {
        [self.dataArray addObject:dict[@"name"]];
    }
    
    type = @"城市";
    [_apickerView selectRow:0 inComponent:0 animated:NO];
    [_apickerView reloadAllComponents];
    
}

//区县
- (IBAction)quyuView:(id)sender {
    
    if (provinceIndex == 0 || cityIndex == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"请先选择城市";
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1];
        return;
    }
    
    [self.view endEditing:YES];
    _bkPickerView.hidden = NO;
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:@"请选择区/县"];
    [self.dataArray addObjectsFromArray:_addressArray[provinceIndex-1][@"sub"][cityIndex-1][@"sub"]];
    
    type = @"区县";
    [_apickerView selectRow:0 inComponent:0 animated:NO];
    [_apickerView reloadAllComponents];
    
}

//完成
- (IBAction)determineChoice:(id)sender {
    _bkPickerView.hidden = YES;
    
    if ([type isEqual:@"省份"]) {
        _provinceBtn.title.text = self.dataArray[provinceIndex];
    }else if ([type isEqual:@"城市"]) {
        _cityBtn.title.text = self.dataArray[cityIndex];
    }else if ([type isEqual:@"区县"]) {
        _quyuBtn.title.text = self.dataArray[quyuIndex];
    }
}

//保存
- (IBAction)preservation:(id)sender {
    
    if ([_nameField.text isEqual:@""]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"姓名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }else if ([_phoneNumField.text isEqual:@""]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    
    }else if (![Auxiliary isMobileNumber:_phoneNumField.text]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    
    }else if ([_provinceBtn.title.text isEqual:@"请选择省份"]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"省份不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }else if ([_cityBtn.title.text isEqual:@"请选择城市"]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"城市不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }else if ([_quyuBtn.title.text isEqual:@"请选择区/县"]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"区/县不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }else if ([_addressTextView.text isEqual:@""] && ![_addressTextView.text isEqual:@"详细地址"]) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"详细地址不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        
    }
    
    NSDictionary *addressDict = @{@"name":_nameField.text,
                                  @"phoneNumber":_phoneNumField.text,
                                  @"province":_provinceBtn.title.text,
                                  @"city":_cityBtn.title.text,
                                  @"quyu":_quyuBtn.title.text,
                                  @"address":_addressTextView.text};
    
    //保存收货地址
    [[NSUserDefaults standardUserDefaults] setObject:addressDict forKey:@"ReceiptAddress"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"保存成功";
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    //1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
    
}

//返回上一页
- (IBAction)retunView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//确定选择
- (IBAction)choice:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(choiceAddress)]) {
        [self.delegate choiceAddress];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [[NSMutableArray alloc] init];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [[NSMutableArray alloc] init];
    }
    return _cityArray;
}

- (NSMutableArray *)quyuArray{
    if (!_quyuArray) {
        _quyuArray = [[NSMutableArray alloc] init];
    }
    return _quyuArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
