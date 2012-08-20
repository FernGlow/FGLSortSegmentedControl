//
//  FGSortSegmentedControl.h
//  FGSortSegmentedControl
//
//  Copyright (c) 2012 Fern Glow, LLC (http://fernglow.com) All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>

@interface FGSortSegmentedControl : UISegmentedControl

/**
 The string to use to signify a descending selection
 */
@property (nonatomic, strong) NSString *descendingString;


/**
 The string to use to signify an ascending selection

 */
@property (nonatomic, strong) NSString *ascendingString;

/**
 @name Initializing a Sortable Segmented Control
 */
 
/**
 Initializes the segmented control with an array of items and the default ascending and descending strings.
 
 @param items An array of NSString*s segment titles
 
 The default ascendingString is unicode 225B2 ▲ and the default descendingString is unicode 25BC ▼
 */
- (id)initWithItems:(NSArray *)items;


/**
 Initializes the segmented control with an array of items and the specified ascending and descending strings.
 
 @param items An array of NSString objects to use as segment titles
 @param ascendingString A string to use to signify an ascending selection
 @param descendingString A string to use to signify an descending selection
 */
- (id)initWithItems:(NSArray *)items ascendingString:(NSString *)ascendingString descendingString:(NSString *)descendingString;

/**
 @name Selected Segment Ordering
 */

/**
 The ordering of the currently selected segment.
 
 @return YES if the current selection is ascending, NO if descending.
 
 Setting this property changes the ordering of the currently selected segment.
 */
@property (nonatomic, assign) BOOL isAscending;

@end
