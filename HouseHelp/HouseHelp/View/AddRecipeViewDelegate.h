//
//  AddRecipeViewDelegate.h
//  HouseHelp
//
//  Created by Breakstuff on 10/3/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddRecipeViewDelegate <NSObject>
- (void)didTouchGoBack;
- (void)didTouchInsertRecipe: (NSString*) recipeName;
@end
