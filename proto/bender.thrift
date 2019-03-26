namespace java com.rbkmoney.bender
namespace erlang bender

include "../deps/msgpack/proto/msgpack.thrift"

typedef string ExternalID
typedef string InternalID

struct GenerationResult {
    1: required InternalID internal_id
    2: optional msgpack.Value context
}

union GenerationSchema {
    1: SnowflakeSchema snowflake
    2: ConstantSchema constant
    3: SequenceSchema sequence
}

struct SnowflakeSchema {
}

struct ConstantSchema {
    1: required InternalID internal_id
}

struct SequenceSchema {
    1: required string sequence_id
}

service Bender {

    GenerationResult GenerateID (1: ExternalID external_id, 2: GenerationSchema schema, 3: msgpack.Value context)

}
