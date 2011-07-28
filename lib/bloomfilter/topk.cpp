

#include "topk.hpp"

namespace bm {

/*
 * CONSTUCTOR
 */
TOPK::TOPK(unsigned int _k,CBF* _cbf):
		k(_k),topk(new flow[k]),cbf(_cbf)
{
	//check if tk is positive, other value are checked in cbf constructor
	assert(_k > 0);

	//set all topk to 0
	for(unsigned int i=0;i<k;i++) {
		topk[i].value = 0;
		topk[i].id = new unsigned char;
		*topk[i].id = '\0';
		topk[i].length=0;
	}
}

/*
 * COPY CONSTRUCTOR
 */
TOPK::TOPK(const TOPK& copy):
		k(copy.k),topk(new flow[k]),cbf(copy.cbf)
{
	for(unsigned int i=0;i<k;i++) {
		topk[i].value = copy.topk[i].value;
		topk[i].length = copy.topk[i].length;
		topk[i].id = new unsigned char;
		strncpy((char*)topk[i].id,(char*)copy.topk[i].id,topk[i].length);
	}
}

TOPK& TOPK::operator=(const TOPK& copy)
{
	if (this!=&copy)
		{
			k = copy.k;
			topk = new flow[k];
			cbf = copy.cbf;
		}

		for(unsigned int i=0;i<k;i++) {
			topk[i].value = copy.topk[i].value;
			topk[i].length = copy.topk[i].length;
			topk[i].id = new unsigned char;
			strncpy((char*)topk[i].id,(char*)copy.topk[i].id,topk[i].length);
		}

		return *this;
}

/*
 * DESTRUCTOR
 */
TOPK::~TOPK() {
	//destroy the array of char
	for(unsigned int i=0; i<k; i++)
		delete []topk[i].id;
	//destroy the array of struct
	delete []topk;
}

/*
 * RESET THE TOPK OBJECT
 */
void TOPK::reset() {
	//set all the topk topk to 0
	for(unsigned int i=0;i<k;i++) {
		topk[i].value = 0;
		memset(topk[i].id,0,topk[i].length);
		topk[i].length=0;
	}

	//reset the cbf
	//cbf->reset();
}

/*
 * SET VALUE OF FLOW TO GIVEN AMOUNT
 */
int TOPK::update_given(flow* f) {
	//calculate how much increment
	unsigned int x = cbf->get_count(f->id,f->length);
	int amount = f->value - x;

	//if amount > 0 add amount to cbf
	if(amount>0) {
		cbf->fill(f->id,f->length,amount);

		//if the new value is a topk flow insert in list
		if(f->value > topk[0].value) {
			topk[0].value = f->value;
			memset(topk[0].id,0,topk[0].length);
			strncpy((char*)topk[0].id,(char*)f->id,f->length);
			topk[0].length = f->length;
			//reorder the list
			for(unsigned int i=0;i<k-1;i++) {
				if(topk[i].value > topk[i+1].value) {
					std::swap(topk[i],topk[i+1]);
				}
				else
					break;
			}
		}

		return amount;
	}
	else
		return -1;
}

/*
 * ADD AMOUNT SPECIFIED TO FLOW
 */
unsigned int TOPK::update_filling(flow* f) {
	//add the amount to counters in cbf
	unsigned int x = cbf->fill(f->id,f->length,f->value);

	//if the new value is a topk flow insert in list
	if(x > topk[0].value) {
		topk[0].value = x;
		memset(topk[0].id,0,topk[0].length);
		strncpy((char*)topk[0].id,(char*)f->id,f->length);
		topk[0].length = f->length;
		//reorder the list
		for(unsigned int i=0;i<k-1;i++) {
			if(topk[i].value > topk[i+1].value) {
				std::swap(topk[i],topk[i+1]);
			}
			else
				break;
		}
	}

	return x;
}

unsigned int TOPK::update_adding(flow* f) {
	//add the amount to counters in cbf
	unsigned int x = cbf->add_normal(f->id,f->length,f->value);

	//if the new value is a topk flow insert in list
	if(x > topk[0].value) {
		topk[0].value = x;
		memset(topk[0].id,0,topk[0].length);
		strncpy((char*)topk[0].id,(char*)f->id,f->length);
		topk[0].length = f->length;
		//reorder the list
		for(unsigned int i=0;i<k-1;i++) {
			if(topk[i].value > topk[i+1].value) {
				std::swap(topk[i],topk[i+1]);
			}
			else
				break;
		}
	}

	return x;
}

int TOPK::get_value(flow* f) {
	//check value of flow
	unsigned int x = cbf->get_count(f->id,f->length);

	//set the value
	f->value=x;

	//check if that value is a topk
	if(x>=topk[0].value)
		return 0;	//the flow is a topk
	else
		return -1;	//the flow is not a topk
}

int TOPK::get_pos(flow* f) {
	//check value of flow
	unsigned int x = cbf->get_count(f->id,f->length);

	//check if that value is a topk
	if(x>=topk[0].value) {
		unsigned int index = 0;
		for(unsigned int i=k-1;i>0;i--) {
			if(x==topk[i].value) {
				index = i;
				break;
			}
		}
		f->value = topk[index].value;
		//the topk are in inverse order, so return the correct pos
		return k-1-index;
	}
	else
		return -1;
}

const flow* TOPK::get_flow(unsigned int pos) {
	//check if pos is in the correct range
	assert(pos<k);

	//return the correct flow
	return &topk[k-1-pos];
}

}
