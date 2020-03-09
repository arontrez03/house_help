//
//  RecipesView.h
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipesViewDelegate.h"
#import "KitchenView.h"
#import "DatabaseHandler.h"
#import "RecipeHandler.h"
#import "ProceduresHandler.h"
#define SCROLLVIEWSPACE 20
@interface RecipesView : UIView
{
    float scroll_view_size;
    float scroll_view_size_proc;
    float head_image_width;
    float head_image_height;
    float head_center_x;
    float tabbar_image_width;
    float tabbar_image_height;
    NSString* rname;
    UIImage* previousImage;
    UIImageView* previousImageView;
    UILabel* recipeLabel;
    UILabel* ingredientsLabel;
    UILabel* proceduresLabel;
    UIScrollView* ingredientsProcedureScrollView;
    NSMutableArray* recipeIngredientArray;
    NSMutableArray* recipeProceduresArray;
}
@property id<RecipesViewDelegate> delegate;
- (id)initWithRecipe:(NSString*) recipeName;
- (void)enableViewsInteraction;
@end
