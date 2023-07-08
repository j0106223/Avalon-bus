#ifndef QUEUE_H_
#define QUEUE_H_


class CQueue {
protected:
	void** m_List;
	int m_Front;
	int m_Rear;
 	int m_QueueSize;


public:
	CQueue(int QueueSize = 8);
	virtual ~CQueue();
	
	bool Push(void *);
	void* Pop(void);
	bool IsFull(void);
	bool IsEmpty(void);
	void Clear(void);

};

#endif /* QUEUE_H_ */
