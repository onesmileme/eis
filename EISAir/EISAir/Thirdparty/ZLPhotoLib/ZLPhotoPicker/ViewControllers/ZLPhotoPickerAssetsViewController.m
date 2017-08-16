//
//  ZLPhotoPickerAssetsViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-12.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//


#import <AssetsLibrary/AssetsLibrary.h>
@import AVFoundation;
#import "ZLPhoto.h"
#import "ZLPhotoPickerCollectionView.h"
#import "ZLPhotoPickerGroup.h"
#import "ZLPhotoPickerCollectionViewCell.h"
#import "ZLPhotoPickerFooterCollectionReusableView.h"
#import "ZLPhotoSimpleToolbarView.h"
#import "ZLPhotoThumbsToolbarView.h"

static CGFloat CELL_ROW = 3;
static CGFloat CELL_MARGIN = 7;
static CGFloat CELL_LINE_MARGIN = 7;
static CGFloat TOOLBAR_HEIGHT = 44;

static NSString *const _footerIdentifier = @"FooterView";
static NSString *const _identifier = @"toolBarThumbCollectionViewCell";
@interface ZLPhotoPickerAssetsViewController () <ZLPhotoPickerCollectionViewDelegate,ZLPhotoPickerBrowserViewControllerDataSource,ZLPhotoPickerBrowserViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic , strong) ZLPhotoPickerCollectionView *collectionView;//图片显示的view
@property(nonatomic , strong) ZLPhotoThumbsToolbarView *toolbarThumbsView;//底部的显示图片的view
@property(nonatomic , strong) ZLPhotoSimpleToolbarView *toolbarSimpleView;//底部只显示完成的view

@property (nonatomic , weak) UIView *toolBar;
@property (assign,nonatomic) NSUInteger privateTempMinCount;
// 数据源
@property (nonatomic , strong) NSMutableArray *assets;
// 记录选中的assets
@property (nonatomic , strong) NSMutableArray *selectAssets;
// 拍照后的图片数组
@property (nonatomic , assign) BOOL takePhotoImages;
//是否浏览的是所有照片 否则是选中的照片
@property (nonatomic , assign) BOOL browserAllPhoto;

@end

@implementation ZLPhotoPickerAssetsViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _selectAssets = [NSMutableArray array];
    }
    return self;
}

#pragma mark - getter
-(ZLPhotoThumbsToolbarView *)toolbarThumbsView
{
    if (!_toolbarThumbsView) {
        _toolbarThumbsView = [[ZLPhotoThumbsToolbarView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        __weak typeof(self) wself = self;
        _toolbarThumbsView.selectAtIndexBlock = ^(NSInteger index){
            wself.browserAllPhoto = false;
            [wself browserPhotosAtIndex:index];
        };
        _toolbarThumbsView.doneBlock = ^{
            [wself doneAction];
        };
        
    }
    return _toolbarThumbsView;
}

-(ZLPhotoSimpleToolbarView *)toolbarSimpleView
{
    if(!_toolbarSimpleView){
        _toolbarSimpleView = [[ZLPhotoSimpleToolbarView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        __weak typeof(self) wself = self;
        _toolbarSimpleView.doneBlock = ^{
            [wself doneAction];
        };
    }
    return _toolbarSimpleView;
}

- (void)setSelectPickerAssets:(NSArray *)selectPickerAssets
{
    NSSet *set = [NSSet setWithArray:selectPickerAssets];
    _selectPickerAssets = [set allObjects];
    
    if (!self.assets) {
        self.assets = [NSMutableArray arrayWithArray:selectPickerAssets];
    }else{
        [self.assets addObjectsFromArray:selectPickerAssets];
    }
    
    for (ZLPhotoAssets *assets in selectPickerAssets) {
        if ([assets isKindOfClass:[ZLPhotoAssets class]] || [assets isKindOfClass:[UIImage class]]) {
            [self.selectAssets addObject:assets];
        }
    }

    self.collectionView.lastDataArray = nil;
    self.collectionView.isRecoderSelectPicker = YES;
    self.collectionView.selectAssets = self.selectAssets;
    [self updateToolbar];
}

- (void)setTopShowPhotoPicker:(BOOL)topShowPhotoPicker
{
    _topShowPhotoPicker = topShowPhotoPicker;

    if (self.topShowPhotoPicker == YES) {
        NSMutableArray *reSortArray= [[NSMutableArray alloc] init];
        
        ZLPhotoAssets *zlAsset = [[ZLPhotoAssets alloc] init];
        [reSortArray addObject:zlAsset];
        
        if (self.collectionView.status == ZLPickerCollectionViewShowOrderStatusTimeDesc) {
            [reSortArray addObjectsFromArray:self.collectionView.dataArray];
        }else{
            for (id obj in [self.collectionView.dataArray reverseObjectEnumerator]) {
                [reSortArray addObject:obj];
            }
        }
        
        self.collectionView.status = ZLPickerCollectionViewShowOrderStatusTimeDesc;
        self.collectionView.topShowPhotoPicker = topShowPhotoPicker;
        self.collectionView.dataArray = reSortArray;
        [self.collectionView reloadData];
    }
}

-(void)setCameraImage:(UIImage *)cameraImage
{
    _collectionView.cameraImage = cameraImage;
}

-(UIImage *)cameraImage
{
    return _collectionView.cameraImage;
}

#pragma mark collectionView
- (ZLPhotoPickerCollectionView *)collectionView
{
    if (!_collectionView) {
        
        CGFloat horPadding = 0;
        CGFloat topPadding = 5;
        CGFloat itemHorPadding = CELL_MARGIN;
        CGFloat itemVerPadding = CELL_LINE_MARGIN;
        NSInteger itemsPerRow = CELL_ROW;
        if (_photoLayout) {
            horPadding = _photoLayout.horPadding;
            topPadding = _photoLayout.topPadding;
            itemHorPadding = _photoLayout.itemHorPadding;
            itemVerPadding = _photoLayout.itemVerPadding;
        }
        
        CGFloat cellW = (self.view.frame.size.width - 2*horPadding  - itemHorPadding * itemsPerRow + 1) / itemsPerRow;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellW, cellW);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = itemVerPadding;
        layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, TOOLBAR_HEIGHT * 2);
        
        ZLPhotoPickerCollectionView *collectionView = [[ZLPhotoPickerCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        // 时间置顶
        collectionView.cameraImage = self.cameraImage;
        collectionView.status = ZLPickerCollectionViewShowOrderStatusTimeDesc;
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [collectionView registerClass:[ZLPhotoPickerCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        [collectionView registerClass:[ZLPhotoPickerCollectionViewCell class] forCellWithReuseIdentifier:cameraCellIdentifier];
        
        // 底部的View
        [collectionView registerClass:[ZLPhotoPickerFooterCollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:_footerIdentifier];
        
        collectionView.contentInset = UIEdgeInsetsMake(topPadding, horPadding,TOOLBAR_HEIGHT, horPadding);
        collectionView.collectionViewDelegate = self;
        [self.view insertSubview:_collectionView = collectionView belowSubview:self.toolBar];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(collectionView);
        
        NSString *widthVfl = @"H:|-0-[collectionView]-0-|";
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVfl options:0 metrics:nil views:views]];
        
        NSString *heightVfl = @"V:|-0-[collectionView]-0-|";
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVfl options:0 metrics:nil views:views]];
        
    }
    return _collectionView;
}

#pragma mark 初始化按钮
- (void) initNavItems
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    NSDictionary *attrs = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [UIImage imageNamed:@"photo_picker_back"];
    [backButton setImage:img forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [backButton sizeToFit];
    backButton.width += 10;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark -初始化底部ToorBar
- (void) setupToorBar
{
    UIView *toorBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    toorBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:toorBar];
    self.toolBar = toorBar;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(toorBar);
    NSString *widthVfl =  @"H:|-0-[toorBar]-0-|";
    NSString *heightVfl = @"V:[toorBar(44)]-0-|";
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVfl options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVfl options:0 metrics:0 views:views]];
    
    UIView *view = nil;
    if (self.photoLayout.bottomBarType == ZLPhotoBottomBarTypeThumbs) {
        view = self.toolbarThumbsView;
    }else{
        view = self.toolbarSimpleView;
    }
    
    [self.toolBar addSubview:view];
    
    self.toolBar.backgroundColor = [UIColor whiteColor];
    
}

-(void)updateToolbar
{
    if (_toolbarThumbsView) {
        [_toolbarThumbsView updateReddot:self.selectAssets];
        [_toolbarThumbsView reloadData];
    }else{
        [_toolbarSimpleView updateChooseImage:self.selectAssets.count total:self.minCount];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化按钮
    [self initNavItems];
    
    // 初始化底部ToorBar
    [self setupToorBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}


#pragma mark 初始化所有的组
- (void) setupAssets
{
    if (!self.assets) {
        self.assets = [NSMutableArray array];
    }
    
    __block NSMutableArray *assetsM = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    
    
    [[ZLPhotoPickerDatas defaultPicker] getGroupPhotosWithGroup:self.assetsGroup finished:^(NSArray *assets) {
        
        if (weakSelf.collectionView.status == ZLPickerCollectionViewShowOrderStatusTimeAsc) {
            [assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
                ZLPhotoAssets *zlAsset = [[ZLPhotoAssets alloc] init];
                zlAsset.asset = asset;
                [assetsM addObject:zlAsset];
            }];
            
        }else{
            [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
                ZLPhotoAssets *zlAsset = [[ZLPhotoAssets alloc] init];
                zlAsset.asset = asset;
                [assetsM addObject:zlAsset];
            }];
            
        }
        
        if (weakSelf.takePhotoImages && weakSelf.assetsGroup.assetsCount != assets.count) {
            //因为拍照等原因有了变化
            weakSelf.assetsGroup.assetsCount = assets.count;
            
            NSMutableArray *selectedIndexPath = [[NSMutableArray alloc]initWithCapacity:1+self.collectionView.selectsIndexPath.count];
            NSMutableArray *selectAssets = [[NSMutableArray alloc]initWithCapacity:selectedIndexPath.count];
            
            if (weakSelf.collectionView.status == ZLPickerCollectionViewShowOrderStatusTimeAsc) {
                
                [selectedIndexPath addObjectsFromArray:weakSelf.collectionView.selectsIndexPath];
                [selectAssets addObjectsFromArray:weakSelf.collectionView.selectAssets];
                                
                NSInteger index = assets.count - 1;
                [selectedIndexPath addObject:@(index)];
                [selectAssets addObject:assetsM[index]];
                
            }else{
                
                [selectedIndexPath addObject:@(0)];
                [selectAssets addObject:assetsM[0]];
                
                for (NSNumber *num in self.collectionView.selectsIndexPath) {
                    [selectedIndexPath addObject:@(num.integerValue + 1)];
                }
                [selectAssets addObjectsFromArray:weakSelf.collectionView.selectAssets];
                
            }
            
            weakSelf.collectionView.selectsIndexPath = selectedIndexPath;
            weakSelf.collectionView.selectAssets = selectAssets;
            weakSelf.selectAssets = selectAssets;
            weakSelf.takePhotoImages = false;
        }
        
        weakSelf.collectionView.dataArray = assetsM;
        [weakSelf updateToolbar];
    }];
    
}

- (void)pickerCollectionViewDidCameraSelect:(ZLPhotoPickerCollectionView *)pickerCollectionView
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
    
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请在iPhone的“设置-隐私-相机”选项中，允许财联社访问您的相机" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [controller addAction:action];
        
        [self presentViewController:controller animated:true completion:nil];
             
        return;
    }
    
    UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
    ctrl.delegate = self;
    ctrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:ctrl animated:YES completion:nil];    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 处理
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        NSLog(@"请在真机使用!");
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication]keyWindow] animated:true];
        hud.label.text = @"图片保存失败";
        [hud hideAnimated:true afterDelay:0.7];
        
    }else{
//        [self.selectAssets addObject:image];
        self.takePhotoImages = true;
        
        // 刷新下最小的页数
        self.minCount = self.selectAssets.count + (_privateTempMinCount - self.selectAssets.count);
        
        [self updateToolbar];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self setupAssets];
            self.topShowPhotoPicker = _topShowPhotoPicker;
        });
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - setter
-(void)setMinCount:(NSInteger)minCount
{
    _minCount = minCount;
    
    if (!_privateTempMinCount) {
        _privateTempMinCount = minCount;
    }

    if (self.selectAssets.count == minCount){
        minCount = 0;
    }else if (self.selectPickerAssets.count - self.selectAssets.count > 0) {
        minCount = _privateTempMinCount;
    }
    
    self.collectionView.minCount = minCount;
}

- (void)setAssetsGroup:(ZLPhotoPickerGroup *)assetsGroup
{
    if (!assetsGroup.groupName.length) return ;
    
    _assetsGroup = assetsGroup;
    
    self.title = assetsGroup.groupName;
    
    // 获取Assets
    [self setupAssets];
}


- (void) pickerCollectionViewDidSelected:(ZLPhotoPickerCollectionView *) pickerCollectionView deleteAsset:(ZLPhotoAssets *)deleteAssets
{
    
    if (self.selectPickerAssets.count == 0){
        self.selectAssets = [NSMutableArray arrayWithArray:pickerCollectionView.selectAssets];
    }else if (deleteAssets == nil){
        [self.selectAssets addObject:[pickerCollectionView.selectAssets lastObject]];
    }
    
    [self updateToolbar];
    
    if (self.selectPickerAssets.count || deleteAssets) {
        ZLPhotoAssets *asset = [pickerCollectionView.lastDataArray lastObject];
        if (deleteAssets){
            asset = deleteAssets;
        }
        
        NSInteger selectAssetsCurrentPage = -1;
        for (NSInteger i = 0; i < self.selectAssets.count; i++) {
            ZLPhotoAssets *photoAsset = self.selectAssets[i];
            if ([photoAsset isKindOfClass:[UIImage class]]) {
                continue;
            }
            if([[[[asset.asset defaultRepresentation] url] absoluteString] isEqualToString:[[[photoAsset.asset defaultRepresentation] url] absoluteString]]){
                selectAssetsCurrentPage = i;
                break;
            }
        }
        
        if (
            (self.selectAssets.count > selectAssetsCurrentPage)
            &&
            (selectAssetsCurrentPage >= 0)
            ){
            if (deleteAssets){
                [self.selectAssets removeObjectAtIndex:selectAssetsCurrentPage];
            }
            
            [self.collectionView.selectsIndexPath removeObject:@(selectAssetsCurrentPage)];

            [self updateToolbar];
        }
        // 刷新下最小的页数
        self.minCount = self.selectAssets.count + (_privateTempMinCount - self.selectAssets.count);
    }
}

-(void)pickerCollectionView:(ZLPhotoPickerCollectionView *)pickerCollectionView browseAtIndexPath:(NSIndexPath *)indexPath
{
    self.browserAllPhoto = true;
    NSInteger index = indexPath.item;
    if (self.topShowPhotoPicker) {
        index -= 1;
    }
    [self browserPhotosAtIndex:index];
}

#pragma mark -
- (NSInteger)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section
{
    //浏览所有照片
    if (_browserAllPhoto) {
        
        NSInteger count =  self.collectionView.dataArray.count;
        if (self.topShowPhotoPicker) {
            count -= 1;
        }
        return count;
    }
    return self.selectAssets.count;
}

-  (ZLPhotoPickerBrowserPhoto *)photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath
{
    ZLPhotoPickerBrowserPhoto *photo = [[ZLPhotoPickerBrowserPhoto alloc] init];
    UIImageView *imageView = nil;
    ZLPhotoAssets *asset = nil;
    if (_browserAllPhoto) {
        NSInteger delta = 0;
        if (self.topShowPhotoPicker) {
            delta = 1;
        }
        if (indexPath.row < self.collectionView.dataArray.count - 1) {
            asset = self.collectionView.dataArray[indexPath.row + delta];
        }
        
        photo.checked =  [self.selectAssets containsObject:asset];
        
    }else{
        imageView = [_toolbarThumbsView imageViewWithIndex:indexPath.item];
        if (self.selectAssets.count && self.selectAssets.count - 1 >= indexPath.item) {
            asset = self.selectAssets[indexPath.row];
        }
    }
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        photo.thumbImage = asset.thumbImage;
        photo.asset = asset;
    }else if ([asset isKindOfClass:[UIImage class]]){
        photo.thumbImage = (UIImage *)asset;
        photo.photoImage = (UIImage *)asset;
    }    
    photo.toView = imageView;
    
    return photo;
}

-(NSInteger)numberOfChoosedInphotoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser
{
    return [self.selectAssets count];
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_browserAllPhoto) {
        
        
        
    }else{
        // 删除选中的照片
        ALAsset *asset = self.selectAssets[indexPath.row];
        NSInteger currentPage = indexPath.row;
        for (NSInteger i = 0; i < self.collectionView.dataArray.count; i++) {
            ALAsset *photoAsset = self.collectionView.dataArray[i];
            if ([photoAsset isKindOfClass:[ZLPhotoAssets class]] && [asset isKindOfClass:[ZLPhotoAssets class]]) {
                ZLPhotoAssets *photoAssets = (ZLPhotoAssets *)photoAsset;
                ZLPhotoAssets *assets = (ZLPhotoAssets *)asset;
                if([[[[assets.asset defaultRepresentation] url] absoluteString] isEqualToString:[[[photoAssets.asset defaultRepresentation] url] absoluteString]]){
                    currentPage = i;
                    break;
                }
            }else{
                continue;
                break;
            }
        }
        
        [self.selectAssets removeObjectAtIndex:indexPath.row];
        [self.collectionView.selectAssets removeObject:asset];
        [self.collectionView.selectsIndexPath removeObject:@(currentPage)];
        [self.collectionView reloadData];
        
        [self updateToolbar];
    }
}

/**
 *  更改indexPath对应索引的图片的选择情况 选择=》未选择 未选择=》 选择
 *
 *  @param indexPath        要操作的索引值
 */
- (BOOL)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser changeCheckPhotoAtIndexPath:(NSIndexPath *)indexPath photo:(ZLPhotoPickerBrowserPhoto *)photo
{
    ZLPhotoAssets *asset = photo.asset;
    BOOL checked = false;
    
    NSInteger currentPage = indexPath.item;
    for (NSInteger i = 0; i < self.collectionView.dataArray.count; i++) {
        ALAsset *photoAsset = self.collectionView.dataArray[i];
        if ([photoAsset isKindOfClass:[ZLPhotoAssets class]] && [asset isKindOfClass:[ZLPhotoAssets class]]) {
            ZLPhotoAssets *photoAssets = (ZLPhotoAssets *)photoAsset;
            ZLPhotoAssets *assets = (ZLPhotoAssets *)asset;
            if([[[[assets.asset defaultRepresentation] url] absoluteString] isEqualToString:[[[photoAssets.asset defaultRepresentation] url] absoluteString]]){
                currentPage = i;
                break;
            }
        }
    }
    
    if (photo.checked) {
        //已经选中，取消选中
        [self.selectAssets removeObject:asset];
        [self.collectionView.selectAssets removeObject:asset];
        [self.collectionView.selectsIndexPath removeObject:@(indexPath.item)];
        
        
    }else{
        //进行选中
        
        if ([self.collectionView checkOverMax]) {
            return false;
        }
        [self.selectAssets addObject:asset];
        [self.collectionView.selectAssets addObject:asset];
    }
    
    if (_browserAllPhoto) {
        NSInteger delta = 0;
        if (self.topShowPhotoPicker) {
            delta = 1;
        }
        if (indexPath.row < self.collectionView.dataArray.count - 1) {
            asset = self.collectionView.dataArray[indexPath.row + 1];
        }
        
        checked =  [self.selectAssets containsObject:asset];
        
    }else{
        if (self.selectAssets.count && self.selectAssets.count - 1 >= indexPath.item) {
            asset = self.selectAssets[indexPath.row];
        }
    }
    
    [self.collectionView reloadData];
    
    [self updateToolbar];
    
    return true;
        
}

-(void)photoBrowserClickDone:(ZLPhotoPickerBrowserViewController *)photoBrowser
{
    if (self.selectAssets.count == 0) {
        [self.selectAssets addObject:photoBrowser.currentPhoto.asset];
    }
    [self.navigationController popToViewController:self animated:false];
    [self doneAction];
}


-(void)browserPhotosAtIndex:(NSInteger)index
{
    ZLPhotoPickerBrowserViewController *browserVc = [[ZLPhotoPickerBrowserViewController alloc] init];
    if (_browserAllPhoto) {
        browserVc.status = UIViewAnimationAnimationStatusFade;
    }    
    browserVc.currentIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    browserVc.editing = YES;
    browserVc.delegate = self;
    browserVc.dataSource = self;
    browserVc.pushIn = true;
    browserVc.browserMode = ZLPhotoPickerBrowserModePushCheckable;
    [self.navigationController pushViewController:browserVc animated:true];
}

#pragma mark -<Navigation Actions>
- (void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)doneAction
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_TAKE_DONE object:nil userInfo:@{@"selectAssets":self.selectAssets}];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
    // 赋值给上一个控制器
    self.groupVc.selectAsstes = self.selectAssets;
}

-(BOOL)shouldAutorotate
{
    return true;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
