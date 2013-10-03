//
//  YTBasicCanvas.m
//  ProCoreData1
//
//  Created by Aleksey on 03.10.13.
//  Copyright (c) 2013 yalantis. All rights reserved.
//

#import "YTBasicCanvas.h"
#import <CoreData/CoreData.h>

@interface YTBasicCanvas ()

@property (nonatomic, strong) NSManagedObject *canvas;
@property (nonatomic) float scale;

@end

@implementation YTBasicCanvas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(float)scale {
    NSManagedObject *transform = [self.canvas valueForKey:@"transform"];
    return [[transform valueForKey:@"scale"] floatValue];
}


- (void)drawRect:(CGRect)rect {
    if (!self.canvas) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    float scale = self.scale;
    
    CGContextScaleCTM(context, scale, scale);
    
    NSSet *shapes = [self.canvas valueForKey:@"shapes"];
    for (NSManagedObject *shape in shapes) {
        NSString *entityName = [[shape entity] name];
        NSString *colorCode = [shape valueForKey:@"color"];
        NSArray *colorCodes = [colorCode componentsSeparatedByString:@","];
        CGContextSetRGBFillColor(context, [[colorCodes objectAtIndex:0]floatValue] / 255,[[colorCodes objectAtIndex:1]floatValue] / 255,
                                 [[colorCodes objectAtIndex:2]floatValue] / 255, 1.f);
        
        
        if ([entityName compare:@"YTCircle"] == NSOrderedSame) {
            float x = [[shape valueForKey:@"x"]floatValue];
            float y = [[shape valueForKey:@"y"]floatValue];
            float radius = [[shape valueForKey:@"radius"]floatValue];
            CGContextFillEllipseInRect(context, CGRectMake(x - radius, y - radius, 2*radius, 2*radius));
        } else if ([entityName compare:@"Polygon"] == NSOrderedSame) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"index" ascending:YES];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
            NSArray *vertices = [[[shape mutableSetValueForKey:@"vertices"]allObjects] sortedArrayUsingDescriptors:sortDescriptors];
            
            CGContextBeginPath(context);
            
            NSManagedObject *lastVertex = [vertices lastObject];
            CGContextMoveToPoint(context,
                                 [[lastVertex valueForKey:@"x"]floatValue],
                                 [[lastVertex valueForKey:@"y"]floatValue]);
            
            for (NSManagedObject *vertex in vertices) {
                CGContextAddLineToPoint(context, [[vertex valueForKey:@"x"]floatValue], [[vertex valueForKey:@"y"]floatValue]);
            }
            CGContextFillPath(context);
        }
    }
}

@end
