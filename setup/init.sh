#!/bin/bash
set -e -o pipefail

echo "Fetching active IAM identity ARN..."
USER_ARN=$(aws sts get-caller-identity --query 'Arn' --output text)

echo "Active IAM Identity: ${USER_ARN}"

# Verify cluster connectivity
kubectl cluster-info

echo "Done!"