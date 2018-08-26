#include "define.hpp"
#include "debug.hpp"
#include <stdexcept>

using namespace rramcnn;
using std::cout;
using std::endl;

/**
 * @file CSD.h
 * @author jjiangan xchenbn
 *
 * This is to simulate the algorithm of the csd encoding in a two's compliment format.
 * This algorithm always performs on positive input value. For negative input value, it simply
 * exchanges the "digit" and "sign" in the output.
 * For CSD computation, LUT given by "Efficient Canonic Signed Digit Recoding" is used to reduce computation
 * tensity
*/
void csdEncoding(const int& input_val, cv::Mat& digit, cv::Mat& sign)
{
    // controlling clause
    cv::Mat *digit_ptr, *sign_ptr;
    if(input_val==0)    { return; }
    else if(input_val>0){ digit_ptr = &digit;sign_ptr = &sign; }
    else                { digit_ptr = &sign;sign_ptr = &digit; }

    // data preperation
    int num = abs(input_val);
    int carry = 0;

    // csd processing
    for (int i = 0; i < kBitWidth; i++) {
        // pre-processing
        int lsb2 = num & 0x3;           // fetch the last 2 bits
        int csd_in = (lsb2<<1)+carry;   // {las2:carry} to make
        num = num >> 1;                 // update num
        // use LUT to compute CSD
        switch(csd_in){
            case 0: carry=0; break;
            case 1: digit_ptr->at<float>(kBW_1-i,0)=1; carry=0; break;
            case 2: digit_ptr->at<float>(kBW_1-i,0)=1; carry=0; break;
            case 3: carry=1; break;
            case 4: carry=0; break;
            case 5: sign_ptr->at<float>(kBW_1-i,0)=1; carry=1; break;
            case 6: sign_ptr->at<float>(kBW_1-i,0)=1; carry=1; break;
            case 7: carry=1; break;
            default:
                throw std::logic_error("csd_in should not be switched to this clause");
        }
    }

}

int main() {
    clock_t start,end;
    start = clock();

    cv::Mat digit(kBitWidth, 1, CV_32FC1, cv::Scalar(0));
    cv::Mat sign(kBitWidth, 1, CV_32FC1, cv::Scalar(0));
    csdEncoding(0, digit, sign);

    end = clock();
    printf("time=%f\n", static_cast<double>(end-start));
    return 0;
}
