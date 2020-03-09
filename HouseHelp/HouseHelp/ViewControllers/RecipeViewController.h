//
//  RecipeViewController.h
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipesView.h"

@interface RecipeViewController : UIViewController <RecipesViewDelegate>
@property (copy) NSString* r_name;
- (id)initWithRecipeName: (NSString*) recipe_name;
@end
