//
//  RecipeHandler.h
//  HouseHelp
//
//  Created by Breakstuff on 9/29/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeHandler : NSObject
@property (copy) NSMutableDictionary* recipeHolder;
- (id) init;
- (void) addRecipeName: (NSString*) r_name;
- (void) addRecipeDescription: (NSString*) r_description;
- (void) addIngredientName: (NSString*) i_name;
- (void) addIngredientMeasurement: (NSString*) i_measurement;
- (void) addIngredientValue: (NSString*) i_value;
- (NSString*) getRecipeDescription;
- (NSString*) getRecipeName;
- (NSString*) getIngredientName;
- (NSString*) getIngredientMeasurement;
- (NSString*) getIngredientValue;
@end
