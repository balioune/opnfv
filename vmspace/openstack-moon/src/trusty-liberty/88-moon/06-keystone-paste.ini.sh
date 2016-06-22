#!/usr/bin/env bash


sudo cp /etc/keystone/keystone-paste.ini /etc/keystone/keystone-paste.ini.bak
sudo sed "3i[pipeline:moon_pipeline]\npipeline = sizelimit url_normalize request_id build_auth_context token_auth admin_token_auth json_body ec2_extension_v3 s3_extension simple_cert_extension revoke_extension federation_extension oauth1_extension endpoint_filter_extension moon_service\n\n[app:moon_service]\nuse = egg:keystone#moon_service\n" /etc/keystone/keystone-paste.ini > /tmp/keystone-paste.ini
sudo cp /tmp/keystone-paste.ini /etc/keystone/keystone-paste.ini

sudo sed "s/use = egg:Paste#urlmap/use = egg:Paste#urlmap\n\/moon = moon_pipeline/" /etc/keystone/keystone-paste.ini > /tmp/keystone-paste.ini
sudo cp /tmp/keystone-paste.ini /etc/keystone/keystone-paste.ini

