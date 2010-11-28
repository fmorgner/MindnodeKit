//
//  MNMindmap.h
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FMMindnodeMindmap : NSObject
	{
	NSArray* associations;
	NSArray* rootNodes;
	NSString* color;
	}

- (id) initWithAssociations:(NSArray*)theAssociations rootNodes:(NSArray*)theRootNodes color:(NSString*)aColor;
- (id) initWithDictionary:(NSDictionary*)theDictionary;

+ (id) mindmapWithAssociations:(NSArray*)theAssociations rootNodes:(NSArray*)theRootNodes color:(NSString*)aColor;
+ (id) mindmapWithDictionary:(NSDictionary*)theDictionary;


@property(nonatomic, retain) NSArray* associations;
@property(nonatomic, retain) NSArray* rootNodes;
@property(nonatomic, retain) NSString* color;

@end
