//
//  AddRecipeViewControllerDelegate.h
//  HouseHelp
//
//  Created by Breakstuff on 10/7/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddRecipeViewControllerDelegate <NSObject>
- (void)trigSuccess:(NSString*) recipeName;
@end
