//
//  MyUnits.h
//  AppVantage
//
//  Created by macuser on 10/1/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyUnits : UIView
{
    int myFontSize;
}
@property UILabel* myLabel;
- (id)initWithFrame:(CGRect)frame myText:(NSString*)myStr;
@end

