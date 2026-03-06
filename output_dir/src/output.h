#ifndef PROMETHEUS_H
#define PROMETHEUS_H

#include <ap_int.h>
#include <hls_stream.h>
#include <hls_vector.h>
#include <cstring>
#include <algorithm>
#include <iostream>
#include <ap_axi_sdata.h>


typedef hls::vector<float,16> float16;
typedef hls::vector<float,8> float8;
typedef hls::vector<float,4> float4;
typedef hls::vector<float,2> float2;
typedef hls::vector<float,1> float1;


void load_vy_for_task1(hls::stream<float1>& fifo_y_from_off_chip_to_S1, float1 vy[400]);
void load_vy_for_task1(hls::stream<ap_axiu<32,0,0,0>>& fifo_y_from_off_chip_to_S1, float1 vy[400]);
void load_vx_for_task1(hls::stream<float1>& fifo_x_from_off_chip_to_S1, float1 vx[400]);
void load_vx_for_task1(hls::stream<ap_axiu<32,0,0,0>>& fifo_x_from_off_chip_to_S1, float1 vx[400]);
void load_vw_for_task3(hls::stream<float1>& fifo_w_from_off_chip_to_S3, float1 vw[400]);
void load_vw_for_task3(hls::stream<ap_axiu<32,0,0,0>>& fifo_w_from_off_chip_to_S3, float1 vw[400]);
void load_ve1_for_task0(hls::stream<float1>& fifo_e1_from_off_chip_to_S0, float1 ve1[400]);
void load_ve1_for_task0(hls::stream<ap_axiu<32,0,0,0>>& fifo_e1_from_off_chip_to_S0, float1 ve1[400]);
void load_ve2_for_task0(hls::stream<float1>& fifo_e2_from_off_chip_to_S0, float1 ve2[400]);
void load_ve2_for_task0(hls::stream<ap_axiu<32,0,0,0>>& fifo_e2_from_off_chip_to_S0, float1 ve2[400]);
void load_vu1_for_task0(hls::stream<float1>& fifo_u1_from_off_chip_to_S0, float1 vu1[400]);
void load_vu1_for_task0(hls::stream<ap_axiu<32,0,0,0>>& fifo_u1_from_off_chip_to_S0, float1 vu1[400]);
void load_vA_for_task0(hls::stream<float1>& fifo_A_from_off_chip_to_S0, float1 vA[160000]);
void load_vA_for_task0(hls::stream<ap_axiu<32,0,0,0>>& fifo_A_from_off_chip_to_S0, float1 vA[160000]);
void load_vu2_for_task0(hls::stream<float1>& fifo_u2_from_off_chip_to_S0, float1 vu2[400]);
void load_vu2_for_task0(hls::stream<ap_axiu<32,0,0,0>>& fifo_u2_from_off_chip_to_S0, float1 vu2[400]);
void load_vz_for_task2(hls::stream<float1>& fifo_z_from_off_chip_to_S2, float1 vz[400]);
void load_vz_for_task2(hls::stream<ap_axiu<32,0,0,0>>& fifo_z_from_off_chip_to_S2, float1 vz[400]);
void store_vx_for_task1(hls::stream<float1>& fifo_x_to_off_chip, float1 vx[400]);
void store_vx_for_task1(hls::stream<ap_axiu<32,0,0,0>>& fifo_x_to_off_chip, float1 vx[400]);
void store_vw_for_task3(hls::stream<float1>& fifo_w_to_off_chip, float1 vw[400]);
void store_vw_for_task3(hls::stream<ap_axiu<32,0,0,0>>& fifo_w_to_off_chip, float1 vw[400]);
void store_vA_for_task0(hls::stream<float1>& fifo_A_to_off_chip, float1 vA[160000]);
void store_vA_for_task0(hls::stream<ap_axiu<32,0,0,0>>& fifo_A_to_off_chip, float1 vA[160000]);
void FT0_level0(float alpha, float beta, hls::stream<float1>& fifo_A_from_task0_to_task1, hls::stream<float1>& fifo_A_from_task0_to_task3, hls::stream<float1>& fifo_e1_from_off_chip_to_S0, hls::stream<float1>& fifo_e2_from_off_chip_to_S0, hls::stream<float1>& fifo_u1_from_off_chip_to_S0, hls::stream<float1>& fifo_A_from_off_chip_to_S0, hls::stream<float1>& fifo_u2_from_off_chip_to_S0, hls::stream<float1>& fifo_A_to_off_chip);
void compute_FT0_level1(float alpha,  float beta,  hls::stream<float1>& fifo_A_from_task0_to_task1,  hls::stream<float1>& fifo_A_from_task0_to_task3,  hls::stream<float1>& fifo_e1_from_off_chip_to_S0,  hls::stream<float1>& fifo_e2_from_off_chip_to_S0,  hls::stream<float1>& fifo_u1_from_off_chip_to_S0,  hls::stream<float1>& fifo_A_from_off_chip_to_S0,  hls::stream<float1>& fifo_u2_from_off_chip_to_S0,  hls::stream<float1>& fifo_A_to_off_chip,  int i0, int j0, float A_0[400][400],float A_1[400][400],float A_2[400][400]);
void FT0_level1(float alpha, float beta, hls::stream<float1>& fifo_A_from_task0_to_task1, hls::stream<float1>& fifo_A_from_task0_to_task3, hls::stream<float1>& fifo_e1_from_off_chip_to_S0, hls::stream<float1>& fifo_e2_from_off_chip_to_S0, hls::stream<float1>& fifo_u1_from_off_chip_to_S0, hls::stream<float1>& fifo_A_from_off_chip_to_S0, hls::stream<float1>& fifo_u2_from_off_chip_to_S0, hls::stream<float1>& fifo_A_to_off_chip, int i0);
void compute_FT1_level0(float alpha,  float beta,  hls::stream<float1>& fifo_A_from_task0_to_task1,  hls::stream<float1>& fifo_y_from_off_chip_to_S1,  hls::stream<float1>& fifo_x_from_off_chip_to_S1,  hls::stream<float1>& fifo_x_from_task2_to_task3,  hls::stream<float1>& fifo_z_from_off_chip_to_S2,  hls::stream<float1>& fifo_x_to_off_chip, int i0, float x_0[400],float x_1[400],float x_2[400],float y[400]);
void FT1_level0(float alpha, float beta, hls::stream<float1>& fifo_A_from_task0_to_task1, hls::stream<float1>& fifo_y_from_off_chip_to_S1, hls::stream<float1>& fifo_x_from_off_chip_to_S1, hls::stream<float1>& fifo_x_from_task2_to_task3, hls::stream<float1>& fifo_z_from_off_chip_to_S2, hls::stream<float1>& fifo_x_to_off_chip);
void compute_FT2_level0(float alpha,  float beta,  hls::stream<float1>& fifo_A_from_task0_to_task3,  hls::stream<float1>& fifo_x_from_task2_to_task3,  hls::stream<float1>& fifo_w_from_off_chip_to_S3,  hls::stream<float1>& fifo_w_to_off_chip, int i0, float w_0[400],float w_1[400],float w_2[400],float x[400]);
void FT2_level0(float alpha, float beta, hls::stream<float1>& fifo_A_from_task0_to_task3, hls::stream<float1>& fifo_x_from_task2_to_task3, hls::stream<float1>& fifo_w_from_off_chip_to_S3, hls::stream<float1>& fifo_w_to_off_chip);
void task0_intra(float alpha, float beta, int i0, float A[400][400], int j0);
void task1_intra(float alpha, float beta, float x[400], float y[400], int i0);
void task2_intra(float alpha, float beta, float x[400], float y[400], int i0);
void task3_intra(float alpha, float beta, float w[400], float x[400], int i0);
void read_A_FT0(float A[400][400], hls::stream<float1>& fifo_A_from_off_chip_to_S0, int j0, int i0);
void read_A_FT0(float A[400][400], hls::stream<ap_axiu<32,0,0,0>>& fifo_A_from_off_chip_to_S0, int j0, int i0);
void read_y_FT1(float y[400], hls::stream<float1>& fifo_y_from_off_chip_to_S1);
void read_y_FT1(float y[400], hls::stream<ap_axiu<32,0,0,0>>& fifo_y_from_off_chip_to_S1);
void read_x_FT1(float x[400], hls::stream<float1>& fifo_x_from_off_chip_to_S1, int i0);
void read_x_FT1(float x[400], hls::stream<ap_axiu<32,0,0,0>>& fifo_x_from_off_chip_to_S1, int i0);
void read_x_FT2(float x[400], hls::stream<float1>& fifo_x_from_task2_to_task3);
void read_x_FT2(float x[400], hls::stream<ap_axiu<32,0,0,0>>& fifo_x_from_task2_to_task3);
void read_w_FT2(float w[400], hls::stream<float1>& fifo_w_from_off_chip_to_S3, int i0);
void read_w_FT2(float w[400], hls::stream<ap_axiu<32,0,0,0>>& fifo_w_from_off_chip_to_S3, int i0);
void write_A_FT0(float A[400][400], hls::stream<float1>& fifo_A_from_task0_to_task1, int j0, int i0);
void write_A_FT0(float A[400][400], hls::stream<ap_axiu<32,0,0,0>>& fifo_A_from_task0_to_task1, int j0, int i0);
void write_x_FT1(float x[400], hls::stream<float1>& fifo_x_from_task2_to_task3, int i0);
void write_x_FT1(float x[400], hls::stream<ap_axiu<32,0,0,0>>& fifo_x_from_task2_to_task3, int i0);
void write_w_FT2(float w[400], hls::stream<float1>& fifo_w_to_off_chip, int i0);
void write_w_FT2(float w[400], hls::stream<ap_axiu<32,0,0,0>>& fifo_w_to_off_chip, int i0);
void kernel_nlp_slr0(float alpha, float beta, float1 vA_for_task0[160000], float1 vu1_for_task0[400], float1 ve1_for_task0[400], float1 vu2_for_task0[400], float1 ve2_for_task0[400], float1 vx_for_task1[400], float1 vy_for_task1[400], float1 vz_for_task2[400], float1 vw_for_task3[400]);
void kernel_nlp_slr1();
void kernel_nlp_slr2();
#endif // PROMETHEUS_H
