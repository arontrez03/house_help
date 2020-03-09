//
//  KitchenBuddyView.h
//  HouseHelp
//
//  Created by Breakstuff on 9/24/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenView.h"
#import "KitchenBuddyViewDelegate.h"
#import "DatabaseHandler.h"
#import "RecipeHandler.h"
#import "DistinctRecipesHandler.h"
#import "RecipeViewController.h"


@interface KitchenBuddyView : UIView <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    float head_image_width;
    float head_image_height;
    float head_center_x;
    float tabbar_image_width;
    float tabbar_image_height;
    float header_size;
    float textfield_size;
    BOOL ret_val;
    UIImage* kitchenTipsImage;
    UIImageView* kitchenTipsImageView;
    UILabel* whatToCookLabel;
    UITextField* searchIngredientsTextField;
    UITableView* recipeTableView;
    NSMutableArray* recipeProceduresArray;
    NSMutableArray* recipesArray;
}
- (void)animateHeader;
@property CGSize tabbarsize;
@property id<KitchenBuddyViewDelegate> delegate;
@property (weak) UINavigationController* nvc;
@end
