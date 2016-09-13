#!/bin/sh

#  upload.sh
#  XCSTutorialProject1
#
#  Created by Hilary Chukwuji on 12/09/16.
#  Copyright (c) 2016 Honza Dvorsky. All rights reserved.


echo "uploading IPA file"

if [ -z ${API_ENDPOINT} ]; then
API_ENDPOINT=https://cloud.testdroid.com
fi

if [ -z "$1" ]; then
    read -p "Testdroid API-Key: " API_KEY
else
    API_KEY=$1
fi


curl -H "Accept: application/json" -u ${API_KEY}: -X POST -F "file=@${APP_FILE}" "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/files/application"

#curl -X POST -H "Authorization: Bearer $BUDDYBUILD_TOKEN" "https://api.buddybuild.com/v1/apps/$BUDDYBUILD_APPID/build"

echo "Uploaded IPA file"