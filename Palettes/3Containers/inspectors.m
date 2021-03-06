/* inspectors - Various inspectors for control elements

   Copyright (C) 2001 Free Software Foundation, Inc.

   Author:  Laurent Julliard <laurent@julliard-online.org>
   Author:  Gregory John Casamento <greg_casamento@yahoo.com>
   Date: Aug 2001. 2003, 2004
   
   This file is part of GNUstep.
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02111 USA.
*/

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include <InterfaceBuilder/InterfaceBuilder.h>

/**
 * IBObjectAdditions categories. 
 */

@implementation	NSBrowser (IBObjectAdditions)
- (NSString*) inspectorClassName
{
  return @"GormBrowserAttributesInspector";
}
@end

@implementation	NSTabView (IBObjectAdditions)

- (NSString*) inspectorClassName
{
  return @"GormTabViewAttributesInspector";
}

- (NSString*) editorClassName
{
  return @"GormTabViewEditor";
}

@end

@implementation NSTableColumn (IBObjectAdditions)
- (NSString *) inspectorClassName
{
  return @"GormTableColumnAttributesInspector";
}
@end

@implementation	NSTableView (IBObjectAdditions)
- (NSString*) inspectorClassName
{
  return @"GormTableViewAttributesInspector";
}

- (NSString*) sizeInspectorClassName
{
  return @"GormTableViewSizeInspector";
}

- (NSString*) editorClassName
{
  return @"GormTableViewEditor";
}
@end
