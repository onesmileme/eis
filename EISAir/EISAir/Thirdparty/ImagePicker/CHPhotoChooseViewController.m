//
//  CHPhotoChooseViewController.m
//  Find
//
//  Created by chunhui on 15/8/6.
//  Copyright (c) 2015年 chunhui. All rights reserved.
//

#import "CHPhotoChooseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLPhoto.h"
#import "ZLPhotoPickerCollectionView.h"
#import "ZLPhotoPickerGroup.h"
#import "ZLPhotoPickerCollectionViewCell.h"
#import "ZLPhotoPickerFooterCollectionReusableView.h"
#import "UIBarButtonItem+Navigation.h"
#import "Masonry.h"
#import "CHGalleryGroupViewController.h"
#import "ImageHelper.h"


static CGFloat CELL_ROW = 3;
static CGFloat CELL_MARGIN = 2;
static CGFloat CELL_LINE_MARGIN = 2;


static NSString *const _cellIdentifier = @"cell";
static NSString *const _footerIdentifier = @"FooterView";


@interface CHPhotoChooseViewController ()<ZLPhotoPickerCollectionViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic , weak) IBOutlet UIView *toolbarView;

// 相片View
@property (nonatomic , strong) ZLPhotoPickerCollectionView *collectionView;

@property (assign,nonatomic) NSUInteger privateTempMaxCount;
// Datas
// 数据源
@property (nonatomic , strong) NSMutableArray *assets;
// 记录选中的assets
@property (nonatomic , strong) NSMutableArray *selectAssets;
// 拍照后的图片数组
@property (strong,nonatomic) NSMutableArray *takePhotoImages;

@end

@implementation CHPhotoChooseViewController

- (NSMutableArray *)selectAssets{
    if (!_selectAssets) {
        _selectAssets = [NSMutableArray array];
    }
    return _selectAssets;
}

-(NSArray *)chooseAssets
{
    if ([_takePhotoImages count] > 0) {
        return [_takePhotoImages copy];
    }
    return [_selectAssets copy];
}

-(void)clear
{
    [self.selectAssets removeAllObjects];
    self.selectPickerAssets = nil;
    [_takePhotoImages removeAllObjects];
    
    [self.collectionView.selectAssets removeAllObjects];
    [self.collectionView.selectsIndexPath removeAllObjects];
//    self.collectionView.dataArray = nil;
    
    [self.collectionView reloadData];
}

- (NSMutableArray *)takePhotoImages{
    if (!_takePhotoImages) {
        _takePhotoImages = [NSMutableArray array];
    }
    return _takePhotoImages;
}

- (void)setSelectPickerAssets:(NSArray *)selectPickerAssets{
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
}

- (void)setTopShowPhotoPicker:(BOOL)topShowPhotoPicker{
    _topShowPhotoPicker = topShowPhotoPicker;
    
    if (self.topShowPhotoPicker == YES) {
        NSMutableArray *reSortArray= [[NSMutableArray alloc] init];
        for (id obj in [self.collectionView.dataArray reverseObjectEnumerator]) {
            [reSortArray addObject:obj];
        }
        
        ZLPhotoAssets *zlAsset = [[ZLPhotoAssets alloc] init];
        [reSortArray insertObject:zlAsset atIndex:0];
        
        self.collectionView.status = ZLPickerCollectionViewShowOrderStatusTimeAsc;
        self.collectionView.topShowPhotoPicker = topShowPhotoPicker;
        self.collectionView.dataArray = reSortArray;
        [self.collectionView reloadData];
    }
}

#pragma mark collectionView
- (ZLPhotoPickerCollectionView *)collectionView{
    if (!_collectionView) {
        
        CGFloat cellW = (CGRectGetWidth([[UIScreen mainScreen] bounds]) - CELL_MARGIN * CELL_ROW + 1) / CELL_ROW;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellW, cellW);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = CELL_LINE_MARGIN;

        
        ZLPhotoPickerCollectionView *collectionView = [[ZLPhotoPickerCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        // 时间置顶
        collectionView.status = ZLPickerCollectionViewShowOrderStatusTimeDesc;
        collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [collectionView registerClass:[ZLPhotoPickerCollectionViewCell class] forCellWithReuseIdentifier:_cellIdentifier];
        // 底部的View
        [collectionView registerClass:[ZLPhotoPickerFooterCollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:_footerIdentifier];
        
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        collectionView.contentInset = UIEdgeInsetsMake(0, 0 , 0 , 0);
        collectionView.collectionViewDelegate = self;
        
        
        _collectionView = collectionView;
        [self.view addSubview:collectionView];
//        [self.view bringSubviewToFront:_toolbarView];
        
        [collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(collectionView.superview.mas_top).offset(0);
            make.left.equalTo(collectionView.superview.mas_left);
            make.right.equalTo(collectionView.superview.mas_right);
            make.bottom.equalTo(collectionView.superview.mas_bottom);
        }];        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"照片";
    // 初始化按钮
    [self setupNavItems];
    
}


#pragma mark 初始化按钮
- (void) setupNavItems
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.rightItemName?:@"下一步" style:UIBarButtonItemStyleDone target:self action:@selector(nextAction)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem defaultLeftItemWithTarget:self action:@selector(backAction)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

#pragma mark 初始化所有的组
/**
 * added photo 是否有拍照添加的照片
 */
- (void) setupAssets:(BOOL)addedPhoto
{
    if (!self.assets) {
        self.assets = [NSMutableArray array];
    }
    
    __block NSMutableArray *assetsM = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    
    [[ZLPhotoPickerDatas defaultPicker] getGroupPhotosWithGroup:self.assetsGroup finished:^(NSArray *assets) {
        
        
        [assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
            ZLPhotoAssets *zlAsset = [[ZLPhotoAssets alloc] init];
            zlAsset.asset = asset;
//            [assetsM addObject:zlAsset];
            
            [assetsM insertObject:zlAsset atIndex:0];
        }];
        
        if(addedPhoto && assetsM.count > 0){
            
            [self.selectAssets addObject:[assetsM firstObject]];
//            [self.collectionView.selectAssets addObject:[assetsM firstObject]];
            [self.collectionView.selectsIndexPath addObject:@(1)];
        }
        
        weakSelf.collectionView.dataArray = assetsM;
        
        [weakSelf.collectionView reloadData];
    }];
    
}



- (void)pickerCollectionViewDidCameraSelect:(ZLPhotoPickerCollectionView *)pickerCollectionView{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
    ctrl.delegate = self;
    ctrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    ctrl.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 处理
        UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
        
        //下面将拍摄的照片添加到了相册库，然后重新刷新了，此处不用添加了
//        [self.assets addObject:image];
//        [self.takePhotoImages addObject:image];
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
        
        [picker dismissViewControllerAnimated:YES completion:^(){
            
            if(self.maxCount == 1){
                //最多选择一张时，直接跳转到下一步
                [self nextAction];
                
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self setupAssets:true];
                    
                    self.navigationItem.rightBarButtonItem.enabled = true;
                    
                });
            }
            
        }];
        
        
    }else{
        NSLog(@"请在真机使用!");
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - setter
-(void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    
    if (!_privateTempMaxCount) {
        _privateTempMaxCount = maxCount;
    }
    
    if (self.selectAssets.count == maxCount){
        maxCount = 0;
    }else if (self.selectPickerAssets.count - self.selectAssets.count > 0) {
        maxCount = _privateTempMaxCount;
    }
    
    self.collectionView.minCount = maxCount;
}

- (void)setAssetsGroup:(ZLPhotoPickerGroup *)assetsGroup{
    if (!assetsGroup.groupName.length) return ;
    
    _assetsGroup = assetsGroup;
    
    // 获取Assets
    [self setupAssets:false];
}


- (void) pickerCollectionViewDidSelected:(ZLPhotoPickerCollectionView *) pickerCollectionView deleteAsset:(ZLPhotoAssets *)deleteAssets{
    
    if (self.selectPickerAssets.count == 0){
        self.selectAssets = [NSMutableArray arrayWithArray:pickerCollectionView.selectAssets];
    }else if (deleteAssets == nil){
        [self.selectAssets addObject:[pickerCollectionView.selectAssets lastObject]];
    }
    
    [self.selectAssets addObjectsFromArray:self.takePhotoImages];
    
    if (_chooseBlock) {
        _chooseBlock(self.selectAssets);
    }
    
    self.navigationItem.rightBarButtonItem.enabled = self.selectAssets.count > 0;
    
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
        }
        // 刷新下最小的页数
        self.maxCount = self.selectAssets.count + (_privateTempMaxCount - self.selectAssets.count);
    }
    
}


#pragma mark -<Navigation Actions>
- (void) done{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_TAKE_DONE object:nil userInfo:@{@"selectAssets":self.selectAssets}];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)nextAction
{ 
    if (_nextActionBlcok) {
        _nextActionBlcok(self.selectAssets);
    }
}

-(void)backAction
{
    
    if (_backActionBlock) {
        _backActionBlock();
    }else{
        [self dismiss];
    }
}

-(void)dismiss
{
//    [self.navigationController dismissViewControllerAnimated:NO completion:^{
//        
//    }];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)groupAction:(id)sender
{

    CHGalleryGroupViewController *controller = [[CHGalleryGroupViewController alloc]initWithNibName:@"CHGalleryGroupViewController" bundle:nil];
    controller.groups = self.assetGroups;
    
    __weak CHPhotoChooseViewController *weakSelf = self;
    controller.chooseGroupBlock = ^(ZLPhotoPickerGroup *group){
        
        [weakSelf setAssetsGroup:group];
    };
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
