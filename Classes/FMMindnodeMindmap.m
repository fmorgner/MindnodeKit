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
	if((self = [super init]))
		{
		self.associations = nil;
		self.rootNodes = nil;
		self.color = nil;
		}
	return self;
	}

- (id) initWithDictionary:(NSDictionary*)theDictionary version:(NSInteger)theVersion
	{
	if((self = [super init]))
		{
		
		switch(theVersion)
			{
			case 3:
				[self setRootNodes:[NSArray arrayWithObject:[FMMindnodeNode nodeWithDictionary:[[theDictionary objectForKey:@"rootNodes"] objectAtIndex:0] version:theVersion]]];
				break;
			case 4:
				[self setRootNodes:[NSArray arrayWithObject:[FMMindnodeNode nodeWithDictionary:[[theDictionary objectForKey:@"mainNodes"] objectAtIndex:0] version:theVersion]]];
				break;
			default:
				break;
			}
			
		[self setAssociations:nil]; // NOT IMPLEMENTED YET!
		[self setColor:[theDictionary objectForKey:@"color"]];
		}
	return self;
	
	}
	
+ (id) mindmapWithDictionary:(NSDictionary*)theDictionary version:(NSInteger)theVersion
	{
	return [[[FMMindnodeMindmap alloc] initWithDictionary:theDictionary] autorelease];
	}

- (void) dealloc
	{
	[self.associations release];
	[self.rootNodes release];
	[self.color release];
	[super dealloc];
	}
	
@end
