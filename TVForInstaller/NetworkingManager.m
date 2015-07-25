//
//  NetworkingManager.m
//  TVForInstaller
//
//  Created by AlienLi on 15/5/7.
//  Copyright (c) 2015年 AlienLi. All rights reserved.
//

#import "NetworkingManager.h"
#import "NSDictionary+JSONString.h"
#import <JGProgressHUD.h>
#import "AppDelegate.h"
#import "AccountManager.h"

#define kServer @"http://zqzh1.chinacloudapp.cn:8080/zhiKey/appengController.do?enterService"
#define kServer2 @"http://zqzh1.chinacloudapp.cn:8080/zhiKey/softController.do?getSoftService"
//#define kServer @"http://10.0.0.116:8080/zhiKey/appengController.do?enterService"
//#define kServer2 @"http://10.0.0.116:8080/zhiKey/softController.do?getSoftService"

#define kBaiduAK @"ASFFfRDOzCBZ4kqSLwOmsCvh"
#define kBaiduGeoTableID 114851


@implementation NetworkingManager


//+(void)Login;

+(void)focusNetWorkError{
    
    JGProgressHUD *hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    
    hud.textLabel.text = @"无法连接服务器,请检查网络连接";
    hud.indicatorView = nil;
    
    hud.tapOutsideBlock = ^(JGProgressHUD *hud){
        [hud dismiss];
    };
    
    hud.tapOnHUDViewBlock = ^(JGProgressHUD *hud){
        [hud dismiss];
    };

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [hud showInView:delegate.window];
    [hud dismissAfterDelay:2.0];
    
}

+(void)login:(NSString*)account withPassword:(NSString *)password withCompletionHandler:(NetWorkHandler)completionHandler FailHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"phone":account,@"password":password} bv_jsonStringWithPrettyPrint:YES];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"20",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}


+(void)registerCellphone:(NSString*)phone password:(NSString*)password inviteCode:(NSString*)inviteCode chinaID:(NSString*)chinaID verifyCode:(NSString*)verifyCode withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"phone":phone,@"password":password,@"invitecode":inviteCode,@"idcard":chinaID,@"code":verifyCode} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"10",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}



+(void)fetchRegisterVerifyCode:(NSString*)cellphoneNumber withComletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"phone":cellphoneNumber} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"11",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)fetchForgetPasswordVerifyCode:(NSString*)cellphoneNumber withComletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"phone":cellphoneNumber} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"50",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];

}

+(void)fetchModifyPasswordVerifyCode:(NSString*)cellphoneNumber withComletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"phone":cellphoneNumber} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"51",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];

}
+(void)ModifyPasswordwithNewPassword:(NSString*)password verifyCode:(NSString*)code withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"newpassword":password,@"id":[AccountManager getTokenID],@"code":code} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"32",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)forgetPasswordOnCellPhone:(NSString*)cellphone password:(NSString*)password verifyCode:(NSString*)code withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"phone":cellphone,@"newpassword":password,@"code":code} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"31",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)fetchGradeByTokenID:(NSString*)tokenID withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"id":tokenID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"33",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}
+(void)fetchInviteByTokenID:(NSString*)tokenID withCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"id":tokenID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"34",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)fetchApplicationwithCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer2 parameters:nil success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)fetchOrderwithCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
     NSString * param = [@{@"id":[AccountManager getTokenID]} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"41",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];

}

+(void)disableOrderByID:(NSString *)orderID withcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"orderid":orderID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"42",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)revokeOrderID:(NSString *)orderID ByTokenID:(NSString*)tokenID withcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"orderid":orderID,@"id":tokenID} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"43",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}

+(void)submitOrderDictionary:(NSDictionary*)order bill:(NSDictionary*)bill applist:(NSArray*)applist source:(NSNumber*)source withcompletionHandler:(NetWorkHandler)completionHandler failHandle:(NetWorkFailHandler)failHandler{

    
    NSString * param = [@{@"order":order,@"bill":bill,@"source":source,@"applist":applist} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"44",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
    
}

+(void)modifyInfowithGender:(NSInteger)gender name:(NSString *)name address:(NSString *)address withComletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"gender":@(gender),@"name":name,@"address":address,@"id":[AccountManager getTokenID]} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"30",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];

}



+(void)fetchMyChildrenListwithCompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString * param = [@{@"id":[AccountManager getTokenID]} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kServer parameters:@{@"action":@"60",@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}



+(NSDictionary *)createOrderDictionaryByOrderID:(NSString *)orderID phone:(NSString*)phone paymodel:(NSNumber*)paymodel source:(NSNumber*)source address:(NSString*)address brand:(NSString*)brand engineer:(NSString*)engineer mac:(NSString*)mac hoster:(NSString*)hoster size:(NSString*)size version:(NSString *)version type:(NSNumber *)type createdate:(NSString *)createdate{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    dic[@"id"] = @1;
    dic[@"orderid"] =orderID;
    dic[@"phone"] = phone;
    dic[@"paymodel"] = paymodel;
    dic[@"source"] = source;
    dic[@"address"] = address;
    dic[@"brand"] = brand;
    dic[@"engineer"] = engineer;
    dic[@"mac"] = mac;
    dic[@"hoster"] = hoster;
    dic[@"size"] = size;
    dic[@"version"] = version;
    dic[@"type"] = type;
    dic[@"createdate"] = createdate;
    dic[@"status"] = @1;


    
    return dic;
};
+(NSDictionary*)createBillbyHostphone:(NSString*)hostphone zjservice:(NSNumber*)zjservice sczkfei:(NSNumber*)sczkfei zhijia:(NSNumber*)zhijia hdmi:(NSNumber*)hdmi yiji:(NSNumber*)yiji{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    dic[@"hostphone"] =hostphone;
    dic[@"zjservice"] =zjservice;
    dic[@"sczkfei"] = sczkfei;
    dic[@"zhijia"] = zhijia;
    dic[@"hmdi"] = hdmi;
    dic[@"yiji"] = yiji;
    
    
    return dic;

}


+(void)getMacAddressFromTV:(NSString*)IPAddress WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString *IP = [NSString stringWithFormat:@"http://%@:7766/getEmpinfo",IPAddress];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:IP parameters:nil success:completionHandler failure:failHandler];
 
}

+(void)getTVApplist:(NSString*)IPAddress WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString *IP = [NSString stringWithFormat:@"http://%@:7766/getappinfo",IPAddress];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:IP parameters:nil success:completionHandler failure:failHandler];
}

+(void)OneKeyInstall:(NSString*)IPAddress WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    NSString *IP = [NSString stringWithFormat:@"http://%@:7766/install",IPAddress];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:IP parameters:nil success:completionHandler failure:failHandler];

}

+(void)selectAppToInstall:(NSString*)apkurl ipaddress:(NSString*)IPAddress WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString *IP = [NSString stringWithFormat:@"http://%@:7766/customizationinstall",IPAddress];

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:IP parameters:@{@"apkurl":apkurl} success:completionHandler failure:failHandler];
}


+(void)fetchNearbyOrdersByLocation:(NSString *)location radius:(NSInteger)radius tags:(NSString*)tags pageIndex:(NSInteger)pageIndex  pageSize:(NSInteger)pageSize WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.map.baidu.com/geosearch/v3/nearby" parameters:@{@"ak":kBaiduAK,
                                                                              @"geotable_id":@(kBaiduGeoTableID),
                                                                              @"location":location,
                                                                              @"radius":@(radius),
                                                                              @"tags":tags,
                                                                              @"pageIndex":@(pageIndex),
                                                                              @"pageSize":@(pageSize)
                                                                              } success:completionHandler failure:failHandler];
    

}


+(void)ModifyOrderStateByID:(NSString *)ID latitude:(double)latitude longitude:(double)longitude order_state:(NSString*)order_state WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:@"http://api.map.baidu.com/geodata/v3/poi/update" parameters:@{
                                                                                @"id":ID,
                                                                                @"latitude":@(latitude),
                                                                                @"longitude":@(longitude),
                                                                                @"coord_type":@3,
                                                                                @"ak":kBaiduAK,
                                                                                @"geotable_id":@(kBaiduGeoTableID),
                                                                                @"order_state":order_state,
                                                                                @"engineer_id":[AccountManager getTokenID]
                                                                                } success:completionHandler failure:failHandler];
}



+(void)CheckOrderisOccupiedByID:(NSString*)ID WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.map.baidu.com/geodata/v3/poi/detail" parameters:@{@"ak":kBaiduAK,
                                                                              @"geotable_id":@(kBaiduGeoTableID),
                                                                              @"id":ID
                                                                              } success:completionHandler failure:failHandler];

}

+(void)BeginPayForUID:(NSString*)uid byEngineerID:(NSString *)engineer_id totalFee:(NSString *)totalFee pay_type:(NSString *)pay_type WithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSString * param = [@{@"uid":uid,@"totalfee":totalFee,@"pay_type":pay_type} bv_jsonStringWithPrettyPrint:YES];

    [manager POST:@"http://zqzh1.chinacloudapp.cn:8080/zhiKey/weixinPayController.do?wxPay" parameters:@{@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];

}

+(NetWorkOperation*)FetchOngongOrderWithcompletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestOperation *task = [manager GET:@"http://api.map.baidu.com/geodata/v3/poi/list?" parameters:@{@"ak":kBaiduAK,
                                                                                @"geotable_id":@(kBaiduGeoTableID),
                                                                                @"engineer_id":[AccountManager getTokenID],
                                                                               @"order_state":@2
                                                                                } success:completionHandler failure:failHandler];
    return task;
}

+(void)fetchCompletedOrderListByCurrentPage:(NSString*)curpage withComletionHandler:(NetWorkHandler)completionHandler failHandler:(NetWorkFailHandler)failHandler{
    
    NSString * param = [@{@"curpage":curpage,@"userID":[AccountManager getTokenID]} bv_jsonStringWithPrettyPrint:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:@"http://zqzh1.chinacloudapp.cn:8080/zhiKey/weixinPayController.do?getSubmitOrder" parameters:@{@"param":param} success:completionHandler failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self focusNetWorkError];
        failHandler(operation,error);
    }];
}


@end
