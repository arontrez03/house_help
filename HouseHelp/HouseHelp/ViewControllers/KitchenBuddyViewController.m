//
//  KitchenTipsViewController.m
//  HouseHelp
//
//  Created by Breakstuff on 9/24/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "KitchenBuddyViewController.h"

@implementation KitchenBuddyViewController
- (id)init{
    self = [super init];
    if(self){
        UITabBarItem* uitbi = [[UITabBarItem alloc]initWithTitle:@"Buddy" image:[UIImage imageNamed:@"48-fork-and-knife.png"] tag:0];
        [self setTabBarItem:uitbi];
    }
    return(self);
}
- (void)loadView{
    KitchenBuddyView* ktv = [[KitchenBuddyView alloc] init];
    [self prefersStatusBarHidden];
    CGSize tabBarSize = [[[self tabBarController]tabBar] bounds].size;
    [ktv setTabbarsize:tabBarSize];
    ktv.delegate = self;
    self.view = ktv;

}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didTouchRecipe:(NSString*) recipeName{
    RecipeViewController* rvc = [[RecipeViewController alloc]initWithRecipeName:recipeName];
    [self presentViewController:rvc animated:YES completion:nil];
}
@end
