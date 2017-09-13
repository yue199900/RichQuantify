#import "CRSA.h"

#define BUFFSIZE  1024
#import "Base64.h"

#define PADDING RSA_PKCS1_PADDING
#define DocumentsDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define OpenSSLRSAKeyDir [DocumentsDir stringByAppendingPathComponent:@".openssl_rsa"]
#define RSAPublickKeyFile [DocumentsDir stringByAppendingPathComponent:@"public_key.pem"]
#define RSAPreviteKeyFile [DocumentsDir stringByAppendingPathComponent:@"private_key.pem"]
@implementation CRSA

+ (id)shareInstance
{
    static CRSA *_crsa = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _crsa = [[self alloc] init];
    });
    return _crsa;
}

- (NSString *)formattKeyStr:(NSString *)str {
    if (str == nil) {
        return @"";
    }
    NSInteger count = str.length / 64;
    NSMutableString *foKeyStr = str.mutableCopy;
    for (int i = 0; i < count; i ++) {
        [foKeyStr insertString:@"\n" atIndex:64 + (64 + 1) * i];
    }
    NSLog(@"%ld", (long)@"\n".length);
    
    return foKeyStr == nil ? @"" : foKeyStr;
}

- (void)writePukWithKey:(NSString *)keystrr {
    NSError *error = nil;
    NSString *publicKeyStr = [NSString stringWithFormat:@"-----BEGIN PUBLIC KEY-----\n%@\n-----END PUBLIC KEY-----", [self formattKeyStr:keystrr]];
    [publicKeyStr writeToFile:RSAPublickKeyFile atomically:YES encoding:NSASCIIStringEncoding error:&error];
    NSLog(@"公钥：：%@",publicKeyStr);
    NSLog(@"%@", RSAPublickKeyFile);
}

- (void)writePrkWithKey:(NSString *)keystrr {
    NSError *error = nil;
    NSString *publicKeyStr = [NSString stringWithFormat:@"-----BEGIN RSA PRIVATE KEY-----\n%@\n-----END RSA PRIVATE KEY-----", [self formattKeyStr:keystrr]];
    [publicKeyStr writeToFile:RSAPreviteKeyFile atomically:YES encoding:NSASCIIStringEncoding error:&error];
    NSLog(@"私钥：：%@", publicKeyStr);
}

- (BOOL)importRSAKeyWithType:(KeyType)type
{
    FILE *file;
    NSString *keyName = type == KeyTypePublic ? @"public_key" : @"private_key";

    NSString *keyPath = nil;
    if ([keyName isEqualToString:@"public_key"]) {
        keyPath = RSAPublickKeyFile;
    } else {
        keyPath = RSAPreviteKeyFile;
    }
//    NSString *keyPath = [[NSBundle mainBundle] pathForResource:@"scert" ofType:@"pem"];
    file = fopen([keyPath UTF8String], "rb");
    
    if (NULL != file)
    {
        if (type == KeyTypePublic)
        {
            _rsa = PEM_read_RSA_PUBKEY(file, NULL, NULL, NULL);
            assert(_rsa !=  NULL);
        }
        else
        {
            _rsa = PEM_read_RSAPrivateKey(file, NULL, NULL, NULL);
            assert(_rsa != NULL);
        }
        
        fclose(file);
        
        return (_rsa != NULL) ? YES : NO;
    }
    
    return NO;
}

- (NSString *)encryptByRsa:(NSString*)content withKeyType:(KeyType)keyType
{
    NSString *ret = [[self encryptByRsaToData:content withKeyType:keyType] base64EncodedString];
    return ret;
}

- (NSData *)encryptByRsaToData:(NSString*)content withKeyType:(KeyType)keyType {
    if (![self importRSAKeyWithType:keyType])
        return nil;
    
    int status;
    long int length  = [content length];
    unsigned char input[length + 1];
    bzero(input, length + 1);
    int i = 0;
    for (; i < length; i++)
    {
        input[i] = [content characterAtIndex:i];
    }
    
    NSInteger  flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING];
    
    char *encData = (char*)malloc(flen);
    bzero(encData, flen);
    
    switch (keyType) {
        case KeyTypePublic:
            status = RSA_public_encrypt(length, (unsigned char*)input, (unsigned char*)encData, _rsa, PADDING);
            break;
            
        default:
            status = RSA_private_encrypt(length, (unsigned char*)input, (unsigned char*)encData, _rsa, PADDING);
            break;
    }
    
    if (status)
    {
        NSData *returnData = [NSData dataWithBytes:encData length:status];
        free(encData);
        encData = NULL;
        
//        NSString *ret = [returnData base64EncodedString];
        return returnData;
    }
    
    free(encData);
    encData = NULL;
    
    return nil;
}

- (NSString *) decryptByRsa:(NSString*)content withKeyType:(KeyType)keyType
{
    if (![self importRSAKeyWithType:keyType])
        return nil;
    
    int status;
    
    NSData *data = [content base64DecodedData];
    long int length = [data length];
    
    NSInteger flen = [self getBlockSizeWithRSA_PADDING_TYPE:PADDING];
    char *decData = (char*)malloc(flen);
    bzero(decData, flen);
    
    switch (keyType) {
        case KeyTypePublic:
            status = RSA_public_decrypt(length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa, PADDING);
            break;
            
        default:
            status = RSA_private_decrypt(length, (unsigned char*)[data bytes], (unsigned char*)decData, _rsa, PADDING);
            break;
    }
    
    if (status)
    {
        NSMutableString *decryptString = [[NSMutableString alloc] initWithBytes:decData length:strlen(decData) encoding:NSASCIIStringEncoding];
        free(decData);
        decData = NULL;
        
        return decryptString;
    }
    
    free(decData);
    decData = NULL;
    
    return nil;
}

- (int)getBlockSizeWithRSA_PADDING_TYPE:(RSA_PADDING_TYPE)padding_type
{
    int len = RSA_size(_rsa);
    
    if (padding_type == RSA_PADDING_TYPE_PKCS1 || padding_type == RSA_PADDING_TYPE_SSLV23) {
        len -= 11;
    }
    
    return len;
}




@end
