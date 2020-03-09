//
//  GarageView.h
//  HouseHelp
//
//  Created by Breakstuff on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseHandler.h"
#import "TipsHandler.h"
#import "KitchenView.h"
@interface GarageView : UIView
{
    float x,y,w,h;
    float rx,ry,rw,rh;
    float tabbar_image_width;
    float tabbar_image_height;
    float head_image_width;
    float head_image_height;
    float head_center_x;
    float header_size;
    float title_size;
    float textfield_size;
    BOOL flag;
    UIScrollView* testScrollView;
    UILabel* tipOfTheDayLabel;
    UILabel* tipLabel;
    UILabel* tipDescription;
    UILabel* addRecipeLabel;
    UIImage* backGroundImage;
    UIImage* addIconImage;
    UIImage* glossaryIconImage;
    UIImage* iconImage;
    UIImageView* backGroundImageView;
    UIImageView* addIconImageView;
    UIImageView* glossaryIconImageView;
    UIImageView* iconImageView;
    NSMutableArray* tipArray;
}
@property CGSize tabbarsize;
@end
