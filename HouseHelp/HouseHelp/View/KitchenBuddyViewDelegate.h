//
//  KitchenBuddyViewDelegate.h
//  HouseHelp
//
//  Created by Breakstuff on 9/25/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KitchenBuddyViewDelegate <NSObject>
- (void)didTouchRecipe:(NSString*) recipeName;
@end
