//
//  DistinctRecipesHandler.m
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "DistinctRecipesHandler.h"

@implementation DistinctRecipesHandler
- (id)init{
    self = [super init];
    if(self){
        _recipes = [[NSString alloc] init];
        _recipe_description = [[NSString alloc] init];
    }
    return(self);
}
- (void)addRecipes: (NSString*)recipe{
    _recipes = recipe;
}
- (void)addRecipeDescription: (NSString*)recipe_desc{
    _recipe_description = recipe_desc;
}
@end
