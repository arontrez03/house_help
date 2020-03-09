//
//  AddRecipeView.h
//  HouseHelp
//
//  Created by Breakstuff on 10/3/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRecipeViewDelegate.h"
#import "KitchenView.h"
#import "IngredientsHandler.h"
#import "AddRecipesScrollView.h"
#import "DatabaseHandler.h"
#define TVIEW_SIZE .15
@interface AddRecipeView : UIView <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextViewDelegate>
{
    float head_image_width;
    float head_image_height;
    float head_center_x;
    float tabbar_image_width;
    float tabbar_image_height;
    float header_size;
    float normal_size;
    float kbsizeheight;
    BOOL flag;
    UIAlertView* alertIngredients;
    UIAlertView* alertProcedures;
    UIAlertView* alertInsertRecipes;
    UILabel* addRecipeLabel;
    UILabel* addRecipeNameLabel;
    UILabel* addRecipeDescriptionLabel;
    UILabel* addIngredientsLabel;
    UILabel* addIngredientName;
    UILabel* addIngredientMeasurement;
    UILabel* addIngredientValue;
    UILabel* addProcedureLabel;
    UILabel* addProcedureValue;
    UITextField* addRecipeNameTextField;
    UITextField* addRecipeDescriptionTextField;
    UITextField* addIngredientNameTextField;
    UITextField* addIngredientMeasurementTextField;
    UITextField* addIngredientValueTextField;
    UITextView* addProcedureTextView;
    UIImage* previousImage;
    UIImage* acceptImage;
    UIImage* addIconImage;
    UIImage* addIngredientsImage;
    UIImage* addProcedureImage;
    UIImageView* acceptImageView;
    UIImageView* previousImageView;
    UIImageView* addIconImageView;
    UIImageView* addIngredientsImageView;
    UIImageView* addProcedureImageView;
    UITableView* ingredientsTableView;
    UITableView* proceduresTableView;
    NSMutableArray* ingredientsArray;
    NSMutableArray* proceduresArray;
    AddRecipesScrollView* addRecipeScrollView;
}
@property id<AddRecipeViewDelegate> delegate;
@end
