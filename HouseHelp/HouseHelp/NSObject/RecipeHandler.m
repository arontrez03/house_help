//
//  RecipeHandler.m
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import "RecipeHandler.h"

@implementation RecipeHandler
- (id) init{
    self = [super init];
    if(self){
        _recipeHolder = [[NSMutableDictionary alloc] init];
    }
    return(self);
}
- (void) addRecipeName: (NSString*) r_name{
    [_recipeHolder setObject:r_name forKey:@"recipe_name"];
}
- (void) addRecipeDescription: (NSString*) r_description{
    [_recipeHolder setObject:r_description forKey:@"recipe_description"];
}

- (void) addIngredientName:(NSString *)i_name{
    [_recipeHolder setObject:i_name forKey:@"ingredient_name"];
}
- (void) addIngredientMeasurement:(NSString *)i_measurement{
    [_recipeHolder setObject:i_measurement forKey:@"ingredient_measurement"];
}
- (void) addIngredientValue:(NSString *)i_value{
    [_recipeHolder setObject:i_value forKey:@"ingredient_value"];
}
- (NSString*) getRecipeName{
    return(_recipeHolder[@"recipe_name"]);
}
- (NSString*) getRecipeDescription{
    return(_recipeHolder[@"recipe_description"]);
}
- (NSString*) getIngredientName{
    return(_recipeHolder[@"ingredient_name"]);
}
- (NSString*) getIngredientMeasurement{
    return(_recipeHolder[@"ingredient_measurement"]);
}
- (NSString*) getIngredientValue{
    return(_recipeHolder[@"ingredient_value"]);
}
@end
