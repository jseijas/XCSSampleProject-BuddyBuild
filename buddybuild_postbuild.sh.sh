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
   PROJECT_ID=99662668
echo "Project ID: ${PROJECT_ID}"

fi

if [ -z ${PROJECT_ID} ]; then
         echo "Project ID not found"
exit
fi



if [ -z ${APP_FILE} ]; then
#APP_FILE=/Users/hchukwuji/Documents/workspace/testdroid-demo/appium-client-side-suit/appium-java-ios-local-testdroid-cloud/src/app/BitbarIOSSample.ipa
APP_FILE=BUDDYBUILD_IPA_PATH

fi


if [ -z "$BUILD_NUMBER" ]; then
BUILD_NUMBER=build_number

fi

if [ -z "$DEVICE_GROUP_NAME" ]; then
DEVICE_GROUP_NAME=iOS-tip-device1

fi

curl \
-F "file=@$BUDDYBUILD_IPA_PATH" \
-F "build_number=$BUDDYBUILD_BUILD_NUMBER"


# Check that Device Group exists
echo "DEVICE_GROUP_NAME: ${DEVICE_GROUP_NAME}"
DEVICE_GROUP_ID="$(curl -G -s -H "Accept: application/json" -u ${TESTDROID_APIKEY}: "${API_ENDPOINT}/api/v2/me/device-groups?withPublic=true" --data-urlencode "limit=1" --data-urlencode "search=${DEVICE_GROUP_NAME}" | python -m json.tool | sed -n -e '/"id":/ s/^.* \(.*\),.*/\1/p')"
echo "DEVICE_GROUP_ID: ${DEVICE_GROUP_ID}"

if [ -z ${DEVICE_GROUP_ID} ]; then

echo "No DEVICE_GROUP_ID found; Device group with name \"${DEVICE_GROUP_NAME}\" doesn't seem to exist."
exit
fi


#if [ -z ${DEVICE_GROUP_ID} ]; then
#DEVICE_GROUP_ID=22225
#exit
#else
#echo "Device Id not found"
#exit
#fi


curl -H "Accept: application/json" -u ${TESTDROID_APIKEY}: -X POST -F "file=@${APP_FILE}" "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/files/application"


echo "Uploaded IPA file"


#Create test run

#TESTRUN_ID="$(curl -s -H "Accept: application/json" -u ${TESTDROID_APIKEY}: -X POST "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/runs/device-groups/${DEVICE_GROUP_ID}")"

#DEVICE_GROUP_ID=22225

# Test run
echo "launching test"
#TESTRUN_ID="$(curl -s -H "Accept: application/json" -u ${TESTDROID_APIKEY}: -X POST "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/runs?usedDeviceGroupId=$#{DEVICE_GROUP_ID}" | python -m json.tool | sed -n -e '/"id":/ s/^.* \(.*\),.*/\1/p')"

#echo "Test run Id: ${TESTRUN_ID}"


TESTRUN="$(curl -s -H "Accept: application/json" -u ${TESTDROID_APIKEY}: -X POST "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/runs/?usedDeviceGroupId=${DEVICE_GROUP_ID}")"

#TESTRUN="$(curl -s -H "Accept: application/json" -u ${TESTDROID_APIKEY}: -X POST/api/v2/me/projects/${PROJECT_ID}/runs"
echo "Test run: ${TESTRUN}"



#TESTRUN_ID="$(curl -s -H "Accept: application/json" -u ${TESTDROID_APIKEY}: -X POST "${API_ENDPOINT}/api/v2/me/projects/${PROJECT_ID}/runs/TESTRUN_ID/start/#usedDeviceGroupId=${DEVICE_GROUP_ID}" | python -m json.tool | sed -n -e '/"id":/ s/^.* \(.*\),.*/\1/p')"