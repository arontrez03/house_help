//
//  MeasurementConverterHeader.h
//  AppVantage
//
//  Created by macuser on 10/1/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasurementConverterHeader : UIView
{
    int myFontSize;
    UILabel* myLabel;

}

- (id)initWithFrame:(CGRect)frame myText:(NSString*)myStr;
@end
