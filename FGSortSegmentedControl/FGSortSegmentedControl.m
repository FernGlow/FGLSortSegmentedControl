//
//  FGSortSegmentedControl.m
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

#import "FGSortSegmentedControl.h"

static NSString *const kDefaultDescendingArrowString = @" \u25BC";	// ▼
static NSString *const kDefaultAscendingArrowString  = @" \u25B2";	// ▲

@interface FGSortSegmentedControl()
@end

@implementation FGSortSegmentedControl

#pragma mark - Initialization & Lifecycle

- (id)init
{
	return [self initWithItems:@[] ascendingString:kDefaultAscendingArrowString descendingString:kDefaultDescendingArrowString];
}

- (id)initWithItems:(NSArray *)items
{
	return [self initWithItems:items ascendingString:kDefaultAscendingArrowString descendingString:kDefaultDescendingArrowString];
}

- (id)initWithItems:(NSArray *)items ascendingString:(NSString *)ascendingString descendingString:(NSString *)descendingString
{
	self = [super initWithItems:items];
	if (self) {
		for (id item in items) {
			if (![item isKindOfClass:[NSString class]]) {
				NSAssert(false, @"items must only contain NSString objects or objects that inherit from NSString");
			}
		}
		
		_ascendingString = ascendingString;
		_descendingString = descendingString;
		[self sharedInit];
	}
	return self;
}

- (void)awakeFromNib
{
	[self sharedInit];
}

- (void)sharedInit
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentTapped:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
	self.isAscending = NO;
	self.selectedSegmentIndex = 0;
	[self segmentTapped:self];
}

- (void)dealloc
{
    [self removeGestureRecognizer:[[self gestureRecognizers] lastObject]];
}

#pragma mark - Target/Action

- (void)segmentTapped:(id)sender
{
    [self adjustSegmentTitles];
}

#pragma mark - Internal (private)

- (void)setIsAscending:(BOOL)ascending
{
	_isAscending = ascending;
	[self updateSegmentTitles];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

{
    for (NSInteger i = 0; i < [self numberOfSegments]; i++) {
        NSString *title = [self baseTitleForSegmentAtIndex:i];
		
        if (i == [self selectedSegmentIndex])
		{
			if ([self sortStringContainedInSegmentAtIndex:i]) {
				title = [NSString stringWithFormat:@"%@%@", title, (self.isAscending) ? self.descendingString : self.ascendingString];
				self.isAscending = !self.isAscending;
				[self sendActionsForControlEvents:UIControlEventValueChanged];
			} else {
				title = [NSString stringWithFormat:@"%@%@", title, (self.isAscending) ? self.ascendingString : self.descendingString];
			}
		}
        
		[self setTitle:title forSegmentAtIndex:i];
    }
}

- (NSString *)sortString
{
	return (self.isAscending) ? self.ascendingString : self.descendingString;
}

- (NSRange)rangeOfSortStringContainedInSegmentAtIndex:(NSInteger)segmentIndex
{
	NSAssert([self.ascendingString length] > 0, @"ascendingString must not be an empty string.");
	NSAssert([self.descendingString length] > 0, @"descendingString must not be an empty string.");
	NSString *title = [super titleForSegmentAtIndex:segmentIndex];
	
	NSRange ascendingStringRange = [title rangeOfString:self.ascendingString];
	NSRange descendingStringRange = [title rangeOfString:self.descendingString];

	if (ascendingStringRange.location != NSNotFound) {
		return ascendingStringRange;
	} else if (descendingStringRange.location != NSNotFound) {
		return descendingStringRange;
	} else {
		return NSMakeRange(NSNotFound, 0);
	}
}

/**
 Returns the title without the ascending or descending sorting string
 */
- (NSString *)baseTitleForSegmentAtIndex:(NSInteger)segmentIndex
{
	NSMutableString *title = [[super titleForSegmentAtIndex:segmentIndex] mutableCopy];
	NSRange sortStringRange = [self rangeOfSortStringContainedInSegmentAtIndex:segmentIndex];
	
    if (sortStringRange.location != NSNotFound) {
		[title replaceCharactersInRange:sortStringRange withString:@""];
    }
	
    return (NSString *)title;
}
}

#pragma mark - Override (disable)

- (UIImage *)imageForSegmentAtIndex:(NSUInteger)segment
{
	return nil;
}

- (void)insertSegmentWithImage:(UIImage *)image atIndex:(NSUInteger)segment animated:(BOOL)animated
{
	// do nothing
}

- (void)setImage:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment
{
	// do nothing
}

@end
