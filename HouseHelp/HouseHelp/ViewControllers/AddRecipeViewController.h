//
//  AddRecipeViewController.h
//  HouseHelp
//
//  Created by Breakstuff on 10/3/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRecipeView.h"
#import "AddRecipeViewControllerDelegate.h"
@interface AddRecipeViewController : UIViewController <AddRecipeViewDelegate>
{

}
@property id<AddRecipeViewControllerDelegate> delegate;
@end
