#!/bin/bash

sudo tee << EOF /etc/swift/swift.conf
[swift-hash]

# swift_hash_path_suffix and swift_hash_path_prefix are used as part of the
# the hashing algorithm when determining data placement in the cluster.
# These values should remain secret and MUST NOT change
# once a cluster has been deployed.

swift_hash_path_suffix = password
swift_hash_path_prefix = password

# storage policies are defined here and determine various characteristics
# about how objects are stored and treated.  Policies are specified by name on
# a per container basis.  Names are case-insensitive.  The policy index is
# specified in the section header and is used internally.  The policy with
# index 0 is always used for legacy containers and can be given a name for use
# in metadata however the ring file name will always be 'object.ring.gz' for
# backwards compatibility.  If no policies are defined a policy with index 0
# will be automatically created for backwards compatibility and given the name
# Policy-0.  A default policy is used when creating new containers when no
# policy is specified in the request.  If no other policies are defined the
# policy with index 0 will be declared the default.  If multiple policies are
# defined you must define a policy with index 0 and you must specify a
# default.  It is recommended you always define a section for
# storage-policy:0.
#
# A 'policy_type' argument is also supported but is not mandatory.  Default
# policy type 'replication' is used when 'policy_type' is unspecified.
[storage-policy:0]
name = Policy-0
default = yes
#policy_type = replication

# the following section would declare a policy called 'silver', the number of
# replicas will be determined by how the ring is built.  In this example the
# 'silver' policy could have a lower or higher # of replicas than the
# 'Policy-0' policy above.  The ring filename will be 'object-1.ring.gz'.  You
# may only specify one storage policy section as the default.  If you changed
# this section to specify 'silver' as the default, when a client created a new
# container w/o a policy specified, it will get the 'silver' policy because
# this config has specified it as the default.  However if a legacy container
# (one created with a pre-policy version of swift) is accessed, it is known
# implicitly to be assigned to the policy with index 0 as opposed to the
# current default.
#[storage-policy:1]
#name = silver
#policy_type = replication

# The following declares a storage policy of type 'erasure_coding' which uses
# Erasure Coding for data reliability.  The 'erasure_coding' storage policy in
# Swift is available as a "beta".  Please refer to Swift documentation for
# details on how the 'erasure_coding' storage policy is implemented.
#
# Swift uses PyECLib, a Python Erasure coding API library, for encode/decode
# operations.  Please refer to Swift documentation for details on how to
# install PyECLib.
#
# When defining an EC policy, 'policy_type' needs to be 'erasure_coding' and
# EC configuration parameters 'ec_type', 'ec_num_data_fragments' and
# 'ec_num_parity_fragments' must be specified.  'ec_type' is chosen from the
# list of EC backends supported by PyECLib.  The ring configured for the
# storage policy must have it's "replica" count configured to
# 'ec_num_data_fragments' + 'ec_num_parity_fragments' - this requirement is
# validated when services start.  'ec_object_segment_size' is the amount of
# data that will be buffered up before feeding a segment into the
# encoder/decoder.  More information about these configuration options and
# supported `ec_type` schemes is available in the Swift documentation.  Please
# refer to Swift documentation for details on how to configure EC policies.
#
# The example 'deepfreeze10-4' policy defined below is a _sample_
# configuration with 10 'data' and 4 'parity' fragments. 'ec_type'
# defines the Erasure Coding scheme. 'jerasure_rs_vand' (Reed-Solomon
# Vandermonde) is used as an example below.
#
#[storage-policy:2]
#name = deepfreeze10-4
#policy_type = erasure_coding
#ec_type = jerasure_rs_vand
#ec_num_data_fragments = 10
#ec_num_parity_fragments = 4
#ec_object_segment_size = 1048576


# The swift-constraints section sets the basic constraints on data
# saved in the swift cluster. These constraints are automatically
# published by the proxy server in responses to /info requests.

[swift-constraints]

# max_file_size is the largest "normal" object that can be saved in
# the cluster. This is also the limit on the size of each segment of
# a "large" object when using the large object manifest support.
# This value is set in bytes. Setting it to lower than 1MiB will cause
# some tests to fail. It is STRONGLY recommended to leave this value at
# the default (5 * 2**30 + 2).

#max_file_size = 5368709122


# max_meta_name_length is the max number of bytes in the utf8 encoding
# of the name portion of a metadata header.

#max_meta_name_length = 128


# max_meta_value_length is the max number of bytes in the utf8 encoding
# of a metadata value

#max_meta_value_length = 256


# max_meta_count is the max number of metadata keys that can be stored
# on a single account, container, or object

#max_meta_count = 90


# max_meta_overall_size is the max number of bytes in the utf8 encoding
# of the metadata (keys + values)

#max_meta_overall_size = 4096

# max_header_size is the max number of bytes in the utf8 encoding of each
# header. Using 8192 as default because eventlet use 8192 as max size of
# header line. This value may need to be increased when using identity
# v3 API tokens including more than 7 catalog entries.
# See also include_service_catalog in proxy-server.conf-sample
# (documented in overview_auth.rst)

#max_header_size = 8192


# By default the maximum number of allowed headers depends on the number of max
# allowed metadata settings plus a default value of 32 for regular http
# headers.  If for some reason this is not enough (custom middleware for
# example) it can be increased with the extra_header_count constraint.

#extra_header_count = 0


# max_object_name_length is the max number of bytes in the utf8 encoding
# of an object name

#max_object_name_length = 1024


# container_listing_limit is the default (and max) number of items
# returned for a container listing request

#container_listing_limit = 10000


# account_listing_limit is the default (and max) number of items returned
# for an account listing request
#account_listing_limit = 10000


# max_account_name_length is the max number of bytes in the utf8 encoding
# of an account name

#max_account_name_length = 256


# max_container_name_length is the max number of bytes in the utf8 encoding
# of a container name

#max_container_name_length = 256


# By default all REST API calls should use "v1" or "v1.0" as the version string,
# for example "/v1/account". This can be manually overridden to make this
# backward-compatible, in case a different version string has been used before.
# Use a comma-separated list in case of multiple allowed versions, for example
# valid_api_versions = v0,v1,v2
# This is only enforced for account, container and object requests. The allowed
# api versions are by default excluded from /info.

# valid_api_versions = v1,v1.0

EOF

sudo chown -R swift:swift /etc/swift
