#!/bin/bash

set -eu

AWS_PROFILE=$1
BIN_PATH="$(cd "$(dirname "$0")" || exit; pwd)"

REGIONS=(
  'ap-northeast-1'
  'ap-northeast-2'
  'ap-south-1'
  'ap-southeast-1'
  'ap-southeast-2'
  'ca-central-1'
  'eu-central-1'
  'eu-west-1'
  'eu-west-2'
  'eu-west-3'
  'sa-east-1'
  'us-east-1'
  'us-east-2'
  'us-west-1'
  'us-west-2'
)

PERL_VERSIONS=(
  '5.26'
  '5.28'
)

for PERL_VERSION in "${PERL_VERSIONS[@]}"; do
  ZIP="${BIN_PATH}/../lambda-layer-perl-${PERL_VERSION}.zip"
  LAYER_NAME="perl-$(echo "$PERL_VERSION" | sed -e's/[.]/_/')-layer"

  for REGION in "${REGIONS[@]}"; do
    echo "Publishing perl ${PERL_VERSION} Lambda Layer in ${REGION}..."

    VERSION=$(aws --region "$REGION" --profile "$AWS_PROFILE" lambda publish-layer-version \
      --layer-name "$LAYER_NAME" \
      --description "A lambda runtime layer of perl-${PERL_VERSION}" \
      --license-info "MIT" \
      --zip-file "fileb://${ZIP}" | jq -r .Version)
    echo "Published perl ${PERL_VERSION} Lambda Layer in ${REGION}: version ${VERSION}"

    echo "Setting public permissions on perl ${PERL_VERSION} Lambda Layer version ${VERSION} in ${REGION}..."
    aws --region "$REGION" --profile "$AWS_PROFILE" lambda add-layer-version-permission \
      --layer-name "$LAYER_NAME" \
      --version-number "$VERSION" \
      --statement-id=public \
      --action lambda:GetLayerVersion \
      --principal '*' > /dev/null
    echo "Public permissions set on perl ${PERL_VERSION} Lambda Layer version ${VERSION} in ${REGION}"
  done
done

