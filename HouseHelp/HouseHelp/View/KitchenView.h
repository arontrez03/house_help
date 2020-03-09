//
//  KitchenView.h
//  HouseHelp
//
//  Created by Breakstuff on 9/22/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenViewDelegate.h"
#import "DatabaseHandler.h"
#import "DistinctRecipesHandler.h"
#import "AddRecipeViewController.h"
#define TBICON_HEIGHT .085
#define TBICON_WIDTH .125
#define HDICON_HEIGHT .070
#define HDICON_WIDTH .085
#define SPACE_X 10
#define SPACE_Y 10
#define LABEL_HEADER .07
#define LABEL_TITLE .047
#define LABEL_TEXTFIELD .035
#define TABLE_VIEW_SPACER 12
#define SPLASH_HEIGHT .35
#define SPLASH_WIDTH .45
@interface KitchenView : UIView
{
    UIAlertView* alertSuccess;
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
    UILabel* recipeOfTheDayLabel;
    UILabel* recipeLabel;
    UILabel* recipeDescription;
    UILabel* addRecipeLabel;
    UIImage* backGroundImage;
    UIImage* addIconImage;
    UIImage* glossaryIconImage;
    UIImage* iconImage;
    UIImageView* backGroundImageView;
    UIImageView* addIconImageView;
    UIImageView* glossaryIconImageView;
    UIImageView* iconImageView;
    NSMutableArray* recipeArray;
    NSMutableArray* recipeIngredientArray;
    NSMutableArray* recipeProceduresArray;
}
@property CGSize tabbarsize;
@property id <KitchenViewDelegate> delegate;
- (void)layoutSubviews;
- (void)drawScrollView;
@end
