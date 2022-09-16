#coding=utf-8

import sys
from qiniu import Auth, put_file, etag, CdnManager
import qiniu.config

def uploadToQiNiu(key, localfile):
    print(key);
    print(localfile);
    # 需要填写你的 Access Key 和 Secret Key
    access_key = 'livk5rb3__JZjCtEiMxXpQ8QscLxbNLehwhHySnX'
    secret_key = 'ysrYdcDrrF425QNz0pfY9RoafANC6Hni3TIVgjw5'
    # 要上传的空间
    bucket_name = 'rongcloud-sdk'
    # 构建鉴权对象
    q = Auth(access_key, secret_key)
    # 生成上传 Token，可以指定过期时间等
    token = q.upload_token(bucket_name, key, 3600)
    ret, info = put_file(token, key, localfile)
    print(info)
    assert ret['key'] == key
    assert ret['hash'] == etag(localfile)
    

def refreshResource(urls):
    # 账户ak，sk
    access_key = 'livk5rb3__JZjCtEiMxXpQ8QscLxbNLehwhHySnX'
    secret_key = 'ysrYdcDrrF425QNz0pfY9RoafANC6Hni3TIVgjw5'
    auth = qiniu.Auth(access_key=access_key, secret_key=secret_key)
    cdn_manager = CdnManager(auth)
    # # 需要刷新的文件链接
    # urls = [
    #     'https://downloads.rongcloud.cn/' + key
    # ]
    # 刷新链接
    refresh_url_result = cdn_manager.refresh_urls(urls)
    print(refresh_url_result)
    

if __name__ == '__main__':
    fileName=sys.argv[1]
    filePath=sys.argv[2]
    print('upload ' + fileName + ' start:')
    uploadToQiNiu(fileName,filePath)
    print('upload ' + fileName + ' end.')
    refresh_sdk_urls = []
    refresh_sdk_urls.append('https://downloads.rongcloud.cn/' + fileName)
    print("refresh urls start.")
    refreshResource(refresh_sdk_urls)
    print("refresh urls end.")