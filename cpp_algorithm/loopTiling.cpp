// use library
#include <sys/resource.h>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <tiff.h>
#include <Eigen/Dense>

using namespace std;
typedef Eigen::Matrix<short, Eigen::Dynamic, 1> VectorXs;

/**
 * @brief  This is to perform loop tiling
 * @notice Loop tiling may lower down your computation speed if the total 
 *         computation time is not high enough, so please test it before 
 *         deployment.
 *         Also, ITile is a hyperparameter that depends on your CPU, please 
 *         determine it by test.
 *
 * Loop tiling means to break down a large for loop into several small loops,
 * which makes the data in every loop fit into your cache to speed up your 
 * program.
 */
int main(int argc, char** argv) {
    const int weight_size_ = 3560123;
    const unsigned int iTile = 1000;

    //! loop tiling computation------------------------------------------------
    VectorXs weight_quantized(3560123);

    clock_t start,end;
    start = clock();

    const unsigned int weight_size = weight_size_;
    const unsigned int res_w_pow2 = 16;
    const unsigned int loop_major = iTile * (weight_size / iTile);

    for (unsigned int ii = 0; ii < loop_major; ii+=iTile) {
        for (unsigned int i = ii; i < ii+iTile; i++) {
            weight_quantized(i) = static_cast<short>(i*res_w_pow2);
        }
    }
    for (int i = loop_major; i < weight_size; ++i) {
        weight_quantized(i) = static_cast<short>(i*res_w_pow2);
    }

    end = clock();
    printf("time=%f\n", static_cast<double>(end-start));

    //! original computation--------------------------------------------------
    VectorXs weight_quantized2(weight_size_);

    start = clock();

    for (unsigned int i = 0; i < weight_size; i++) {
        weight_quantized2(i) = static_cast<short>(i*res_w_pow2);
    }

    end = clock();
    printf("time=%f\n", static_cast<double>(end-start));

    //! compare if two results are the same------------------------------------
    assert(weight_quantized.isApprox(weight_quantized2));

    return 0;
}



