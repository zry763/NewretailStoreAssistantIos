//
//  ThreeDES.m
//  TaiHeToolKit
//
//  Created by 陆佳峰 on 8/6/15.
//  Copyright (c) 2015 TaiHe. All rights reserved.
//

#import "TRCThreeDES.h"
#import "TRCBase64.h"
#import <CommonCrypto/CommonCryptor.h>

/**
 *  ThreeDES默认秘钥
 */
#define SECRET_KEY @"1234567876aec5433445665"

#define DES_VECTOR          @"4b5e6992"

#define gkey			@"NSUTF8StringEnco" //自行修改
#define gIv             @"" //自行修改


@interface TRCThreeDES ()

/**
 *  ThreeDES加解密
 *
 *  plainText        加密前的明文或者需要解密的密文
 *  encryptOrDecrypt 加密或者解密选项
 *  key              秘钥
 *
 *  加密或者解密结果
 */
+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;

@end


@implementation TRCThreeDES

#pragma mark - Class Methods
#pragma mark 对字符串进行3DES加密
+ (NSString *)encryptString:(NSString *)string {
    
    return [TRCThreeDES tripleDES:string encryptOrDecrypt:kCCEncrypt key:SECRET_KEY];
}


#pragma mark 对字符串进行3DES解密
+ (NSString *)decryptString:(NSString *)string {
    
    return [TRCThreeDES tripleDES:string encryptOrDecrypt:kCCDecrypt key:SECRET_KEY];
}




#pragma mark 对字符串进行3DES加密
+ (NSString *)AES128Encrypt:(NSString *)plainText
{
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 1;
    
    if(diff > 0) {
        newSize = (int)dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [TRCBase64 stringByEncodingData:resultData];
    }
    free(buffer);
    return nil;
}


#pragma mark 对字符串进行3DES解密
+ (NSString *)AES128Decrypt:(NSString *)encryptText
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [gkey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [TRCBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}



#pragma mark - Private Methods
#pragma mark 3DES加解密
+ (NSString *)tripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key {
    
    const void * vplainText;
    size_t plainTextBufferSize;
    NSData * base64Data;
    
    if (encryptOrDecrypt == kCCDecrypt) {
        
        base64Data = [TRCBase64 decodeString:plainText];
        plainTextBufferSize = [base64Data length];
        vplainText = [base64Data bytes];
        
    } else {
        
        base64Data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [base64Data length];
        vplainText = (const void *)[base64Data bytes];
    }
    
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    NSString * initVec = DES_VECTOR;
    const void * vkey = (const void *) [key UTF8String];
    const void * vinitVec = (const void *) [initVec UTF8String];
    
    
    CCCrypt(encryptOrDecrypt,
            kCCAlgorithm3DES,
            kCCOptionPKCS7Padding,
            vkey,
            kCCKeySize3DES,
            vinitVec,
            vplainText,
            plainTextBufferSize,
            (void *)bufferPtr,
            bufferPtrSize,
            &movedBytes);
    
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
        
        //NSLog(@"decrypted result %@",result);
        
    } else {
        
        NSData * myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [TRCBase64 stringByEncodingData:myData];
    }
    
    //NSLog(@"decrypted result %@",result);
    free(bufferPtr);
    
    return result;
}


@end
