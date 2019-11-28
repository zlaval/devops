REM Params: topicname, message_type_class, message (escape " with \")

docker exec -it kafka java -jar avro-kafka-producer.jar "hu-telekom-jazz-Product" "hu.telekom.message.jazz.contract.Contract" "{\"source\":\"JAZZ\",\"version\":\"1\",\"timestamp\":\"2019-11-12T20:41:22Z\",\"event_type_code\":\"CONTRACT_CREATE\",\"event_type\":\"CONTRACT_CREATE\",\"context\":{\"producer\":\"n/a\",\"message_id\":\"\",\"correlation_id\":\"TODO:generateuuid\",\"timestamp\":1573551291456},\"event_data\":{\"contract_number\":\"20107425\",\"contract_legacy_id\":\"1771126914\",\"account_number\":\"12764640\",\"account_legacy_id\":\"1783988373\",\"contract_level\":\"NORMAL\",\"contract_type_code\":\"GSM\",\"service_code\":\"asdfgh\",\"status\":\"ACTIVE\",\"agreements\":[],\"created_at\":\"2018-11-26T13:14:08Z\",\"updated_at\":\"2019-02-26T16:03:35Z\",\"first_activation_date\":\"2018-11-26T13:20:18Z\",\"tariffs\":{\"rateplan_code\":\"HangS\",\"rateplan_legacy_id\":\"1754777075\",\"epc_entity_id\":\"126bfef7-6daf-47dc-b12d-a78e9aa5543d\",\"effective_date\":\"2018-11-26T13:20:18Z\",\"tariff_end_date\":\"\"},\"roaming_tariff\":{\"rateplan_code\":\"ROADEF\",\"rateplan_legacy_id\":\"80\",\"epc_entity_id\":\"\",\"effective_date\":\"2018-11-26T13:20:18Z\",\"tariff_end_date\":\"\"},\"contracted_services\":[{\"code\":\"MOBIL\",\"legacy_id\":\"1\",\"contracted_service_id\":\"2414039685\",\"contracted_service_seq\":\"2414039685\",\"epc_entity_id\":\"?\",\"status\":\"ACTIVE\",\"effective_date\":\"2018-11-26T13:14:08Z\",\"expiration_date\":\"\",\"params\":[]}],\"devices\":[{\"legacy_id\":\"1758115372\",\"status\":\"ACTIVE\",\"contracted_service_ref\":\"?\",\"type_name\":\"Msisdn\",\"device_number\":\"306298016\"},{\"legacy_id\":\"1778879272\",\"status\":\"ACTIVE\",\"contracted_service_ref\":\"?\",\"type_name\":\"Sim\",\"device_number\":\"8936303418091249321F\"}],\"products\":[],\"discounts\":[{\"legacy_id\":\"1754488496\",\"discount_code\":\"RXBUSNETActiv\",\"status\":\"ACTIVE\",\"effective_date\":\"\"},{\"legacy_id\":\"1754536720\",\"discount_code\":\"MhS+Net3GB12\",\"status\":\"ACTIVE\",\"effective_date\":\"\"}]}}"