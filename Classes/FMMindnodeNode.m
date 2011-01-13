//
//  MNNode.m
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import "FMMindnodeNode.h"


@implementation FMMindnodeNode

@synthesize subnodes, location, nodeID, fillColor, strokeColor, title, strokeStyle, strokeWidth,
						contentAlignment, isDecreasingBranchThickness, isDrawingFill, isDrawingInverse;

- (id) init
	{
	if (self = [super init])
		{
		self.subnodes = nil;
		
		self.location = NSMakePoint(0, 0);
		self.nodeID = nil;
		self.fillColor = nil;
		self.strokeColor = nil;
		
		self.title = nil;
		
		self.strokeStyle = 0;
		self.strokeWidth = 0;
		self.contentAlignment = 0;
		
		self.isDecreasingBranchThickness = NO;
		self.isDrawingFill = NO;
		self.isDrawingInverse = NO;
		}
		
	return self;
	}

- (id) initWithDictionary:(NSDictionary*)theDictionary
	{
	if (self = [super init])
		{
		
		if([[theDictionary valueForKey:@"subnodes"] count])
			{
			NSMutableArray* tempSubnodes = [NSMutableArray arrayWithCapacity:[[theDictionary valueForKey:@"subnodes"] count]];
		
			for(NSDictionary* nodeDictionary in [theDictionary valueForKey:@"subnodes"])
				{
				FMMindnodeNode* node = [FMMindnodeNode nodeWithDictionary:nodeDictionary];
				[tempSubnodes addObject:node];
				}
			[self setSubnodes:[tempSubnodes copy]];
			}
		else
			{
			[self setSubnodes:nil];
			}
		[self setLocation:NSPointFromString([theDictionary valueForKey:@"location"])];
		[self setNodeID:[theDictionary valueForKey:@"nodeID"]];
		[self setFillColor:[theDictionary valueForKey:@"fillColor"]];
		[self setStrokeColor:[theDictionary valueForKey:@"strokeColor"]];
		
		[self setTitle:[FMMindnodeTitle titleWithDictionary:[theDictionary valueForKey:@"title"]]];
		
		[self setStrokeStyle:[[theDictionary valueForKey:@"strokeStyle"] intValue]];
		[self setStrokeWidth:[[theDictionary valueForKey:@"strokeWidth"] intValue]];
		[self setContentAlignment:[[theDictionary valueForKey:@"contentAlignment"] intValue]];
		
		[self setIsDecreasingBranchThickness:[[theDictionary valueForKey:@"isDecreasingBranchThickness"] boolValue]];
		[self setIsDrawingFill:[[theDictionary valueForKey:@"isDrawingFill"] boolValue]];
		[self setIsDrawingInverse:[[theDictionary valueForKey:@"isDrawingInverse"] boolValue]];
		
		
		}
		
	return self;
	}

+ (id) nodeWithDictionary:(NSDictionary*)theDictionary
	{
	return [[[FMMindnodeNode alloc] initWithDictionary:theDictionary] autorelease];
	}

@end
