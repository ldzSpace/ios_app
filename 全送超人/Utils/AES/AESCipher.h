//
//  AESCipher.h
//  全送超人
//
//  Created by admin on 2018/11/7.
//  Copyright © 2018年 com.youchao.kak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//二次封装加解密，用下面这俩
NSString * aesEncrypt(NSString *content);
NSDictionary * aesDecryptWithData(NSData *content);

NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSString *content, NSString *key);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);


NS_ASSUME_NONNULL_END
