/* GormWindowTemplate
 *
 * Copyright (C) 2009 Free Software Foundation, Inc.
 *
 * Author:      Gregory John Casamento <greg_casamento@yahoo.com>
 * Date:        2009
 *
 * This file is part of GNUstep.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02111 USA.
 */

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include <GNUstepGUI/GSNibLoading.h>

@interface NSWindowTemplate (Private)
- (void) setBaseWindowClass: (Class) clz;
@end 

@interface GormWindowTemplate : NSWindowTemplate
{
  BOOL _tempFlag;
}
@end


