//
//  FGLSortSegmentedControl.m
//  FGLSortSegmentedControl
//
//  Copyright (c) 2013 Fern Glow, LLC (http://fernglow.com) All rights reserved.
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

#import "FGLSortSegmentedControl.h"

static NSString *const kDefaultDescendingArrowString = @" \u25BC";	// ▼
static NSString *const kDefaultAscendingArrowString  = @" \u25B2";	// ▲

@interface FGLSortSegmentedControl()
@property (nonatomic, assign) NSInteger previousSelectedSegmentIndex;
@end

@implementation FGLSortSegmentedControl

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
	self.ascendingString = kDefaultAscendingArrowString;
	self.descendingString = kDefaultDescendingArrowString;
	[self sharedInit];
}

- (void)sharedInit
{
	self.ascending = NO;
	self.previousSelectedSegmentIndex = NSNotFound;
	self.selectedSegmentIndex = 0;
	[self segmentTapped:nil];
	[self addTarget:self action:@selector(segmentTapped:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Target/Action

- (void)segmentTapped:(id)sender
{
	if (sender != nil && self.previousSelectedSegmentIndex == self.selectedSegmentIndex) {
		_ascending = !self.isAscending;
	}
	
	[self updateSegmentTitles];
	self.previousSelectedSegmentIndex = self.selectedSegmentIndex;
}

#pragma mark - Internal (private)

- (void)setAscending:(BOOL)ascending
{
	_ascending = ascending;
	[self updateSegmentTitles];
	[self segmentTapped:nil];
}

- (void)updateSegmentTitles
{
    for (NSInteger i = 0; i < [self numberOfSegments]; i++) {
		[self setTitle:[self sortTitleForSegmentAtIndex:i] forSegmentAtIndex:i];
    }
}

- (NSString *)sortTitleForSegmentAtIndex:(NSUInteger)segment
{
	NSString *title = [self baseTitleForSegmentAtIndex:segment];
	if (segment == [self selectedSegmentIndex]) {
		title = [NSString stringWithFormat:@"%@%@", title, (self.isAscending) ? self.ascendingString : self.descendingString];
	}
	return title;
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

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
	[super setSelectedSegmentIndex:selectedSegmentIndex];
	[self segmentTapped:self];
}

#pragma mark - Override

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSInteger previousIndex = self.selectedSegmentIndex;
    [super touchesEnded:touches withEvent:event];
    if (previousIndex == self.selectedSegmentIndex) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
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
