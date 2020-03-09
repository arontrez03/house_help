//
//  IngridientsHandler.h
//  HouseHelp
//
//  Created by Breakstuff on 10/4/13.
//  Copyright (c) 2013 FastData. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IngredientsHandler : NSObject
@property (copy) NSString* ingredient_name;
@property (copy) NSString* ingredient_measurement;
@property (copy) NSString* ingredient_value;
- (id)init;
- (void) addIngredientName: (NSString*) i_name;
- (void) addIngredientMeasurement: (NSString*) i_measurement;
- (void) addIngredientValue: (NSString*) i_value;
@end
