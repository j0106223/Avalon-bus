#include "terasic_os.h"
#include <unistd.h>
extern "C" {
#include <bluetooth/bluetooth.h>
#include <bluetooth/sdp.h>
#include <bluetooth/sdp_lib.h>
#include <bluetooth/rfcomm.h>
#include "BtSpp.h"
}

#define MY_RF_CHANNEL 22

CBtSpp::CBtSpp():
	m_socket(0),
	m_client(0),
	m_sdp_session(NULL)
	{

}

CBtSpp::~CBtSpp() {
	// TODO Auto-generated destructor stub
	RfcommClose();
	UnregisterService();
}


void CBtSpp::RegisterService(void){
    uint8_t svc_uuid_int[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0xab, 0xcd };
    uint8_t rfcomm_channel = MY_RF_CHANNEL ;
    const char *service_name = "Terasic RFCOMM";
    const char *svc_dsc = "Terasic RFCOMM";
    const char *service_prov = "Terasic RFCOMM";
    const bdaddr_t my_any_addr={{0,0,0,0,0,0}};
    const bdaddr_t my_local_addr={{0,0,0,0xff,0xff,0xff}};


    uuid_t root_uuid, l2cap_uuid, rfcomm_uuid, svc_uuid, svc_class_uuid;

    sdp_list_t *l2cap_list = 0,
               *rfcomm_list = 0,
               *root_list = 0,
               *proto_list = 0,
               *access_proto_list = 0,
               *svc_class_list = 0,
               *profile_list = 0;
    sdp_data_t *channel = 0;
    sdp_profile_desc_t profile;
    sdp_record_t record = { 0 };
    sdp_session_t *session = 0;

    UnregisterService();

    // set the general service ID
    sdp_uuid128_create( &svc_uuid, &svc_uuid_int );

    sdp_set_service_id( &record, svc_uuid );


    // set the service class
    sdp_uuid16_create(&svc_class_uuid, SERIAL_PORT_SVCLASS_ID);
    svc_class_list = sdp_list_append(0, &svc_class_uuid);
    sdp_set_service_classes(&record, svc_class_list);

    // set the Bluetooth profile information
    sdp_uuid16_create(&profile.uuid, SERIAL_PORT_PROFILE_ID);
    profile.version = 0x0100;
    profile_list = sdp_list_append(0, &profile);
    sdp_set_profile_descs(&record, profile_list);

    // make the service record publicly browsable
    sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
    root_list = sdp_list_append(0, &root_uuid);
    sdp_set_browse_groups( &record, root_list );

    // set l2cap information
    sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
    l2cap_list = sdp_list_append( 0, &l2cap_uuid );
    proto_list = sdp_list_append( 0, l2cap_list );

    // register the RFCOMM channel for RFCOMM sockets
    sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
    channel = sdp_data_alloc(SDP_UINT8, &rfcomm_channel);
    rfcomm_list = sdp_list_append( 0, &rfcomm_uuid );
    sdp_list_append( rfcomm_list, channel );
    sdp_list_append( proto_list, rfcomm_list );

    access_proto_list = sdp_list_append( 0, proto_list );
    sdp_set_access_protos( &record, access_proto_list );

    // set the name, provider, and description
    sdp_set_info_attr(&record, service_name, service_prov, svc_dsc);

    // connect to the local SDP server, register the service record,
    // and disconnect
//    session = sdp_connect(BDADDR_ANY, BDADDR_LOCAL, SDP_RETRY_IF_BUSY);
    session = sdp_connect(&my_any_addr, &my_local_addr, SDP_RETRY_IF_BUSY);

    sdp_record_register(session, &record, 0);

    // cleanup
    sdp_data_free( channel );
    sdp_list_free( l2cap_list, 0 );
    sdp_list_free( rfcomm_list, 0 );
    sdp_list_free( root_list, 0 );
    sdp_list_free( access_proto_list, 0 );
    sdp_list_free( svc_class_list, 0 );
    sdp_list_free( profile_list, 0 );

    m_sdp_session = session;



}

void CBtSpp::UnregisterService(void){
	if (m_sdp_session){
		sdp_close( m_sdp_session );
		m_sdp_session = 0;
	}
}

void CBtSpp::RfcommOpen(void){
    struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
    char buf[1024] = { 0 };
    int s, client;//, bytes_read;
    unsigned int opt = sizeof(rem_addr);

    // allocate socket
    s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // bind socket to port 1 of the first available bluetooth adapter
    loc_addr.rc_family = AF_BLUETOOTH;
    bdaddr_t tmp = { };
    bacpy(&loc_addr.rc_bdaddr, &tmp);

    //loc_addr.rc_bdaddr = BDADDR_ANY;
    loc_addr.rc_channel = MY_RF_CHANNEL ;
    bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

    // put socket into listening mode
    listen(s, 1);
    printf("[CBtSpp]listen...\r\n");

  // accept one connection
    client = accept(s, (struct sockaddr *)&rem_addr, &opt);
    printf("[rfcomm]accept...\r\n");

    ba2str( &rem_addr.rc_bdaddr, buf );
    fprintf(stderr, "accepted connection from %s\n", buf);
    memset(buf, 0, sizeof(buf));

    m_socket = s;
    m_client = client;

}


void CBtSpp::RfcommClose(void){
	if (m_client){
		close(m_client);
		m_client = 0;
	}
	if (m_socket){
		close(m_socket);
		m_socket = 0;
	}
}


#if 0

void CBtSpp::RfcommListen(void){
    struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };
    char buf[1024] = { 0 };
    int s, client;//, bytes_read;
    unsigned int opt = sizeof(rem_addr);

    // allocate socket
    s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // bind socket to port 1 of the first available bluetooth adapter
    loc_addr.rc_family = AF_BLUETOOTH;
//richard    loc_addr.rc_bdaddr = *BDADDR_ANY;
    loc_addr.rc_bdaddr = BDADDR_ANY;
    loc_addr.rc_channel = MY_RF_CHANNEL ;
    bind(s, (struct sockaddr *)&loc_addr, sizeof(loc_addr));

    // put socket into listening mode
    listen(s, 1);
printf("[rfcomm]listen...\r\n");

    // accept one connection
    client = accept(s, (struct sockaddr *)&rem_addr, &opt);
printf("[rfcomm]accept...\r\n");

    ba2str( &rem_addr.rc_bdaddr, buf );
    fprintf(stderr, "accepted connection from %s\n", buf);
    memset(buf, 0, sizeof(buf));

    m_socket = s;
    m_client = client;

/*
    // read data from the client
    bytes_read = recv(client, buf, sizeof(buf), 0);
    if( bytes_read > 0 ) {
        printf("received [%s]\n", buf);
    }

    // close connection
    close(client);
    close(s);
    return 0;	*/
}

#endif

bool CBtSpp::NoneBlockingRead(char *pBuffer, int nBufferSize, int *prx_len){
    int bytes_read=0;

    if (m_socket && m_client){
        bytes_read = recv(m_client, pBuffer, nBufferSize, 0);
	*prx_len = bytes_read;
    }

    if (bytes_read > 0)
	return true;
    return false;
}
