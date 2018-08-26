/*
 * Author: JIANG Jingbo
 * Email: jjiangan@connect.ust.hk
 * Time: 8/4/2017
 * */
#include <iostream>
#include <vector>
using namespace std;
/*
 * @brief: Test for the speed of SIMD (uint -> uchar)
 *
 * @notes: This program assumes no overflow happens
 * */
int main() {

    // Used Constant:
    const int div_num = 4;                          // SIMD's M = 4
    const unsigned long long loop = 1000000000;   // The program will run for "loop" round to consume more time

    // Declare Value: a[0]: MSB, a[1]: LSB
    vector<unsigned int> a(div_num), b(div_num);
    unsigned int first, second, outcomes;
    unsigned char *first_ptr = reinterpret_cast<unsigned char *>(&first);
    unsigned char *second_ptr = reinterpret_cast<unsigned char *>(&second);
    unsigned char *outcomes_ptr = reinterpret_cast<unsigned char *>(&outcomes);
    vector<unsigned char> outcomes2(5);

    // Assign Value:
    for (int j = 0; j < div_num; ++j) {
        // a[j] = 5(LSB), 6, 7, 8(MSB) ...
        a[j] = j + 5;
    }
    for (int j = 0; j < div_num; ++j) {
        // b[j] = 9(LSB), 10, 11, 12(MSB) ...
        b[j] = j + 9;
    }
    for (int k = 0; k < div_num; ++k) {
        *(first_ptr+k) = a.at(k);
        *(second_ptr+k) = b.at(k);
    }

    // Print input:
    for (int l = 0; l < div_num; ++l) {
        // From LSB to MSB
        if(l==0) cout << "Print first: \n";
        cout << static_cast<unsigned int>(*(first_ptr+l)) << endl;
    }
    for (int l = 0; l < div_num; ++l) {
        // From LSB to MSB
        if(l==0) cout << "Print second: \n";
        cout << static_cast<unsigned int>(*(second_ptr+l)) << endl;
    }

    // SIMD Operation:
    const clock_t begin_time = clock();
    for (unsigned long long i = 0; i < loop; ++i) {
        outcomes = first+second;
    }
    cout << "SIMD Operation consumes " << static_cast<double>( clock() - begin_time )/loop << " to run\n";

    // Print output:
    for (int l = 0; l < div_num; ++l) {
        // From LSB to MSB
        if(l==0) cout << "Print outcomes (SIMD): \n";
        cout << static_cast<unsigned int>(*(outcomes_ptr+l)) << endl;
    }

    // Normal Operation:
    const clock_t begin_time2 = clock();
    for (unsigned long long i = 0; i < loop; ++i) {
        outcomes2[0] = a[0]+b[0];
        outcomes2[1] = a[1]+b[1];
        outcomes2[2] = a[2]+b[2];
        outcomes2[3] = a[3]+b[3];
    }
    for (int m = 0; m < div_num; ++m) {
        if(m==0) cout << "Print outcomes2 (Normal): \n";
        cout << static_cast<unsigned int>(outcomes2[m])<<endl;
    }
    cout << "Normal Operation consumes " << static_cast<double>( clock() - begin_time2 )/loop << " to run\n";
    
    return 0;
}
