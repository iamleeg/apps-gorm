/* GormImageEditor.m
 *
 * Copyright (C) 2002 Free Software Foundation, Inc.
 *
 * Author:	Gregory John Casamento <greg_casamento@yahoo.com>
 * Date:	2002
 * 
 * This file is part of GNUstep.
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <AppKit/NSImage.h>
#include "GormImage.h"

// implementation of category on NSImage.
@implementation NSImage (GormNSImageAddition)
- (void) setArchiveByName: (BOOL) archiveByName
{
  _flags.archiveByName = archiveByName;
}

- (BOOL) archiveByName
{
  return _flags.archiveByName;
}
@end

// image proxy object...
@implementation GormImage
+ (GormImage*)imageForPath: (NSString *)aPath
{  
  return [GormImage imageForPath: aPath inWrapper: NO];
}

+ (GormImage*)imageForPath: (NSString *)aPath inWrapper: (BOOL)flag
{  
  return AUTORELEASE([[GormImage alloc] initWithPath: aPath inWrapper: flag]);
}

- (id) initWithName: (NSString *)aName
	       path: (NSString *)aPath
	  inWrapper: (BOOL)flag
{
  if((self = [super initWithName: aName path: aPath inWrapper: flag]) != nil)
    {
      NSSize originalSize;
      float ratioH;
      float ratioW;

      image = RETAIN([[NSImage alloc] initByReferencingFile: aPath]);
      smallImage = RETAIN([[NSImage alloc] initWithContentsOfFile: aPath]);
      [image setName: aName];
      
      if (smallImage == nil)
	{
	  RELEASE(self);
	  return nil;
	}
      
      originalSize = [smallImage size];
      ratioW = originalSize.width / 70;
      ratioH = originalSize.height / 55;
      
      if (ratioH > 1 || ratioW > 1)
	{
	  [smallImage setScalesWhenResized: YES];
	  if (ratioH > ratioW)
	    {
	      [smallImage setSize: NSMakeSize(originalSize.width / ratioH, 55)];
	    }
	  else 
	    {
	      [smallImage setSize: NSMakeSize(70, originalSize.height / ratioW)];
	    }
	}

      [image setArchiveByName: NO];
      [smallImage setArchiveByName: NO];
    }
  else
    {
      RELEASE(self);
    }

  return self;
}

- (void) dealloc
{
  RELEASE(image);
  RELEASE(smallImage);
  [super dealloc];
}

- (NSImage *) normalImage
{
  return image;
}

- (NSImage *) image
{
  return smallImage;
}

- (void) setSystemResource: (BOOL)flag
{
  [super setSystemResource: flag];
  [image setArchiveByName: flag];
  [smallImage setArchiveByName: flag];
}

- (NSString *)inspectorClassName
{
  return @"GormImageInspector"; 
}

- (NSString *) classInspectorClassName
{
  return @"GormNotApplicableInspector";
}

- (NSString *) connectInspectorClassName
{
  return @"GormNotApplicableInspector";
}

- (NSImage *) imageForViewer
{
  return [self image];
}
@end
