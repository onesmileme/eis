//
//  EAUserInfoModifyViewController.m
//  EISAir
//
//  Created by chunhui on 2017/9/23.
//  Copyright © 2017年 onesmile. All rights reserved.
//

#import "EAUserInfoModifyViewController.h"
#import "EAModifyPasswordViewController.h"
#import "EAUserInfoAvatarCell.h"
#import "EALoginUserInfoModel.h"
#import "EAUserInfoMNameTableViewCell.h"
#import "TKImagePickerHelper.h"

@interface EAUserInfoModifyViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) UITextField *nameTextField;
@property(nonatomic , strong) TKImagePickerHelper *imagePickerHelper;
@end

@implementation EAUserInfoModifyViewController

-(void)initNavbar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 60, 40);
    [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = saveItem;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户信息";
    [self initNavbar];
    
    UINib *nib = [UINib nibWithNibName:@"EAUserInfoMNameTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"name_cell"];
    
    nib = [UINib nibWithNibName:@"EAUserInfoAvatarCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"avatar_cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveAction:(id)sender
{
    
    //TODO call modify password
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        EAUserInfoAvatarCell *c = [tableView dequeueReusableCellWithIdentifier:@"avatar_cell"];
        
        cell = c;
        
    }else{
        
        if (indexPath.row == 0) {
            EAUserInfoMNameTableViewCell *nameCell = [tableView dequeueReusableCellWithIdentifier:@"name_cell"];
            nameCell.textField.text = self.userInfo.loginName;
            self.nameTextField = nameCell.textField;
            self.nameTextField.delegate = self;
            
            cell = nameCell;
            
        }else if (indexPath.row == 1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"info_cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"info_cell"];
            }
            cell.detailTextLabel.textColor = HexColor(0xd8d8d8);
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];
        }
        
        if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"角色";
            cell.detailTextLabel.text = self.userInfo.roleName;
        }else if (indexPath.row == 2){
            cell.textLabel.text =  @"修改密码";
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  CGFLOAT_MIN;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        EAModifyPasswordViewController *controller = [[EAModifyPasswordViewController alloc]init];
        [self.navigationController pushViewController:controller animated:true];
    }else if (indexPath.section == 0){
        [self showChooseAvatarSheet];
    }
}


-(void)showChooseAvatarSheet
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //从相册里面取
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"从相册里面取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseImage:true];
    }];
    
    [controller addAction:action];
    
    //拍照
    action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseImage:false];
    }];
    [controller addAction:action];
    
    action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [controller addAction:action];
    
    [self presentViewController:controller animated:true completion:nil];
    
}

-(void)chooseImage:(BOOL)gallery
{
    if (!_imagePickerHelper) {
        _imagePickerHelper = [[TKImagePickerHelper alloc]init];
        
        __weak typeof(self) wself = self;
        _imagePickerHelper.chooseImageBlock = ^(UIImage *image, NSDictionary<NSString *,id> *editingInfo) {
            NSLog(@"image is: %@",image);
            NSLog(@"edit info is: \n%@\n",editingInfo);
        };
    }
    
    UIImagePickerControllerSourceType source = gallery ?UIImagePickerControllerSourceTypeSavedPhotosAlbum:UIImagePickerControllerSourceTypeCamera;
    
    [_imagePickerHelper showPickerWithPresentController:self.navigationController sourceType:source allowEdit:true];
}



-(void)updateloadImage:(UIImage *)image
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
