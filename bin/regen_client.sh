#!/usr/bin/env zsh

bindir="$(dirname "$0")"

cd "$bindir/.."

echo "Regenerating from protos ... "
set -ex

bundle exec grpc_tools_ruby_protoc -I . --ruby_out=lib --grpc_out=lib dapr/proto/common/v1/common.proto
bundle exec grpc_tools_ruby_protoc -I . --ruby_out=lib --grpc_out=lib dapr/proto/runtime/v1/dapr.proto
bundle exec grpc_tools_ruby_protoc -I . --ruby_out=lib --grpc_out=lib dapr/proto/runtime/v1/appcallback.proto

# Prefix top-level Dapr constant in dapr_services_pb
dapr_services="lib/dapr/proto/runtime/v1/dapr_services_pb.rb"
mv $dapr_services ${dapr_services}.tmp
cat ${dapr_services}.tmp | sed -e "s/ Dapr::Proto/ ::Dapr::Proto/" > $dapr_services
rm ${dapr_services}.tmp

set +x
echo "Done."