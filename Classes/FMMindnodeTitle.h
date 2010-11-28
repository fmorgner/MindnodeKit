//
//  MNTitle.h
//  FMMindnodeKit
//
//  Created by Felix Morgner on 26.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FMMindnodeTitle : NSObject
	{
	NSInteger constrainedWidth;
	NSInteger shrinkToFitContent;

	NSAttributedString* text;
	}

- (id) initWithDictionary:(NSDictionary*)theDictionary;

+ (id) titleWithDictionary:(NSDictionary*)theDictionary;

- (NSString*)stringValue;

@property(nonatomic, assign) NSInteger constrainedWidth;
@property(nonatomic, assign) NSInteger shrinkToFitContent;

@property(nonatomic, retain) NSAttributedString* text;


@end
