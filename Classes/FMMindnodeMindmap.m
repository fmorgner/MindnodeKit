//
//  MNMindmap.m
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import "FMMindnodeMindmap.h"
#import "FMMindnodeNode.h"

@implementation FMMindnodeMindmap

@synthesize associations, rootNodes, color;

- (id) init
	{
	if(self = [super init])
		{
		self.associations = nil;
		self.rootNodes = nil;
		self.color = nil;
		}
	return self;
	}

- (id) initWithAssociations:(NSArray*)theAssociations rootNodes:(NSArray*)theRootNodes color:(NSString*)aColor
	{
	if(self = [super init])
		{
		[self setAssociations:theAssociations];
		[self setRootNodes:theRootNodes];
		[self setColor:aColor];
		}
	return self;
	}
	
- (id) initWithDictionary:(NSDictionary*)theDictionary
	{
	if(self = [super init])
		{
		[self setAssociations:nil]; // NOT IMPLEMENTED YET!
		[self setRootNodes:[NSArray arrayWithObject:[FMMindnodeNode nodeWithDictionary:[[theDictionary objectForKey:@"mainNodes"] objectAtIndex:0]]]];
		[self setColor:[theDictionary objectForKey:@"color"]];
		}
	return self;
	
	}
	
+ (id) mindmapWithDictionary:(NSDictionary*)theDictionary
	{
	return [[[FMMindnodeMindmap alloc] initWithDictionary:theDictionary] autorelease];
	}

+ (id) mindmapWithAssociations:(NSArray*)theAssociations rootNodes:(NSArray*)theRootNodes color:(NSString*)aColor
	{
	return [[[FMMindnodeMindmap alloc] initWithAssociations:theAssociations rootNodes:theRootNodes color:aColor] autorelease];
	}

- (void) dealloc
	{
	[self.associations release];
	[self.rootNodes release];
	[self.color release];
	[super dealloc];
	}
	
@end
