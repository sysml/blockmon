
/*
 * @file    topk.hpp
 * @author  Tiziano Campili
 * @version 1.0
 *
 * @section LICENSE
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details at
 * http://www.gnu.org/copyleft/gpl.html
 *
 * @section DESCRIPTION
 *
 * This class represents a topk element, used for mantain a list of
 * k top element inserted. It use a counting bloom filter for mantain
 * the counters and an array of struct to mantain the top k.
 * the position are indicated in the format [0,k-1], where 0 is the highest flow
 * and k-1 is the less.
 * The struct, named flow, contain the value of counter, the name of the flow,
 * and the length of this name.
 */


#ifndef TOPK_HPP
#define TOPK_HPP

#include "cbf.hpp"
#include <cassert>
#include <cstring>

namespace bm {

/*
 * this struct represent a top k flow
 */
struct flow {
	unsigned int value;		//value of flow
	unsigned char* id;		//name of flow
	int length;				//length of name
};

class TOPK {

	public:

		/*
		 * this constructor create a TOPK object which can store a set of
		 * unsigned int counters (usually flow). the counters are stored in
		 * a CBF object and the top k are stored in an arrary apart.
		 * @param k number of top flow to monitor
		 * @param cbf pointer to cbf to use
		 *
		 */
		TOPK(unsigned int k, CBF* cbf);

		/*
		 * copy constructor
		 */
		TOPK(const TOPK& t);

		TOPK& operator=(const TOPK&);

		/*
		 * destructor. delete only the TOPK.
		 * if you want to delete the cbf you must do it
		 * separately
		 */
		~TOPK();

		/*
		 * this method reset the TOPK. if you want to reset
		 * the cbf you must clear it separately
		 */
		void reset();

		/*
		 * this method update the TOPK and the cbf. increase the value of the flow
		 * to specified value in struct pointed by f. if the value of the flow
		 * is > of that specified this method does nothing.
		 * @param f pointer to a flow struct which fields indicates:
		 * 		value value to set to
		 * 		id id of the flow
		 * 		length length of field id
		 * @return the amount added to the flow or -1 if no adding is request(flow already higher)
		 */
		int update_given(flow* f);

		/*
		 * this method update the TOPK and the cbf. increase the value of the flow
		 * specified of the desidered amount, using water filling method of cbf.
		 * @param f pointer to a flow struct which fields indicates:
		 * 		value value fill in
		 * 		id id of the flow
		 * 		length length of field id
		 * @return the new value of the flow
		 */
		unsigned int update_filling(flow* f);

		/*
		 * this method update the TOPK and the cbf. increase the value of th flow
		 * specified of the desidered amount, using add method of cbf (normal add counting)
		 * @param f pointer to a flow struct which fields indicates:
		 * 		value value to add to
		 * 		id id of the flow
		 * 		length length of field id
		 * @return the new value of the flow
		 */
		unsigned int update_adding(flow* f);

		/*
		 * this method set the value of the specified flow to current value
		 * stored, and return if flow is a top k or not.
		 * @param f pointer to a flow struct which fields indicates:
		 * 		value in this field the method set the current value
		 * 		id id of the flow
		 * 		length length of field id
		 * @return 0 if it is a top k flow or -1 if is not a top k flow
		 */
		int get_value(flow* f);

		/*
		 * this method return the position of the flow and if it is a top k
		 * flow set the value in struct passed
		 * @param f pointer to a flow struct which fields indicates:
		 * 		value in this field the method set the current value
		 * 		id id of the flow
		 * 		length length of field id
		 * @return a value in [0,k-1] if is a top k, -1 if is not a top k flow
		 */
		int get_pos(flow* f);

		/*
		 * this method return a const pointer to flow that is in pos position.
		 * @param pos position of interested flow ( [0,k-1] 0 means the top)
		 * @return const pointer to struct in pos position
		 */
		const flow* get_flow(unsigned int pos);

	private:
		unsigned int k;			//how much flows monitor
		flow* topk;				//list of the topk flows
		CBF* cbf;				//cbf containing the value of flows

};

}

#endif /* TOPK_H_ */
