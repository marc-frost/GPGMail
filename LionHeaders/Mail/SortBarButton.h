/*
 *     Generated by class-dump 3.3.3 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2010 by Steve Nygard.
 */

#import "NSButton.h"

@class NSMenu;

@interface SortBarButton : NSButton
{
}

- (id)initWithControlSize:(unsigned long long)arg1;
- (void)mouseDown:(id)arg1;
- (void)setShowsSortDirection:(BOOL)arg1;
@property(retain, nonatomic) NSMenu *popUpMenu;
- (void)showPopUpMenu;

@end
