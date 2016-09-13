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
    read -p "Testdroid API-Key: " TESTDROID_APIKEY
else
    TESTDROID_APIKEY=$1
fi

if [ -z ${PROJECT_ID} ]; then
   read -p "Testdroid Project-ID: " PROJECT_ID
else
    PROJECT_ID
fi

if [ -z ${PROJECT_ID} ]; then
         echo "Project ID not found"
exit 1i:
fi

if [ -z ${APP_FILE} ]; then
    read -p "Give the app path: " APP_FILE
else
    APP_FILE
fi


if [ -z ${DEVICE_GROUP_NAME} ]; then
read -p "Give the device group: " DEVICE_GROUP_NAME
else
DEVICE_GROUP_NAME
fi

curl -H "Accept: application/json" -u ${TESTDROID_APIKEY}: -X POST -F "file=@${APP_FILE}" "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/files/application"

echo "Uploaded IPA file"


# Check that Device Group exists
echo "DEVICE_GROUP_NAME: ${DEVICE_GROUP_NAME}"
DEVICE_GROUP_ID="$(curl -G -s -H "Accept: application/json" -u ${API_KEY}: "${API_ENDPOINT}/api/v2/me/device-groups?withPublic=true" --data-urlencode "limit=1" --data-urlencode "search=${DEVICE_GROUP_NAME}" | python -m json.tool | sed -n -e '/"id":/ s/^.* \(.*\),.*/\1/p')"
echo "DEVICE_GROUP_ID: ${DEVICE_GROUP_ID}"
if [ -z ${DEVICE_GROUP_ID} ]; then
echo "No DEVICE_GROUP_ID found; Device group with name \"${DEVICE_GROUP_NAME}\" doesn't seem to exist."
exit
fi

# Test run
echo "launching test"
TESTRUN_ID="$(curl -s -H "Accept: application/json" -u ${API_KEY}: -X POST "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/runs?usedDeviceGroupId=${DEVICE_GROUP_ID}" | python -m json.tool | sed -n -e '/"id":/ s/^.* \(.*\),.*/\1/p')"



#curl -X POST -H "Authorization: Bearer $BUDDYBUILD_TOKEN" "https://api.buddybuild.com/v1/apps/$BUDDYBUILD_APPID/build"

