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
#import "TKRequestHandler+UserInfo.h"
#import "TKAccountManager.h"
#import "TKRequestHandler+UploadImage.h"

@interface EAUserInfoModifyViewController ()<UITextFieldDelegate>

@property(nonatomic , strong) UITextField *nameTextField;
@property(nonatomic , strong) TKImagePickerHelper *imagePickerHelper;
@property(nonatomic , strong) UIImage *avatar;
@property(nonatomic , weak)   MBProgressHUD *hud;

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
    EAUserInfoFilterModel *filterModel = [[EAUserInfoFilterModel alloc]init];
    if (_nameTextField.text.length > 0) {
        NSString *name = [_nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (name.length > 0) {
            filterModel.name = name;
        }
    }
    
    MBProgressHUD *hud = [EATools showLoadHUD:self.view.window];
    __weak typeof(self) wself = self;
    [[TKRequestHandler sharedInstance] updateUserInfo:filterModel completion:^(NSURLSessionDataTask *task, EALoginUserInfoModel *model, NSError *error) {
        if (model.success) {
            [hud hideAnimated:true];
            [TKAccountManager sharedInstance].loginUserInfo = model.data;
            [[TKAccountManager sharedInstance] save];
            if (wself.modifyUserInfoBlock) {
                wself.modifyUserInfoBlock(model.data);
            }
            [self.navigationController popViewControllerAnimated:true];
        }else{
            if (model == nil) {
                hud.label.text = error.localizedDescription;
            }else{
                hud.label.text = model.msg?:@"更改信息失败";
            }
            [hud hideAnimated:true afterDelay:1];
        }
    }];
    
    
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
        
        if (self.avatar) {
            [c updateWithImage:self.avatar];
        }else{
            [c updateWithAvatar:self.userInfo.avatar];
        }
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            [wself doUpdateloadImage:image];
        };
    }
    
    UIImagePickerControllerSourceType source = gallery ?UIImagePickerControllerSourceTypeSavedPhotosAlbum:UIImagePickerControllerSourceTypeCamera;
    
    [_imagePickerHelper showPickerWithPresentController:self.navigationController sourceType:source allowEdit:true];
}

-(void)doUpdateloadImage:(UIImage *)image
{
    self.avatar = image;
    [self getPolicy];
}

-(void)getPolicy
{
    
    self.hud = [EATools showLoadHUD:self.view];
    __weak typeof(self) wself = self;
    [[TKRequestHandler sharedInstance] getOssPolicyCompletion:^(NSURLSessionDataTask *task, EAOssPolicyModel *policy, NSError *error) {
        if (error || policy == nil) {
            wself.hud.label.text = @"上传失败";
            [wself.hud hideAnimated:true afterDelay:1];
        }else{
            [wself uploadImage:policy];
        }
    }];
}

-(void)uploadImage:(EAOssPolicyModel *)policy
{
    __weak typeof(self) wself = self;
    [[TKRequestHandler sharedInstance]postImage:self.avatar policy:policy completion:^(NSURLSessionDataTask *task, NSString *imgUrl, NSInteger size, NSError *error) {
        if (imgUrl) {
            EALoginUserInfoDataModel *uinfo = [[TKAccountManager sharedInstance]loginUserInfo];
            EASyncFileInfoModel *info = [[EASyncFileInfoModel alloc]init];
            info.quoteId = uinfo.userId;
            info.quoteType = @"userInfoImg";
            info.fileSize = size;
            info.fileName = [imgUrl lastPathComponent];
            NSURL *url = [NSURL URLWithString:imgUrl];
            info.path = [url path];
            info.siteId = uinfo.siteId;
            info.orgId = uinfo.orgId;
            
//            EASyncFileInfoModel *model = [[EASyncFileInfoModel alloc]init];
//            model.items = @[info];
            
            [wself saveImageInfo:info imgUrl:imgUrl];
        }else{
            wself.hud.label.text = @"上传失败";
            [wself.hud hideAnimated:true afterDelay:1];
        }
    }];
}

-(void)saveImageInfo:(EASyncFileInfoModel *)info imgUrl:(NSString *)imgUrl
{
    __weak typeof(self) wself = self;
    [[TKRequestHandler sharedInstance] saveImageInfo:info completion:^(NSURLSessionDataTask *task, BOOL success , NSDictionary *dict , NSError *error) {
        if (success) {
            [wself.hud hideAnimated:true];
            wself.userInfo.avatar = imgUrl;
            if (wself.modifyUserInfoBlock) {
                wself.modifyUserInfoBlock(wself.userInfo);
            }
            [wself.tableView reloadData];
            
        }else{
            wself.hud.label.text = @"上传失败";
            [wself.hud hideAnimated:true afterDelay:1];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *name = [[NSMutableString alloc]initWithString:textField.text];
    [name replaceCharactersInRange:range withString:string];
    if (name.length > 10) {
        return false;
    }
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
