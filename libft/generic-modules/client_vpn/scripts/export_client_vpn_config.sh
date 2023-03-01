#!/usr/bin/env bash
set -x

aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id $CLIENT_VPN_ID --output text --region=$VPN_REGION > $FULL_CLIENT_CERTIFICATE_NAME.ovpn