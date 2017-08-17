//
//  FASlideConfigManager.m
//  FunApp
//
//  Created by liuzhao on 2016/11/19.
//  Copyright © 2016年 chunhui. All rights reserved.
//

#if 0
#import "EASlideConfigManager.h"
#import "TKFileUtil.h"
#import "TKRequestHandler+SlideConfig.h"

@interface EASlideConfigManager ()

@property (nonatomic, strong) EASlideConfigDataModel *configModel;

@end

@implementation EASlideConfigManager

+(instancetype)sharedInstance
{
    static EASlideConfigManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EASlideConfigManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadConfig];
        [self syncConfig];
    }
    return self;
}

-(void)loadConfig
{
    NSString *path = [self configPath];

    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = [[NSBundle mainBundle] pathForResource:@"slide_page.json" ofType:@""];
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data != nil) {
        self.configModel = [[EASlideConfigDataModel alloc] initWithData:data error:nil];
        if (self.configModel.categoryList == nil) {
            path = [[NSBundle mainBundle] pathForResource:@"slide_page.json" ofType:@""];
            data = [NSData dataWithContentsOfFile:path];
            
            if (data != nil) {
                self.configModel = [[EASlideConfigDataModel alloc] initWithData:data error:nil];
            }
        }
    }
}

- (NSString *)configPath
{
    NSString* docPath = [TKFileUtil docPath];
    return [docPath stringByAppendingPathComponent:@"slide_config.dat"];
}

- (void)syncConfig
{
    __weak typeof (self) weakSelf = self;
    [[TKRequestHandler sharedInstance] getAppSlideConfigWithFinish:^(NSURLSessionDataTask *sessionDataTask, FASlideConfigModel *model, NSError *error) {
        if (!error) {
            if (model.data.categoryList && model.data.categoryList > 0) {
                NSArray<FASlideConfigDataCategoryListModel> * originNews = weakSelf.configModel.categoryList;
                weakSelf.configModel = [model.data copy];
                [weakSelf saveConfigData];
                [weakSelf checkNewsChanged:originNews];
            }
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:kAppSlideConfigFailedNotification object:nil];
        }
    }];
}

- (void)checkNewsChanged:(NSArray<EASlideConfigDataCategoryListModel> *)originalNews
{
    BOOL change = true;
    if(originalNews.count == self.configModel.categoryList.count) {
        for (NSInteger i = 0; i < originalNews.count; i++) {
            change = false;
            FASlideConfigDataCategoryListModel *old = originalNews[i];
            FASlideConfigDataCategoryListModel *new = self.configModel.categoryList[i];
            if (![old.cname isEqualToString:new.cname] || ![old.catid isEqualToString:new.catid]) {
                change = true;
                break;
            }
        }
    }
    if (change) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kAppSlideConfigUpdateNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:kAppSlideConfigSucceedNotification object:nil];
    }
}

- (void)saveConfigData
{
    if (self.configModel != nil) {
        NSString *path = [self configPath];
        NSString *jsonString = [self.configModel toJSONString];
        
        [jsonString writeToFile:path atomically:true encoding:NSUTF8StringEncoding error:nil];
    }
}

- (EASlideConfigDataModel *)slideConfigModel
{
    return self.configModel;
}
@end
#endif
