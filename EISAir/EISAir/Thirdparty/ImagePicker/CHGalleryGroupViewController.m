//
//  CHGalleryGroupViewController.m
//  Find
//
//  Created by chunhui on 15/8/6.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import "CHGalleryGroupViewController.h"
#import "CHPhotoGroupTableViewCell.h"
#import "UIBarButtonItem+Navigation.h"

@interface CHGalleryGroupViewController ()

@end

@implementation CHGalleryGroupViewController

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"照片";
    
    UINib *nib = [UINib nibWithNibName:@"FDPhotoGroupTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"group"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem defaultLeftItemWithTarget:self action:@selector(backAction)];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_groups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CHPhotoGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"group"];
    
    
    ZLPhotoPickerGroup *group = [_groups objectAtIndex:indexPath.row];
    UIImage *image = [group thumbImage];
    
    [cell updateWithThumb:image name:group.groupName count:group.assetsCount];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    ZLPhotoPickerGroup *group = [_groups objectAtIndex:indexPath.row];
    if (self.chooseGroupBlock) {
        self.chooseGroupBlock(group);
    }
    [self backAction];
    
}


-(UIImage *)assetImage:(ALAsset *)asset
{
    ALAssetRepresentation *reptation = [asset defaultRepresentation];
    CGImageRef imageRef = [reptation fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imageRef scale:1 orientation:(UIImageOrientation)[reptation orientation]];
    
    return img;
    
}



@end
