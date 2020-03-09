//
//  KitchenViewController.h
//  HouseHelp
//
//  Created by Breakstuff on 9/22/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KitchenView.h"
#import "KitchenBuddyViewController.h"
#import "AddRecipeViewController.h"
@interface KitchenViewController : UIViewController <KitchenViewDelegate>
{
    UITabBarItem* uitbi;
}
- (id)init;
- (void)loadView;
@end
