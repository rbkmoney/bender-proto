namespace java com.rbkmoney.bender
namespace erlang bender

include "proto/msgpack.thrift"

typedef string ExternalID
typedef string InternalID

typedef string SequenceID
typedef i64 SequenceValue

exception InternalIDNotFound {}
exception SequenceExists {}
exception SequenceNotFound {}

struct GenerationResult {
    1: required InternalID internal_id
    2: optional msgpack.Value context
}

struct GetInternalIDResult {
    1: required InternalID internal_id
    2: required msgpack.Value context
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
    1: required SequenceID    sequence_id
    2: optional SequenceValue minimum
}

service Bender {

    GenerationResult GenerateID (1: ExternalID external_id, 2: GenerationSchema schema, 3: msgpack.Value context)

    GetInternalIDResult GetInternalID (1: ExternalID external_id)
        throws (1: InternalIDNotFound ex1)

    void CreateSequence(1: SequenceID sequence_id)
        throws (1: SequenceExists ex1)
    SequenceValue GetSequenceValue(1: SequenceID sequence_id)
        throws (1: SequenceNotFound ex1)
    void SetSequenceValue(1: SequenceID sequence_id, 2: SequenceValue value)
        throws (1: SequenceNotFound ex1)

}
