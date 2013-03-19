//
//  GrammarController.m
//  СС1
//
//  Created by Pavel Aksenkin on 24.02.13.
//  Copyright (c) 2013 Pavel Aksenkin. All rights reserved.
//

#import "GrammarController.h"
#import "Grammar.h"

@implementation GrammarController

-(id)init
{
    self = [super init];
    if (self) {
        _rules = [[NSMutableArray alloc] init];
        
            // For test purposes
        [self set2:nil];
    }
    return self;
}

-(NSArray *)strings
{
    return [NSArray arrayWithArray:_rules];
}

-(IBAction)set1:(id)sender
{
    [_rules removeAllObjects];
    [_rules addObject:[NSString stringWithFormat:@"S->%@", kEmptyString]];
    [_rules addObject:@"S->A+A"];
    [_rules addObject:@"S->A-A"];
    [_rules addObject:@"A->B*B"];
    [_rules addObject:@"A->B"];
    [_rules addObject:@"B->a"];
    [_rules addObject:@"B->b"];
    [_rules addObject:@"C->с"];
    [_table reloadData];
}
-(IBAction)set2:(id)sender
{
    [_rules removeAllObjects];
    [_rules addObject:@"S->Aa"];
    [_rules addObject:@"A->Bb"];
    [_rules addObject:@"B->Sc"];
    [_rules addObject:[NSString stringWithFormat:@"A->%@", kEmptyString]];
    [_table reloadData];
}
-(IBAction)set3:(id)sender
{
    [_rules removeAllObjects];
    [_rules addObject:@"S->Aa"];
    [_rules addObject:@"S->Sb"];
    [_rules addObject:@"S->Ab"];
    [_rules addObject:@"A->Ba"];
    [_rules addObject:@"A->Ab"];
    [_rules addObject:[NSString stringWithFormat:@"A->%@", kEmptyString]];
    [_rules addObject:@"B->Sa"];
    [_rules addObject:@"B->Bb"];
    [_table reloadData];
}

#pragma mark TableView
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 20;
}
-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return _rules[row];
}
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _rules.count;
}

#pragma mark TextField
-(void)controlTextDidChange:(NSNotification *)obj
{
    NSString *oldString = [_newRuleField stringValue];
    NSString *newString = [oldString stringByReplacingOccurrencesOfString:@"~" withString:kEmptyString];
    [_newRuleField setStringValue:newString];
}

#pragma mark Actions
-(void)addRule:(id)sender
{
    NSString *rule = [_newRuleField stringValue];
    if (rule.length == 0) return;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kKSRulePattern];
    if ([pred evaluateWithObject:rule]) {
        [_rules addObject:rule];
        [_table reloadData];
        [_newRuleField setStringValue:@""];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Не КС-правило"];
        [alert runModal];
    }
}
-(void)removeRule:(id)sender
{
    NSInteger index = [_table selectedRow];
    if (index != -1) {
        [_rules removeObjectAtIndex:index];
        [_table reloadData];
    }
}
-(void)clear:(id)sender
{
    [_rules removeAllObjects];
    [_newRuleField setStringValue:@""];
    [_table reloadData];
}


@end
