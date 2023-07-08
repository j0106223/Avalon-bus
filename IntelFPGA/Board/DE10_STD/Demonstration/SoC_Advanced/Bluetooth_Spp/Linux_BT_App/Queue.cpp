
#include "Queue.h"


CQueue::CQueue(int QueueSize):
	m_Front(0),
	m_Rear(0),
	m_QueueSize(QueueSize)
	{
	// TODO Auto-generated constructor stub

	m_List = new void*[m_QueueSize];

}

CQueue::~CQueue() {
	// TODO Auto-generated destructor stub
}

bool CQueue::IsEmpty() {
	// TODO Auto-generated destructor stub
    if (m_Front == m_Rear)
        return true;
    return false;
}


bool CQueue::IsFull() {
	// TODO Auto-generated destructor stub
    if ((m_Front+1)%m_QueueSize == m_Rear)
        return true;
    return false;
}

bool CQueue::Push(void* data){
    if (IsFull())
        return false;

    m_List[m_Front] = data;
    m_Front = (m_Front+1)%m_QueueSize;
    return true;
}

void* CQueue::Pop(){
    void* data;
    if (IsEmpty())
        return 0;

    data = m_List[m_Rear];
    m_Rear = (m_Rear + 1)%m_QueueSize;
    return data;
}

void CQueue::Clear(void){
	m_Front = 0;
	m_Rear = 0;
}

