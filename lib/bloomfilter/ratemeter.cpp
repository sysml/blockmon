
#include "ratemeter.hpp"

namespace bm {

/*
 * CONSTRUCTOR
 */
RATEMETER::RATEMETER(uint _nhash, uint _shash, double _alpha):
		nhash(_nhash),hashsize(_shash),counters(1U<<hashsize),
		alpha(_alpha),c_new(new double[counters]),c_old(new double[counters]),
		sha(new SHA1()),khash(new KHASH(sha,nhash,hashsize,false))
{
	//check if 0<alpha<1
    assert((alpha>0) && (alpha<1));

    clear();
}

/*
 * COPY CONSTRUCTOR
 */
RATEMETER::RATEMETER(const RATEMETER& copy):
		nhash(copy.nhash),hashsize(copy.hashsize),counters(copy.counters),
		alpha(copy.alpha),c_new(new double[counters]),c_old(new double[counters]),
		sha(new SHA1()),khash(new KHASH(sha,nhash,hashsize,false))
{
	for(unsigned int i=0;i<counters;i++) {
		c_new[i] = copy.c_new[i];
		c_old[i] = copy.c_old[i];
	}
}

RATEMETER& RATEMETER::operator=(const RATEMETER& copy)
{
	if (this!=&copy)
		{
			nhash = copy.nhash;
			hashsize = copy.hashsize;
			counters = copy.counters;
			alpha = copy.alpha;
			c_new = new double[counters];
			c_old = new double[counters];
			sha = new SHA1();
			khash = new KHASH(sha,nhash,hashsize,false);
		}

		for(unsigned int i=0;i<counters;i++) {
			c_new[i] = copy.c_new[i];
			c_old[i] = copy.c_old[i];
		}

		return *this;
}

/*
 * DESTRUCTOR
 */
RATEMETER::~RATEMETER() {
    delete [] c_new;
    delete [] c_old;
    delete sha;
    delete khash;
}

/*
 * CLEAR THE ARRAYS
 */
void RATEMETER::clear() {
    for(uint i=0; i<counters; i++) {
    	//clear the arrays
    	c_new[i]=0;
    	c_old[i]=0;
	}
}

/*
 * SET THE PARAMETER ALPHA
 */
void RATEMETER::set_alpha(double a) {
	//check if 0<alpha<1
    assert((a>0)&&(a<1));
    alpha=a;
}

/*
 * ADD QUANTITY TO ELEMENT IN AND RETURN THE RATE BASED ON SLOT_PERC
 */
double RATEMETER::add(unsigned char *in, int len, double quantity, double slot_perc) {

	// first compute the hash functions via khash
    khash->compute(in,len);

	// computes the old accumulated value and the new one before this insertion
    double minctr=c_new[khash->H(0)];
    double oldctr=c_old[khash->H(0)];

    for(unsigned int i=1; i<nhash; i++) {
		if (c_new[khash->H(i)]<minctr)
			minctr=c_new[khash->H(i)];
		if (c_old[khash->H(i)]<oldctr)
			oldctr=c_old[khash->H(i)];
	}
    assert(minctr<1.0e99);

	// now compute the new value including the insertion and update
	// the filter by waterfilling the new counter array bins
    double newctr=minctr+quantity;
    for(unsigned int i=0; i<nhash; i++) {
    	if (c_new[khash->H(i)]<newctr)
    		c_new[khash->H(i)]=newctr;
    }

	// finally return value. If no slot_perc is given return the one
	// accumulated in the old step, otherwise include the new
	// contributions so far accumulated in the new counters
    double rt0 = oldctr * (1-alpha) / alpha;
    if (slot_perc<=0)
    	return rt0;

    assert(slot_perc<=1.0);
    double az=pow(alpha,slot_perc);
    return rt0*az + (newctr-oldctr)*(1-az);
}

/*
 * SET THE OLD AND NEW ARRAY TO SAME VALUE
 */
void RATEMETER::step() {
    for(uint i=0; i<counters; i++) {
    	//update the old array and then copy in new
		c_old[i] = c_new[i]*alpha;
		c_new[i] = c_old[i];
	}
}

/*
 * RETURN RATE WITHOUT ADDING
 */
double RATEMETER::check(unsigned char *in, int len, double slot_perc) {

	// Same steps as in add, but without insertion
	// first compute the hash functions via khash
    khash->compute(in,len);

	// now computes the old accumulated value and the new one before this insertion
    double newctr=c_new[khash->H(0)];
    double oldctr=c_old[khash->H(0)];
    for(unsigned int i=1; i<nhash; i++) {
		if (c_new[khash->H(i)]<newctr)
			newctr=c_new[khash->H(i)];
		if (c_old[khash->H(i)]<oldctr)
			oldctr=c_old[khash->H(i)];
	}

	// finally return value. If no slot_perc is given return the one
	// accumulated in the old step, otherwise include the new
	// contributions so far accumulated in the new counters
    double rt0 = oldctr * (1-alpha) / alpha;
    if (slot_perc<=0)
    	return rt0;

    assert(slot_perc<=1.0);
    double az=pow(alpha,slot_perc);
    return rt0*az + (newctr-oldctr)*(1-az);
}

}
