//
//  DecryptViewController.m
//  RSA
//
//  Created by Marcel Boersma(1) on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DecryptViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DecryptViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    encryptedText.layer.cornerRadius = 10;
    encryptedText.layer.borderColor = [[UIColor blackColor] CGColor];
    encryptedText.layer.borderWidth = 1.0;
    
    decryptedText.layer.cornerRadius = 10;
    decryptedText.layer.borderColor = [[UIColor blackColor] CGColor];
    decryptedText.layer.borderWidth = 1.0;
    
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
