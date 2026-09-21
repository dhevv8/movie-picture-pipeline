#!/bin/bash
set -e -o pipefail

echo "Fetching active IAM identity ARN"
userarn=$(aws sts get-caller-identity --query 'Arn' --output text)

# Download tool for manipulating aws-auth
echo "Downloading tool..."
curl -X GET -L https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.6.2/aws-iam-authenticator_0.6.2_linux_amd64 -o aws-iam-authenticator
chmod +x aws-iam-authenticator

echo "Updating permissions"
./aws-iam-authenticator add user --userarn="${userarn}" --username=github-action-role --groups=system:masters --kubeconfig="$HOME"/.kube/config --prompt=false

echo "Cleaning up"
rm aws-iam-authenticator
echo "Done!"