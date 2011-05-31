//
//  NewKeyNavigationView.m
//  RSA
//
//  Created by Marcel Boersma on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewKeyNavigationView.h"
#import "NewKeyView.h"

@implementation NewKeyNavigationView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NewKeyView *newKeyView = [[NewKeyView alloc] initWithNibName:@"NewKeyView" bundle:nil];
    
    [self setViewControllers:[NSArray arrayWithObject:newKeyView]];
    
    [newKeyView release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
