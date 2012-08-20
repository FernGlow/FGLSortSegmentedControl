//
//  RootViewController.m
//  FGSortSegmentedControlExample
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

#import "RootViewController.h"
#import "FGSortSegmentedControl.h"

@implementation RootViewController

@synthesize segmentedControl;

#pragma mark -
#pragma mark View lifecycle
 
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Create a sort segmented control
	self.segmentedControl = [[FGSortSegmentedControl alloc] initWithItems:@[@"Name",@"Date",@"Size"]];
	self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;

	// Add the segmented control to the navigation controller's titleView
	self.navigationItem.titleView = self.segmentedControl;
	
	// Add an a target and action to the segmented control for the value changed control event.
	[self.segmentedControl addTarget:self action:@selector(updateSortingInformation:) forControlEvents:UIControlEventValueChanged];	
}

- (void)updateSortingInformation:(id)sender
{
	NSLog(@"Index %d (%@)", [sender selectedSegmentIndex], [sender isAscending] ? @"Ascending" : @"Descending");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	self.segmentedControl = nil;
}

@end

