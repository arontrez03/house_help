//
//  MeasurementConverter.h
//  AppVantage
//
//  Created by macuser on 9/30/13.
//  Copyright (c) 2013 SPD Insights. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeasurementConverterHeader.h"
#import "MyUnits.h"
#import "Icons.h"
@interface MeasurementConverter : UIView
{
    int parentHeight;
    int parentWidth;
    float percentHeader;
    float percentFooter;
    float percentBody;
    float percentUnits;
    float fontSize;
    
    MeasurementConverterHeader* header;
    UIView* units;
    UIView* body;
    UIView* footer;
    
    Icons* liquid;
    Icons* solid;
    Icons* temperature;
    Icons* weight;
    
    //UNITS
    float unitsHeight;
    float unitsWidth;
    float customUnitsHeight;
    float customUnitsWidth;
    float unitsXMargin;
    float unitsYMargin;
    float H;
    float W;
}


@end
