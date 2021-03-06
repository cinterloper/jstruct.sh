#!/bin/bash
# this is an example of a semi-native json encoder and decoder for bash
# to encode json, set KEY_SET to a list of env var keys
# to decode json, set JSON_STRING to the payload, then call decodeJson. the keys in the string will become the keys in the enviornment


#require luabash
luabash load ./jstruct.lua
#defaults to JSON_STRING, but you can pass the name of a custom var to decode
decodeJson() {
  JSON_VAR=$1
  if [ "$JSON_VAR" == "" ]
  then
    JSON_VAR="JSON_STRING"
  fi
  if [ "$DECODE_SILENT" != "" ]
  then
    l_decodeJson $JSON_VAR > /dev/null
  else
    l_decodeJson $JSON_VAR
  fi
}
jsonEach() {
  eachFN="$2"
  if [ "$eachFN" == "" ]
  then
    JSON_VAR="JSON_STRING"
    eachFN="$1"
  else
    JSON_VAR="$1"
  fi

  if [ "$EACH_SILENT" != "" ]
  then
    l_jsonEach "$JSON_VAR" "$eachFN" > /dev/null
  else
    l_jsonEach "$JSON_VAR" "$eachFN"
  fi
}

getJsonValue() {
  JSON_PATH="$1"
  if [ "$JSON_VAR" == "" ]
  then
    JSON_VAR="JSON_STRING"
  fi
  l_getJsonValue $JSON_PATH
}
clearDecode() {
  if [ "$DECODE_KEYS" != "" ]
  then
    for dk in $DECODE_KEYS
    do
      unset $dk
    done
  fi
}

#you can pipe to this, or set KEY_SET
encodeJson() {
  if [ "$KEY_SET" == "" ]
  then
    while read KEY; do
      KEY_SET="$KEY_SET $KEY"
    done
    l_encodeJson
  else
    l_encodeJson
  fi
}
mergeJson() {
  if [ "$KEY_SET" == "" ]
  then
    while read KEY; do
      KEY_SET="$KEY_SET $KEY"
    done
    l_mergeJson
  else
    l_mergeJson
  fi
}
encodeJsonArray(){
  l_encodeJsonArray
}

export JSTRUCT_VERSION='1.0'
export JSON_BASH_VERSION='1.0'

