namespace java com.rbkmoney.bender
namespace erlang bender

typedef string ExternalID

typedef string InternalID

exception AlreadyExists {
    1: required InternalID internal_id
}

service Bender {

    void Bind (1: ExternalID external_id, 2: InternalID internal_id)
        throws (
            1: AlreadyExists ex1
        )

}