//
//  AppDelegate.m
//  2
//
//  Created by Pavel Aksenkin on 18.03.13.
//  Copyright (c) 2013 Pavel Aksenkin. All rights reserved.
//

#import "AppDelegate.h"
#import "GrammarController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
-(void)awakeFromNib
{
    [_logView setEditable:NO];
    [_logView setSelectable:YES];
}

-(IBAction)solve:(id)sender
{
    Grammar *grammar = [[Grammar alloc] initWithStrings:_grController.strings];
    [grammar removeUnreachable];
    
    [_logView setString:grammar.description];
}

@end
