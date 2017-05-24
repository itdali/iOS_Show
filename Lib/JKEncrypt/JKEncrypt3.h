//
//  JKEncrypt3.h
//  一起
//
//  Created by wangbl on 16/3/15.
//  Copyright © 2016年 wangbl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKEncrypt3 : NSObject

/**字符串加密 */
-(NSString *)doEncryptStr:(NSString *)originalStr;
/**字符串解密 */
-(NSString*)doDecEncryptStr:(NSString *)encryptStr;
/**十六进制解密 */
-(NSString *)doEncryptHex:(NSString *)originalStr;
/**十六进制加密 */
-(NSString*)doDecEncryptHex:(NSString *)encryptStr;

@end

