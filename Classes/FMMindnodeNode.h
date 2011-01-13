//
//  MNNode.h
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FMMindnodeTitle.h"

@interface FMMindnodeNode : NSObject
	{
	NSArray* subnodes;

	NSString* nodeID;
	NSString* fillColor;
	NSString* strokeColor;
	
	FMMindnodeTitle* title;

	NSPoint location;
	
	NSInteger strokeStyle;
	NSInteger strokeWidth;
	NSInteger contentAlignment;
	
	BOOL isDecreasingBranchThickness;
	BOOL isDrawingFill;
	BOOL isDrawingInverse;
	}

- (id) initWithDictionary:(NSDictionary*)theDictionary version:(NSInteger)theVersion;

+ (id) nodeWithDictionary:(NSDictionary*)theDictionary version:(NSInteger)theVersion;


@property(nonatomic, retain) NSArray* subnodes;
	
@property(nonatomic, retain) NSString* nodeID;
@property(nonatomic, retain) NSString* fillColor;
@property(nonatomic, retain) NSString* strokeColor;

@property(nonatomic, retain) FMMindnodeTitle* title;

@property(nonatomic, assign) NSPoint location;

@property(nonatomic, assign) NSInteger strokeStyle;
@property(nonatomic, assign) NSInteger strokeWidth;
@property(nonatomic, assign) NSInteger contentAlignment;

@property(nonatomic, assign) BOOL isDecreasingBranchThickness;
@property(nonatomic, assign) BOOL isDrawingFill;
@property(nonatomic, assign) BOOL isDrawingInverse;


@end
