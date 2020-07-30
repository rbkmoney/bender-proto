namespace java com.rbkmoney.transbender
namespace erlang transbender

include "proto/msgpack.thrift"

union ExternalID {
    1: string as_string
    2: i64    as_integer
}

union InternalID {
    1: string as_string
    2: i64    as_integer
}

union SequenceID {
    1: string as_string
    2: i64    as_integer
}

exception InternalIDNotFound { }
exception InvalidSequenceResultType {
    1: ResultType expected
}

struct GenerationResult {
    1: required InternalID internal_id
    2: optional msgpack.Value context
}

union GenerationSchema {
    1: SnowflakeSchema snowflake
    2: ConstantSchema  constant
    3: SequenceSchema  sequence
}

struct SnowflakeSchema { }

struct ConstantSchema {
    1: required InternalID internal_id
}

struct SequenceSchema {
    1: required SequenceID sequence_id
    2: optional ResultType result_type
    3: optional i64        minimum
}

struct GetInternalIDResult {
    1: required InternalID internal_id
    2: required msgpack.Value context
}

union ResultType {
    1: AsString  as_string
    2: AsInteger as_integer
}
struct AsInteger { }
struct AsString  { }

service Transbender {

    GenerationResult GenerateID (
        1: ExternalID external_id,
        2: GenerationSchema schema,
        3: msgpack.Value context,
    )
        throws (1: InvalidSequenceResultType ex1)

    GetInternalIDResult GetInternalID (
        1: ExternalID external_id
    )
        throws (1: InternalIDNotFound ex1)
}
