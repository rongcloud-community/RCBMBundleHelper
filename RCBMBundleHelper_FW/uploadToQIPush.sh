#!/bin/sh

IMSDK_ORIGIN_NAME="RCBMBundleHelper.zip"
IMSDK_FINAL_NAME="RCBMBundleHelper_v1_0_1.zip"

# 获取脚本所在的目录
ScriptDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 

cd ${ScriptDIR}

function uploadToQINIU() {
	fileNameOrigin=$1
	fileNameFinal=$2
	if [[ -e "./${fileNameOrigin}" ]]; then
		mv ./${fileNameOrigin} ./${fileNameFinal}
		python3 upload_qiniu.py ${fileNameFinal} ./${fileNameFinal}
		# 上传成功后删除资源
#		rm ./${fileNameFinal}
	else
		echo "缺少 ${fileNameOrigin} 资源包"
		exit 1
	fi
}


# 资源包上传至七牛
uploadToQINIU ${IMSDK_ORIGIN_NAME} ${IMSDK_FINAL_NAME}	