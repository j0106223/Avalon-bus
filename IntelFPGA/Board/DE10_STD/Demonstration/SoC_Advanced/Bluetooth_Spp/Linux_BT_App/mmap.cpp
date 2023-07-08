#include "terasic_os.h"
#include "mmap.h"
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "hps_0.h"
#include <sys/mman.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

#define H2F_LW_REGS_BASE ( ALT_STM_OFST )
#define H2F_LW_REGS_SPAN ( 0x04000000 )
#define H2F_LW_REGS_MASK ( H2F_LW_REGS_SPAN - 1 )


CMMap::CMMap(int MapID):
	m_fd(-1),
	m_virtual_base(MAP_FAILED)
{
		if (MapID == MAP_H2F_LW_BRIDGE){
			if (map(H2F_LW_REGS_BASE, H2F_LW_REGS_SPAN, H2F_LW_REGS_MASK))
				CheckQsysID();
			else
				printf("[CMMap]map failed\r\n");
		}
}


CMMap::~CMMap(){
	unmap();

}

bool CMMap::CheckQsysID(void){

	bool bSuccess = false;
	uint32_t Version;
	printf("[CMMap]CheckQsysID\r\n");
	if (m_virtual_base == MAP_FAILED){
		printf("CMMAP: vaitual_base is invalid\r\n");
	}else{
		Version = Reg32_Read(SYSID_QSYS_BASE, 0);
		printf("[CMMap]Read Verson ID=%u, Expected Version ID=%u\r\n",Version, (uint32_t )SYSID_QSYS_ID);
		if (Version == SYSID_QSYS_ID)
			bSuccess = true;
	}
	return bSuccess;
}

bool CMMap::map(uint32_t addr_base, uint32_t addr_span, uint32_t addr_mask){
	
	bool bSuccess = false;
	int fd;
	void *virtual_base;
	
	m_addr_base = addr_base;
	m_addr_span = addr_span;
	m_addr_mask = addr_mask;	

	unmap();

	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
	}else{
	
		virtual_base = mmap( NULL, addr_span, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, addr_base );
		if( virtual_base == MAP_FAILED ) {
			printf( "ERROR: mmap() failed...\n" );
			close( fd );
		}else{
			bSuccess = true;
			m_fd = fd;
			m_virtual_base = virtual_base;
			
		}
	}
		
	return bSuccess;
}


void CMMap::unmap(){
	
	if (m_virtual_base != MAP_FAILED){
		if( munmap( m_virtual_base, m_addr_span ) != 0 ) 
			printf( "ERROR: munmap() failed...\n" );
		m_virtual_base = MAP_FAILED;	
		close( m_fd );
		m_fd = -1;
	}	
}

bool CMMap::Reg32_Write(uint32_t Addr, uint32_t Index, uint32_t Value){
	void *reg_virtual_base;
	
	if (m_virtual_base == MAP_FAILED)
		return false;
		
	reg_virtual_base=(char *)m_virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + Addr + Index*4 ) & ( unsigned long)( m_addr_mask ) );
	*(uint32_t *)reg_virtual_base = Value;
	
	return true;
	
}

uint32_t CMMap::Reg32_Read(uint32_t Addr, uint32_t Index){
	uint32_t Value;
	void *reg_virtual_base;
	
	if (m_virtual_base == MAP_FAILED)
		return 0;
		
	reg_virtual_base=(char *)m_virtual_base + ( ( unsigned long  )( ALT_LWFPGASLVS_OFST + Addr + Index*4 ) & ( unsigned long)( m_addr_mask ) );
	Value = *(uint32_t *)reg_virtual_base;	
	
	return Value;
}
