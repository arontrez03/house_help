//
//  DistinctRecipesHandler.h
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistinctRecipesHandler : NSObject
@property (copy) NSString* recipes;
@property (copy) NSString* recipe_description;
- (id)init;
- (void)addRecipes: (NSString*)recipe;
- (void)addRecipeDescription: (NSString*)recipe_desc;
@end
