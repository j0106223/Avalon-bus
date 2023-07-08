#ifndef MMAP_H_
#define MMAP_H_



class CMMap {
public:
	typedef enum{
		MAP_H2F_LW_BRIDGE = 0
	}MAP_ID;	
	
protected:
	int m_fd;
	void *m_virtual_base;
	uint32_t m_addr_mask;
	uint32_t m_addr_base;
	uint32_t m_addr_span;
	int m_MapID;

protected:
	bool map(uint32_t addr_base, uint32_t addr_span, uint32_t addr_mask);
	void unmap();
	bool CheckQsysID(void);

public:
	
	CMMap(int MapID);
	virtual ~CMMap();
	
	bool Reg32_Write(uint32_t Addr, uint32_t Index, uint32_t Value);
	uint32_t Reg32_Read(uint32_t Addr, uint32_t Index);

};

#endif /* MMAP_H_ */
