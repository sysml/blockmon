/* Copyright (c) 2011, NEC Europe Ltd, Consorzio Nazionale
 * Interuniversitario per le Telecomunicazioni, Institut
 * Telecom/Telecom Bretagne, ETH Zürich, INVEA-TECH a.s. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *    * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *    * Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *    * Neither the names of NEC Europe Ltd, Consorzio Nazionale
 *      Interuniversitario per le Telecomunicazioni, Institut Telecom/Telecom
 *      Bretagne, ETH Zürich, INVEA-TECH a.s. nor the names of its contributors
 *      may be used to endorse or promote products derived from this software
 *      without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT
 * HOLDERBE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
 * IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
 */

#include <binning.hpp>
#include <vector>
#include <iostream>
#include <sstream>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <errno.h>
#include <algorithm>

using namespace std;

vector<uint64_t> binning_function(uint64_t max_data, uint16_t n_class_max, bool flag0, uint16_t *NC);
vector<uint64_t> unique_floor(vector<double> array);


/*Lief function from matlab code*/
vector<uint64_t> binning_function(uint64_t max_data, uint16_t n_class_max, bool flag0, uint16_t *NC)
{

    /*--Optimal binning algorithm--
     * search base for a logarithmic binning of exactly NC classes with integer
     * edges using a dichotomous algorithm
     * (with the addition of a precautionary sub-optimal stop mechanism used
     * just in case non-convergence)
     *
     * max_data : maximum data value;
     * n_class_max : maximum number of wanted classes;
     * flag0 : if == 1  means that the class 0 will be deleted;
     * NC : number of classes in output;
     * bins[NC+1] : array of bins edges;
    */

    vector<uint64_t> bins;
    /* Checks if the maximum value is 0 */
    if(max_data == 0)
    {
        if(flag0 == false) //ZERO filtering not active
        {
            *NC = 1;
            bins.insert(bins.begin(), max_data); //We have only one bin and its value is 0, so we have NC = 1, but 1 edge with value 0 !
            return bins;
        }else{
            *NC = 0; // If zero filtering is activated we have no bins, no elements and no edges !!!
                        //We have to report that we are in the case of zero filtering with max value = 0
                        //returning an empty array of edges!
            return bins;
        }
    }

    vector<double> binsf;
    double b, best_b, sup, inf,power;
    int scarto, best_scarto, NNC, i, esp, l, cont, max_iter;

    *NC = min((long long)n_class_max,(long long)max_data);//if max_data<n_class_max it not makes sense to do the binning on n_class_max classes
    NNC = *NC;
    b = pow(max_data,(double)1/(NNC-1)); //NC-1 because there is also 0 in bins and the exponent starts from 0;
                                        //in this way we have NC+1 edges of bins i.e. NC classes
                                        //(the constrain is b^(NC-1)=max_data)

    i=0;
    vector<double>::iterator it;
    it = binsf.insert(binsf.begin(), i);
    for(i=0;i<NNC;i++)
    {
        power = pow(b,i);
        it = binsf.insert(it+1,power);
    }

    bins=unique_floor(binsf); //to have integer bins without repetitions

    sup=b;
    inf=1;
    l=bins.size();  //we cannot exceede the base b, but nor go down 1
    scarto=abs(l-(NNC+1));  //NC+1 egdes of bins to have NC classes
    best_scarto=scarto;
    best_b=b;

    cont=0;
    max_iter=10000;

    while ((scarto!=0) & (cont<=max_iter))
    {
        /* loops until we have the wanted number of bins
        * or until the number of iterations exceedes max_iter
        * (eventualita' di precauzione nel caso esistano situazioni
        * molto particolari, dovuti alle nonlinearita', in cui l'algoritmo non
        * converge - finora mai verificatisi)
        */
        if(scarto < best_scarto)
        {// best b found, we save it to use it if the algorithm does not converges
            best_scarto=scarto;
            best_b=b;
            cont=0;//reset the counter
        }
        else cont=cont+1; //counts how many times best_b doesn't change

        //looks for a better b, and choose dichotomously
        if(l>NNC+1) inf=b;  //if the classes are too much, b has to grow to enlarge the bins, and viceversa
        else  sup=b;       //l<NC+1 (l cannot be == NC+1 else scarto would been equal to 0 we would be out to the while loop)

        b=(inf+sup)/2;
        esp=ceil(log(max_data)/log(b));  //finds the new exponent which guarantees to reach the data span

        binsf.clear();
        i=0;
        it = binsf.insert(binsf.begin(),i);
        for(i=1;i<esp+2;i++)
        {
            power = pow(b,(i-1));
            it = binsf.insert(it+1,power);
        }

        bins = unique_floor(binsf);  //recalculate the bins
        l = bins.size();
        scarto = abs(l-(NNC+1)); //evaluates the waste for the new condition check
    }

    if(cont>max_iter)
    {
        b = best_b;
        esp = ceil(log(max_data)/log(b));  //finds the new exponent which guarantees to reach the data span

        binsf.clear();
        i=0;
        it = binsf.insert(binsf.begin(),i);
        for(i=1;i<esp+2;i++)
        {
            power = pow(b,(i-1));
            it = binsf.insert(it+1,power);
        }

        bins = unique_floor(binsf);  //recalculate the bins

    }
    *NC = bins.size()-1;;  //the number of classes is of 1 lower than the number of the edges

    //removes the class 0 if required
    if (flag0 == 1)
    {
        bins.erase(bins.begin());
        *NC = *NC-1;
    }
    return bins;

}


vector<uint64_t> unique_floor(vector<double> array){

    /*Gets the elements of the array (of double elements) passed in input
     *rounded to the lower integer (uint64_t) without repetitions
     */
    uint64_t f;
    vector<uint64_t> floor_array;

    //sorts the elements in the double array
    sort(array.begin(), array.end());

    //rounds the array elements to the lower integer
    vector<double>::iterator iter;
    vector<uint64_t>::iterator itt = floor_array.begin();

    for(iter=array.begin(); iter!=array.end(); iter++)
    {
        f = floor(*iter);

        floor_array.push_back(f);
        //floor_array.insert(itt, f);
        //itt++;
    }

    // removes the duplicate elements using default comparison:
    itt = unique (floor_array.begin(), floor_array.end()); // 10 20 30 20 10 ?  ?  ?  ?
    //we need to reset the size of the array
    floor_array.resize( itt - floor_array.begin() );       // 10 20 30 20 10



    return floor_array;
}
