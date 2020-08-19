#!/usr/bin/env bash
# Creates an .env from ENV variables for use with react-native-config
ENV_WHITELIST=${ENV_WHITELIST:-"^RN_"}
printf "Creating an .env file with the following whitelist:\n"
printf "%s\n" $ENV_WHITELIST
set | egrep -e $ENV_WHITELIST | sed 's/^RN_//g' > .env
printf "\n.env created with contents:\n\n"

cat .env

echo "Injecting secrets..."

GOOGLE_JSON_FILE=$APPCENTER_SOURCE_DIRECTORY/android/app/google-services.json

if [ -e "$GOOGLE_JSON_FILE" ]
then
    echo "Updating Google Json"
    echo $RN_GOOGLE_SERVICES_JSON | base64 --decode > $GOOGLE_JSON_FILE
    sed -i -e 's/\\"/'\"'/g' $GOOGLE_JSON_FILE

    echo "File content:"
    echo "$RN_GOOGLE_SERVICES_JSON"
    cat $GOOGLE_JSON_FILE
fi

