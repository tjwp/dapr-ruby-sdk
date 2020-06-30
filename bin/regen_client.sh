#!/usr/bin/env zsh

bindir="$(dirname "$0")"

cd "$bindir/.."

echo "Regenerating from protos ... "
set -ex

bundle exec grpc_tools_ruby_protoc -I . --ruby_out=lib --grpc_out=lib dapr/proto/common/v1/common.proto
bundle exec grpc_tools_ruby_protoc -I . --ruby_out=lib --grpc_out=lib dapr/proto/runtime/v1/dapr.proto
bundle exec grpc_tools_ruby_protoc -I . --ruby_out=lib --grpc_out=lib dapr/proto/runtime/v1/appcallback.proto

set +x
echo "Done."