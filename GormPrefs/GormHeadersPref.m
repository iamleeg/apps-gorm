#include "GormHeadersPref.h"

#include <Foundation/NSUserDefaults.h>

#include <AppKit/NSButton.h>
#include <AppKit/NSTableView.h>
#include <AppKit/NSWindow.h>
#include <AppKit/NSNibLoading.h>
#include <AppKit/NSOpenPanel.h>
#include <AppKit/NSStringDrawing.h>

// data source...
@interface HeaderDataSource : NSObject
@end

@implementation HeaderDataSource
- (int) numberOfRowsInTableView: (NSTableView *)tv
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *list = [defaults objectForKey: @"HeaderList"];
  return [list count];
}

- (id)          tableView: (NSTableView *)tv
objectValueForTableColumn: (NSTableColumn *)tc
	              row: (int)rowIndex
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *list = [defaults objectForKey: @"HeaderList"];
  id value = nil; // NSFontAttributeName
  if([list count] > 0)
    {
      value = [[list objectAtIndex: rowIndex] lastPathComponent];
    }
  return value;
}
@end


@implementation GormHeadersPref
- (id) init
{
  _view = nil;

  self = [super init];
  
  if ( ! [NSBundle loadNibNamed:@"GormPrefHeaders" owner:self] )
    {
      NSLog(@"Can not load bundle GormPrefHeaders");
      return nil;
    }
  
  _view =  [[window contentView] retain];
  return self;
}

- (void) dealloc
{
  TEST_RELEASE(_view);
  [super dealloc];
}


-(NSView *) view
{
  return _view;
}

- (void) addAction: (id)sender
{
  NSArray	*fileTypes = [NSArray arrayWithObjects: @"h", @"H", nil];
  NSOpenPanel	*openPanel = [NSOpenPanel openPanel];
  int		result;

  [openPanel setAllowsMultipleSelection: YES];
  [openPanel setCanChooseFiles: YES];
  [openPanel setCanChooseDirectories: NO];
  result = [openPanel runModalForDirectory: nil
				   file: nil
				  types: fileTypes];
  if (result == NSOKButton)
    {
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      NSMutableArray *list = [defaults objectForKey: @"HeaderList"];
      [list addObjectsFromArray: [openPanel filenames]];
      [defaults setObject: list forKey: @"HeaderList"];
      [table reloadData];
    }
}


- (void) removeAction: (id)sender
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *list = [defaults objectForKey: @"HeaderList"];
  int row = [table selectedRow];

  if(row >= 0)
    {
      NSString *stringValue = [list objectAtIndex: row];
      
      if(stringValue != nil)
	{
	  [list removeObject: stringValue];
	  [table reloadData];
	}
    }
}


- (void) preloadAction: (id)sender
{
  if (sender != preloadButton)
    { 
      return;
    }
  else
    {
      NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
      [defaults setBool: ([preloadButton state] == NSOnState?YES:NO) forKey:@"PreloadHeaders"];
      [defaults synchronize];
    }
}

- (BOOL)    tableView: (NSTableView *)tableView
shouldEditTableColumn: (NSTableColumn *)aTableColumn
		  row: (int)rowIndex
{
  BOOL result = NO;
  return result;
}

- (BOOL) tableView: (NSTableView *)tv
   shouldSelectRow: (int)rowIndex
{
  BOOL result = YES;
  return result;
}

@end