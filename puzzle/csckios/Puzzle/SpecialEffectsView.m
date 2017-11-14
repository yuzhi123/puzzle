//
//  SpecialEffectsView.m
//  meitu
//
//  Created by yiliu on 15/5/27.
//  Copyright (c) 2015年 meitu. All rights reserved.
//

#import "SpecialEffectsView.h"
#import "SpecialEffectsCell.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"

@interface SpecialEffectsView ()
{
    UITableView *m_TableView;
    
    NSArray *aryLJ;
    NSMutableDictionary *imageLJDict;
}
@end

@implementation SpecialEffectsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        imageLJDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        UIImage *image0 = [UIImage imageNamed:@"pic_LJIMAGE0"];
        UIImage *image1 = [UIImage imageNamed:@"pic_LJIMAGE1"];
        UIImage *image2 = [UIImage imageNamed:@"pic_LJIMAGE2"];
        UIImage *image3 = [UIImage imageNamed:@"pic_LJIMAGE3"];
        UIImage *image4 = [UIImage imageNamed:@"pic_LJIMAGE4"];
        UIImage *image5 = [UIImage imageNamed:@"pic_LJIMAGE5"];
        UIImage *image6 = [UIImage imageNamed:@"pic_LJIMAGE6"];
        UIImage *image7 = [UIImage imageNamed:@"pic_LJIMAGE7"];
        UIImage *image8 = [UIImage imageNamed:@"pic_LJIMAGE8"];
        UIImage *image9 = [UIImage imageNamed:@"pic_LJIMAGE9"];
        UIImage *image10 = [UIImage imageNamed:@"pic_LJIMAGE10"];
        UIImage *image11 = [UIImage imageNamed:@"pic_LJIMAGE11"];
        UIImage *image12 = [UIImage imageNamed:@"pic_LJIMAGE12"];
        UIImage *image13 = [UIImage imageNamed:@"pic_LJIMAGE13"];
        
        aryLJ = [[NSArray alloc] initWithObjects:image0,image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12,image13, nil];
        
        m_TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.width) style:UITableViewStylePlain];
        m_TableView.delegate = self;
        m_TableView.dataSource = self;
        m_TableView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        m_TableView.showsVerticalScrollIndicator = NO;
        m_TableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        m_TableView.pagingEnabled = NO;
        m_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        m_TableView.backgroundView = nil;
        m_TableView.backgroundColor = [UIColor clearColor];
        [self addSubview:m_TableView];
    }
    return self;
}

#pragma -mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aryLJ.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idty = @"imgshowCell";
    SpecialEffectsCell *cell = [tableView dequeueReusableCellWithIdentifier:idty];
    if (nil == cell) {
        cell = [[SpecialEffectsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idty];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.specialImage.frame = CGRectMake(2, 0, self.frame.size.height-4, self.frame.size.height-4);
    
    cell.specialImage.image = aryLJ[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cell选中的效果
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *index = [NSString stringWithFormat:@"%tu",indexPath.row];
    UIImage *image = [imageLJDict objectForKey:index];
    if(!image){
        image = [self changeImage:(int)indexPath.row image:_photoImage];
        [imageLJDict setObject:image forKey:index];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(specialEffectsLJImage:)]){
        [self.delegate specialEffectsLJImage:image];
    }
    
}

- (void)setPhotoImage:(UIImage *)photoImage {
    
    _photoImage = photoImage;
    [imageLJDict removeAllObjects];
    
}

//滤镜
- (UIImage *)changeImage:(int)index image:(UIImage *)imageTp
{
    UIImage *image;
    switch (index) {
        case 0:
        {
            return imageTp;
        }
            break;
        case 1:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_lomo];
        }
            break;
        case 2:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_heibai];
        }
            break;
        case 3:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_huajiu];
        }
            break;
        case 4:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_gete];
        }
            break;
        case 5:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_ruise];
        }
            break;
        case 6:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_danya];
        }
            break;
        case 7:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 8:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_qingning];
        }
            break;
        case 9:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_langman];
        }
            break;
        case 10:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 11:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_landiao];
            
        }
            break;
        case 12:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_menghuan];
            
        }
            break;
        case 13:
        {
            image = [ImageUtil imageWithImage:imageTp withColorMatrix:colormatrix_yese];
            
        }
    }
    return image;
}

@end
