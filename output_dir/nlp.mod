#option solver baron;
#option baron_options 'maxtime=60 trace=nlp.trace sumfile=nlp.sum';
option solver gurobi;
option gurobi_options 'lim:time=169200 tech:logfile=gurobi.log qp:nonconvex=2';
#option solver octeract;
#option octeract_options 'max_solver_time=60';

param DSP_avail = 1440;
param ON_CHIP_MEM_SIZE = 8192;
param MAX_BUFFER_SIZE = 512;
param CONSTRAINT_ARRAY_PARTITIONING_VALUE = 1024;
param MAX_UF = 32;
param SLR0_mem = 2730;
param SLR0_DSP = 480;
param SLR1_mem = 2730;
param SLR1_DSP = 480;
param SLR2_mem = 2730;
param SLR2_DSP = 480;
param II_S0_par = 1;
param II_S0_seq = 3;
param II_S1_par = 1;
param II_S1_seq = 3;
param II_S2_par = 1;
param II_S2_seq = 3;
param II_S3_par = 1;
param II_S3_seq = 3;
param TC0_ori = 400;
param TC1_ori = 400;
param TC2_ori = 400;
param TC3_ori = 400;
param TC4_ori = 400;
param TC5_ori = 400;
param TC6_ori = 400;
param IL_par_S0 = 22;
param IL_seq_S0 = 0;
param IL_par_S1 = 8;
param IL_seq_S1 = 7;
param IL_par_S2 = 7;
param IL_seq_S2 = 0;
param IL_par_S3 = 8;
param IL_seq_S3 = 7;
param DSP_S0 = 10;
param DSP_S1 = 8;
param DSP_S2 = 2;
param DSP_S3 = 8;

var TC0 integer >= 400 <= 400;
var TC1 integer >= 400 <= 400;
var TC2 integer >= 400 <= 400;
var TC3 integer >= 400 <= 400;
var TC4 integer >= 400 <= 400;
var TC5 integer >= 400 <= 400;
var TC6 integer >= 400 <= 400;
var is_fused_task0_in_SLR_0 binary;
var is_fused_task0_in_SLR_1 binary;
var is_fused_task0_in_SLR_2 binary;
var is_fused_task1_in_SLR_0 binary;
var is_fused_task1_in_SLR_1 binary;
var is_fused_task1_in_SLR_2 binary;
var is_fused_task2_in_SLR_0 binary;
var is_fused_task2_in_SLR_1 binary;
var is_fused_task2_in_SLR_2 binary;
var is_slr0_used binary;
var is_slr1_used binary;
var is_slr2_used binary;
var perm0_S0 binary; # [0, 0, 0, 1, 0, 0, 0, 1, 0]
var perm1_S0 binary; # [0, 1, 0, 0, 0, 1, 0, 0, 0]
var perm0_S1 binary; # [1, 2, 0, 3, 0, 2, 0, 3, 0]
var perm1_S1 binary; # [1, 3, 0, 2, 0, 3, 0, 2, 0]
var perm0_S2 binary; # [2, 4, 0, 4, 0]
var perm0_S3 binary; # [3, 5, 0, 6, 0, 5, 0, 6, 0]
var Lat_comp_S3_for_off_chip >= 0;
var perm1_S3 binary; # [3, 6, 0, 5, 0, 6, 0, 5, 0]
var Lat_comp_S0_intra_tile >= 0;
var Lat_comp_S1_intra_tile >= 0;
var Lat_comp_S2_intra_tile >= 0;
var Lat_comp_S3_intra_tile >= 0;
var footprint_A_S0 integer >= 0;
var footprint_A_S0_reuse integer >= 0;
var footprint_u1_S0 integer >= 0;
var footprint_u1_S0_reuse integer >= 0;
var footprint_e1_S0 integer >= 0;
var footprint_e1_S0_reuse integer >= 0;
var footprint_u2_S0 integer >= 0;
var footprint_u2_S0_reuse integer >= 0;
var footprint_e2_S0 integer >= 0;
var footprint_e2_S0_reuse integer >= 0;
var footprint_A_S1 integer >= 0;
var footprint_A_S1_reuse integer >= 0;
var footprint_x_S1_S2 integer >= 0;
var footprint_x_S1_S2_reuse integer >= 0;
var footprint_y_S1 integer >= 0;
var footprint_y_S1_reuse integer >= 0;
var footprint_z_S2 integer >= 0;
var footprint_z_S2_reuse integer >= 0;
var footprint_A_S3 integer >= 0;
var footprint_A_S3_reuse integer >= 0;
var footprint_x_S3 integer >= 0;
var footprint_x_S3_reuse integer >= 0;
var footprint_w_S3 integer >= 0;
var footprint_w_S3_reuse integer >= 0;
var Lat_comp_fused_S0 >= 0;
var level_transfer_A_FT0_under0 binary;
var level_reuse_A_FT0_under0 binary;
var level_transfer_A_FT0_under1 binary;
var level_reuse_A_FT0_under1 binary;
var level_transfer_A_FT0_under2 binary;
var level_reuse_A_FT0_under2 binary;
var level_transfer_u1_FT0_under0 binary;
var level_reuse_u1_FT0_under0 binary;
var level_transfer_u1_FT0_under1 binary;
var level_reuse_u1_FT0_under1 binary;
var level_transfer_u1_FT0_under2 binary;
var level_reuse_u1_FT0_under2 binary;
var level_transfer_e1_FT0_under0 binary;
var level_reuse_e1_FT0_under0 binary;
var level_transfer_e1_FT0_under1 binary;
var level_reuse_e1_FT0_under1 binary;
var level_transfer_e1_FT0_under2 binary;
var level_reuse_e1_FT0_under2 binary;
var level_transfer_u2_FT0_under0 binary;
var level_reuse_u2_FT0_under0 binary;
var level_transfer_u2_FT0_under1 binary;
var level_reuse_u2_FT0_under1 binary;
var level_transfer_u2_FT0_under2 binary;
var level_reuse_u2_FT0_under2 binary;
var level_transfer_e2_FT0_under0 binary;
var level_reuse_e2_FT0_under0 binary;
var level_transfer_e2_FT0_under1 binary;
var level_reuse_e2_FT0_under1 binary;
var level_transfer_e2_FT0_under2 binary;
var level_reuse_e2_FT0_under2 binary;
var Lat_comp_fused_S0_3 >= 0;
var Lat_comp_fused_S0_2 >= 0;
var Lat_comp_fused_S0_1 >= 0;
var Lat_comp_fused_S1_S2 >= 0;
var level_transfer_x_FT1_under0 binary;
var level_reuse_x_FT1_under0 binary;
var level_transfer_x_FT1_under1 binary;
var level_reuse_x_FT1_under1 binary;
var level_transfer_A_FT1_under0 binary;
var level_reuse_A_FT1_under0 binary;
var level_transfer_A_FT1_under1 binary;
var level_reuse_A_FT1_under1 binary;
var level_transfer_y_FT1_under0 binary;
var level_reuse_y_FT1_under0 binary;
var level_transfer_y_FT1_under1 binary;
var level_reuse_y_FT1_under1 binary;
var level_transfer_z_FT1_under0 binary;
var level_reuse_z_FT1_under0 binary;
var level_transfer_z_FT1_under1 binary;
var level_reuse_z_FT1_under1 binary;
var Lat_comp_fused_S1_S2_2 >= 0;
var Lat_comp_fused_S1_S2_1 >= 0;
var Lat_comp_fused_S3 >= 0;
var level_transfer_w_FT2_under0 binary;
var level_reuse_w_FT2_under0 binary;
var level_transfer_w_FT2_under1 binary;
var level_reuse_w_FT2_under1 binary;
var level_transfer_A_FT2_under0 binary;
var level_reuse_A_FT2_under0 binary;
var level_transfer_A_FT2_under1 binary;
var level_reuse_A_FT2_under1 binary;
var level_transfer_x_FT2_under0 binary;
var level_reuse_x_FT2_under0 binary;
var level_transfer_x_FT2_under1 binary;
var level_reuse_x_FT2_under1 binary;
var Lat_comp_fused_S3_2 >= 0;
var Lat_comp_fused_S3_1 >= 0;
var shift_0_to_1 >= 0;
var shift_0_to_2 >= 0;
var shift_1_to_2 >= 0;
var nb_dsp_used_SLR0 >= 0;
var nb_dsp_used_SLR1 >= 0;
var nb_dsp_used_SLR2 >= 0;
var TC0_0 integer >= 1;
var TC0_1 integer >= 1;
var TC1_0 integer >= 1;
var TC1_1 integer >= 1;
var TC2_0 integer >= 1;
var TC2_1 integer >= 1;
var TC3_0 integer >= 1;
var TC3_1 integer >= 1;
var TC4_0 integer >= 1;
var TC4_1 integer >= 1;
var TC5_0 integer >= 1;
var TC5_1 integer >= 1;
var TC6_0 integer >= 1;
var TC6_1 integer >= 1;
var e1_is_fully_transfered_on_last_dim_FT0 binary;
var burst_e1_is_1 binary;
var cte_0 integer >=0;
var cte_burst_without_tiling_TC1_for_e1 integer >= 0 <= 0;
var is_tc1_burst_witout_tiling_for_e1 binary;
var burst_e1_is_2 binary;
var cte_1 integer >=0;
var burst_e1_is_4 binary;
var cte_2 integer >=0;
var burst_e1_is_8 binary;
var cte_3 integer >=0;
var burst_e1_is_16 binary;
var cte_4 integer >=0;
var e2_is_fully_transfered_on_last_dim_FT0 binary;
var burst_e2_is_1 binary;
var cte_5 integer >=0;
var cte_burst_without_tiling_TC1_for_e2 integer >= 0 <= 0;
var is_tc1_burst_witout_tiling_for_e2 binary;
var burst_e2_is_2 binary;
var cte_6 integer >=0;
var burst_e2_is_4 binary;
var cte_7 integer >=0;
var burst_e2_is_8 binary;
var cte_8 integer >=0;
var burst_e2_is_16 binary;
var cte_9 integer >=0;
var y_is_fully_transfered_on_last_dim_FT1 binary;
var burst_y_is_1 binary;
var cte_10 integer >=0;
var cte_burst_without_tiling_TC3_for_y integer >= 0 <= 0;
var is_tc3_burst_witout_tiling_for_y binary;
var burst_y_is_2 binary;
var cte_11 integer >=0;
var burst_y_is_4 binary;
var cte_12 integer >=0;
var burst_y_is_8 binary;
var cte_13 integer >=0;
var burst_y_is_16 binary;
var cte_14 integer >=0;
var z_is_fully_transfered_on_last_dim_FT1 binary;
var burst_z_is_1 binary;
var cte_15 integer >=0;
var cte_burst_without_tiling_TC4_for_z integer >= 0 <= 0;
var is_tc4_burst_witout_tiling_for_z binary;
var burst_z_is_2 binary;
var cte_16 integer >=0;
var burst_z_is_4 binary;
var cte_17 integer >=0;
var burst_z_is_8 binary;
var cte_18 integer >=0;
var burst_z_is_16 binary;
var cte_19 integer >=0;
var u1_is_fully_transfered_on_last_dim_FT0 binary;
var burst_u1_is_1 binary;
var cte_20 integer >=0;
var cte_burst_without_tiling_TC0_for_u1 integer >= 0 <= 0;
var is_tc0_burst_witout_tiling_for_u1 binary;
var burst_u1_is_2 binary;
var cte_21 integer >=0;
var burst_u1_is_4 binary;
var cte_22 integer >=0;
var burst_u1_is_8 binary;
var cte_23 integer >=0;
var burst_u1_is_16 binary;
var cte_24 integer >=0;
var w_is_fully_transfered_on_last_dim_FT2 binary;
var burst_w_is_1 binary;
var cte_25 integer >=0;
var cte_burst_without_tiling_TC5_for_w integer >= 0 <= 0;
var is_tc5_burst_witout_tiling_for_w binary;
var cte_26 integer >=0;
var burst_w_is_2 binary;
var cte_27 integer >=0;
var cte_28 integer >=0;
var burst_w_is_4 binary;
var cte_29 integer >=0;
var cte_30 integer >=0;
var burst_w_is_8 binary;
var cte_31 integer >=0;
var cte_32 integer >=0;
var burst_w_is_16 binary;
var cte_33 integer >=0;
var cte_34 integer >=0;
var A_is_fully_transfered_on_last_dim_FT0 binary;
var A_is_fully_transfered_on_last_dim_FT1 binary;
var A_is_fully_transfered_on_last_dim_FT2 binary;
var burst_A_is_1 binary;
var cte_35 integer >=0;
var cte_burst_without_tiling_TC1_for_A integer >= 0 <= 0;
var is_tc1_burst_witout_tiling_for_A binary;
var cte_36 integer >=0;
var cte_37 integer >=0;
var cte_burst_without_tiling_TC2_for_A integer >= 0 <= 0;
var is_tc2_burst_witout_tiling_for_A binary;
var cte_38 integer >=0;
var cte_burst_without_tiling_TC6_for_A integer >= 0 <= 0;
var is_tc6_burst_witout_tiling_for_A binary;
var burst_A_is_2 binary;
var cte_39 integer >=0;
var cte_40 integer >=0;
var cte_41 integer >=0;
var cte_42 integer >=0;
var burst_A_is_4 binary;
var cte_43 integer >=0;
var cte_44 integer >=0;
var cte_45 integer >=0;
var cte_46 integer >=0;
var burst_A_is_8 binary;
var cte_47 integer >=0;
var cte_48 integer >=0;
var cte_49 integer >=0;
var cte_50 integer >=0;
var burst_A_is_16 binary;
var cte_51 integer >=0;
var cte_52 integer >=0;
var cte_53 integer >=0;
var cte_54 integer >=0;
var x_is_fully_transfered_on_last_dim_FT1 binary;
var x_is_fully_transfered_on_last_dim_FT2 binary;
var burst_x_is_1 binary;
var cte_55 integer >=0;
var cte_burst_without_tiling_TC2_for_x integer >= 0 <= 0;
var is_tc2_burst_witout_tiling_for_x binary;
var cte_56 integer >=0;
var cte_57 integer >=0;
var cte_burst_without_tiling_TC4_for_x integer >= 0 <= 0;
var is_tc4_burst_witout_tiling_for_x binary;
var cte_58 integer >=0;
var cte_59 integer >=0;
var cte_burst_without_tiling_TC6_for_x integer >= 0 <= 0;
var is_tc6_burst_witout_tiling_for_x binary;
var burst_x_is_2 binary;
var cte_60 integer >=0;
var cte_61 integer >=0;
var cte_62 integer >=0;
var cte_63 integer >=0;
var cte_64 integer >=0;
var burst_x_is_4 binary;
var cte_65 integer >=0;
var cte_66 integer >=0;
var cte_67 integer >=0;
var cte_68 integer >=0;
var cte_69 integer >=0;
var burst_x_is_8 binary;
var cte_70 integer >=0;
var cte_71 integer >=0;
var cte_72 integer >=0;
var cte_73 integer >=0;
var cte_74 integer >=0;
var burst_x_is_16 binary;
var cte_75 integer >=0;
var cte_76 integer >=0;
var cte_77 integer >=0;
var cte_78 integer >=0;
var cte_79 integer >=0;
var u2_is_fully_transfered_on_last_dim_FT0 binary;
var burst_u2_is_1 binary;
var cte_80 integer >=0;
var cte_burst_without_tiling_TC0_for_u2 integer >= 0 <= 0;
var is_tc0_burst_witout_tiling_for_u2 binary;
var burst_u2_is_2 binary;
var cte_81 integer >=0;
var burst_u2_is_4 binary;
var cte_82 integer >=0;
var burst_u2_is_8 binary;
var cte_83 integer >=0;
var burst_u2_is_16 binary;
var cte_84 integer >=0;
var footprint_tot_e1_FT0 integer >= 1;
var burst_e1 integer >= 0;
var footprint_tot_e2_FT0 integer >= 1;
var burst_e2 integer >= 0;
var footprint_tot_y_FT1 integer >= 1;
var burst_y integer >= 0;
var footprint_tot_z_FT1 integer >= 1;
var burst_z integer >= 0;
var footprint_tot_u1_FT0 integer >= 1;
var burst_u1 integer >= 0;
var footprint_tot_w_FT2 integer >= 1;
var burst_w integer >= 0;
var footprint_tot_A_FT0 integer >= 1;
var burst_A integer >= 0;
var footprint_tot_A_FT1 integer >= 1;
var footprint_tot_A_FT2 integer >= 1;
var footprint_tot_x_FT1 integer >= 1;
var burst_x integer >= 0;
var footprint_tot_x_FT2 integer >= 1;
var footprint_tot_u2_FT0 integer >= 1;
var burst_u2 integer >= 0;
var Lat_comp_1_2 >= 0;
var obj >= 0;
var cte_tiling_0 integer >= 0;
var cte_tiling_1 integer >= 0;
var cte_tiling_2 integer >= 0;
var cte_tiling_3 integer >= 0;
var cte_tiling_4 integer >= 0;
var cte_tiling_5 integer >= 0;
var cte_tiling_6 integer >= 0;
var cte_tiling_7 integer >= 0;
var cte_tiling_8 integer >= 0;
var buffer_size >= 0;
var fifo_size >= 0;

#comment: Fuse [0]
#comment: Fuse [1, 2]
#comment: Fuse [3]
#comment: Task 2 writes x to off-chip
#comment: Task 3 writes w to off-chip
#comment: Task 0 writes A to off-chip
#comment: Statement 0: A[i][j] = A[i][j] + u1[i] * e1[j] + u2[i] * e2[j];
#comment: Statement 1: x[i] = x[i] + beta * A[j][i] * y[j];
#comment: Statement 2: x[i] = x[i] + z[i];
#comment: Statement 3: w[i] = w[i] + alpha * A[i][j] * x[j];
#comment: Loop_0: i
#comment: Loop_1: j
#comment: Loop_2: i
#comment: Loop_3: j
#comment: Loop_4: i
#comment: Loop_5: i
#comment: Loop_6: j
#comment: Argument 0: float alpha
#comment: Argument 1: float beta
#comment: Argument 2: float A[400][400]
#comment: Argument 3: float u1[400]
#comment: Argument 4: float e1[400]
#comment: Argument 5: float u2[400]
#comment: Argument 6: float e2[400]
#comment: Argument 7: float w[400]
#comment: Argument 8: float x[400]
#comment: Argument 9: float y[400]
#comment: Argument 10: float z[400]
#comment: Task 0 gives A to Task 1
#comment: Task 1 received A from Task 0
#comment: Task 0 gives A to Task 3
#comment: Task 3 received A from Task 0
#comment: Task 2 gives x to Task 3
#comment: Task 3 received x from Task 2
#comment:  3 is a reduction loop
#comment:  6 is a reduction loop
#comment: Task 0 reads e1 from off-chip
#comment: Task 0 reads e2 from off-chip
#comment: Task 1 reads y from off-chip
#comment: Task 2 reads z from off-chip
#comment: Task 0 reads u1 from off-chip
#comment: Task 3 reads w from off-chip
#comment: Task 0 reads A from off-chip
#comment: Task 1 reads x from off-chip
#comment: Task 0 reads u2 from off-chip
#comment: Array e1 has for tc in dim 0 TC1 (ori=TC1_ori) arg0
#comment: Array e2 has for tc in dim 0 TC1 (ori=TC1_ori) arg0
#comment: Array y has for tc in dim 0 TC3 (ori=TC3_ori) arg0
#comment: Array z has for tc in dim 0 TC4 (ori=TC4_ori) arg0
#comment: Array u1 has for tc in dim 0 TC0 (ori=TC0_ori) arg0
#comment: Array w has for tc in dim 0 TC5 (ori=TC5_ori) arg0
#comment: Array A has for tc in dim 0 TC0 (ori=TC0_ori) arg0
#comment: Array A has for tc in dim 0 TC3 (ori=TC3_ori) arg0
#comment: Array A has for tc in dim 0 TC5 (ori=TC5_ori) arg0
#comment: Array A has for tc in dim 1 TC1 (ori=TC1_ori) arg0
#comment: Array A has for tc in dim 1 TC2 (ori=TC2_ori) arg0
#comment: Array A has for tc in dim 1 TC6 (ori=TC6_ori) arg0
#comment: Array A has for tc in dim 0 TC0 (ori=TC0_ori) arg0
#comment: Array A has for tc in dim 0 TC3 (ori=TC3_ori) arg0
#comment: Array A has for tc in dim 0 TC5 (ori=TC5_ori) arg0
#comment: Array A has for tc in dim 1 TC1 (ori=TC1_ori) arg0
#comment: Array A has for tc in dim 1 TC2 (ori=TC2_ori) arg0
#comment: Array A has for tc in dim 1 TC6 (ori=TC6_ori) arg0
#comment: Array A has for tc in dim 0 TC0 (ori=TC0_ori) arg0
#comment: Array A has for tc in dim 0 TC3 (ori=TC3_ori) arg0
#comment: Array A has for tc in dim 0 TC5 (ori=TC5_ori) arg0
#comment: Array A has for tc in dim 1 TC1 (ori=TC1_ori) arg0
#comment: Array A has for tc in dim 1 TC2 (ori=TC2_ori) arg0
#comment: Array A has for tc in dim 1 TC6 (ori=TC6_ori) arg0
#comment: Array x has for tc in dim 0 TC2 (ori=TC2_ori) arg0
#comment: Array x has for tc in dim 0 TC4 (ori=TC4_ori) arg0
#comment: Array x has for tc in dim 0 TC6 (ori=TC6_ori) arg0
#comment: Array x has for tc in dim 0 TC2 (ori=TC2_ori) arg0
#comment: Array x has for tc in dim 0 TC4 (ori=TC4_ori) arg0
#comment: Array x has for tc in dim 0 TC6 (ori=TC6_ori) arg0
#comment: Array x has for tc in dim 0 TC2 (ori=TC2_ori) arg0
#comment: Array x has for tc in dim 0 TC4 (ori=TC4_ori) arg0
#comment: Array x has for tc in dim 0 TC6 (ori=TC6_ori) arg0
#comment: Array u2 has for tc in dim 0 TC0 (ori=TC0_ori) arg0
#comment: Sched 0 has reuse buffer A[TC0_1][TC1_1]
#comment: Sched 0 has reuse buffer u1[TC0_1]
#comment: Sched 0 has reuse buffer e1[TC1_1]
#comment: Sched 0 has reuse buffer u2[TC0_1]
#comment: Sched 0 has reuse buffer e2[TC1_1]
#comment: Sched 1 has reuse buffer x[TC2_1]
#comment: Sched 1 has reuse buffer A[TC3_1][TC2_1]
#comment: Sched 1 has reuse buffer y[TC3_1]
#comment: Sched 2 has reuse buffer x[TC4_1]
#comment: Sched 2 has reuse buffer z[TC4_1]
#comment: Sched 3 has reuse buffer w[TC5_1]
#comment: Sched 3 has reuse buffer A[TC5_1][TC6_1]
#comment: Sched 3 has reuse buffer x[TC6_1]

minimize cost: obj;

subject to con0: is_slr0_used = min(1,is_fused_task0_in_SLR_0 + is_fused_task1_in_SLR_0 + is_fused_task2_in_SLR_0);
subject to con1: is_slr1_used = min(1,is_fused_task0_in_SLR_1 + is_fused_task1_in_SLR_1 + is_fused_task2_in_SLR_1);
subject to con2: is_slr2_used = min(1,is_fused_task0_in_SLR_2 + is_fused_task1_in_SLR_2 + is_fused_task2_in_SLR_2);
subject to con3: is_fused_task0_in_SLR_0 + is_fused_task0_in_SLR_1 + is_fused_task0_in_SLR_2 = 1; # only one SLR for fused task 0
subject to con4: is_fused_task1_in_SLR_0 + is_fused_task1_in_SLR_1 + is_fused_task1_in_SLR_2 = 1; # only one SLR for fused task 1
subject to con5: is_fused_task2_in_SLR_0 + is_fused_task2_in_SLR_1 + is_fused_task2_in_SLR_2 = 1; # only one SLR for fused task 2
subject to con6: TC1_1 = TC2_1; # same tiling factor
subject to con7: TC0_1 = TC5_1; # same tiling factor
subject to con8: TC1_1 = TC2_1; # same tiling factor
subject to con9: TC0_1 = TC5_1; # same tiling factor
subject to con10: perm0_S0 + perm1_S0 = 1; # only one permutation
subject to con11: perm0_S1 + perm1_S1 = 1; # only one permutation
subject to con12: perm0_S2 = 1; # only one permutation
subject to con13: perm0_S3 + perm1_S3 = 1; # only one permutation
subject to con14: Lat_comp_S0_intra_tile = IL_par_S0 + IL_seq_S0; # latency of the intra-tile S0
subject to con15: Lat_comp_S1_intra_tile = IL_par_S1 + IL_seq_S1 * log(TC3_1)/log(2); # latency of the intra-tile S1
subject to con16: Lat_comp_S2_intra_tile = IL_par_S2 + IL_seq_S2; # latency of the intra-tile S2
subject to con17: Lat_comp_S3_intra_tile = IL_par_S3 + IL_seq_S3 * log(TC6_1)/log(2); # latency of the intra-tile S3
subject to con18: perm1_S1 = 0; # because of the fused task 1
subject to con19: perm1_S3 = 0; # because of the fused task 2
subject to con20: perm0_S1 = perm0_S2; # same iteration of output in FT 1
subject to con21: is_fused_task0_in_SLR_0 * (footprint_A_S0_reuse + footprint_u1_S0_reuse + footprint_e1_S0_reuse + footprint_u2_S0_reuse + footprint_e2_S0_reuse) + is_fused_task1_in_SLR_0 * (footprint_A_S1_reuse + footprint_x_S1_S2_reuse + footprint_y_S1_reuse + footprint_z_S2_reuse) + is_fused_task2_in_SLR_0 * (footprint_A_S3_reuse + footprint_x_S3_reuse + footprint_w_S3_reuse) <= SLR0_mem; # memory constraint per SLR
subject to con22: is_fused_task0_in_SLR_1 * (footprint_A_S0_reuse + footprint_u1_S0_reuse + footprint_e1_S0_reuse + footprint_u2_S0_reuse + footprint_e2_S0_reuse) + is_fused_task1_in_SLR_1 * (footprint_A_S1_reuse + footprint_x_S1_S2_reuse + footprint_y_S1_reuse + footprint_z_S2_reuse) + is_fused_task2_in_SLR_1 * (footprint_A_S3_reuse + footprint_x_S3_reuse + footprint_w_S3_reuse) <= SLR1_mem; # memory constraint per SLR
subject to con23: is_fused_task0_in_SLR_2 * (footprint_A_S0_reuse + footprint_u1_S0_reuse + footprint_e1_S0_reuse + footprint_u2_S0_reuse + footprint_e2_S0_reuse) + is_fused_task1_in_SLR_2 * (footprint_A_S1_reuse + footprint_x_S1_S2_reuse + footprint_y_S1_reuse + footprint_z_S2_reuse) + is_fused_task2_in_SLR_2 * (footprint_A_S3_reuse + footprint_x_S3_reuse + footprint_w_S3_reuse) <= SLR2_mem; # memory constraint per SLR
subject to con24: level_reuse_A_FT0_under0 = level_transfer_A_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con25: level_reuse_A_FT0_under2 = 1; # transfer innermost for output
subject to con26: level_reuse_A_FT0_under1 = level_transfer_A_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con27: level_reuse_A_FT0_under2 = level_transfer_A_FT0_under2; # reuse level have to be outermost or equal to transfer
subject to con28: level_transfer_A_FT0_under0 + level_transfer_A_FT0_under1 + level_transfer_A_FT0_under2 = 1; # only one level of transfer for A
subject to con29: level_reuse_A_FT0_under0 + level_reuse_A_FT0_under1 + level_reuse_A_FT0_under2 = 1; # only one level of reuse for A
subject to con30: level_reuse_u1_FT0_under0 >= level_transfer_u1_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con31: level_reuse_u1_FT0_under0 + level_reuse_u1_FT0_under1 >= level_transfer_u1_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con32: level_reuse_u1_FT0_under0 + level_reuse_u1_FT0_under1 + level_reuse_u1_FT0_under2 >= level_transfer_u1_FT0_under2; # reuse level have to be outermost or equal to transfer
subject to con33: level_transfer_u1_FT0_under0 + level_transfer_u1_FT0_under1 + level_transfer_u1_FT0_under2 = 1; # only one level of transfer for u1
subject to con34: level_reuse_u1_FT0_under0 + level_reuse_u1_FT0_under1 + level_reuse_u1_FT0_under2 = 1; # only one level of reuse for u1
subject to con35: level_reuse_e1_FT0_under0 >= level_transfer_e1_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con36: level_reuse_e1_FT0_under0 + level_reuse_e1_FT0_under1 >= level_transfer_e1_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con37: level_reuse_e1_FT0_under0 + level_reuse_e1_FT0_under1 + level_reuse_e1_FT0_under2 >= level_transfer_e1_FT0_under2; # reuse level have to be outermost or equal to transfer
subject to con38: level_transfer_e1_FT0_under0 + level_transfer_e1_FT0_under1 + level_transfer_e1_FT0_under2 = 1; # only one level of transfer for e1
subject to con39: level_reuse_e1_FT0_under0 + level_reuse_e1_FT0_under1 + level_reuse_e1_FT0_under2 = 1; # only one level of reuse for e1
subject to con40: level_reuse_u2_FT0_under0 >= level_transfer_u2_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con41: level_reuse_u2_FT0_under0 + level_reuse_u2_FT0_under1 >= level_transfer_u2_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con42: level_reuse_u2_FT0_under0 + level_reuse_u2_FT0_under1 + level_reuse_u2_FT0_under2 >= level_transfer_u2_FT0_under2; # reuse level have to be outermost or equal to transfer
subject to con43: level_transfer_u2_FT0_under0 + level_transfer_u2_FT0_under1 + level_transfer_u2_FT0_under2 = 1; # only one level of transfer for u2
subject to con44: level_reuse_u2_FT0_under0 + level_reuse_u2_FT0_under1 + level_reuse_u2_FT0_under2 = 1; # only one level of reuse for u2
subject to con45: level_reuse_e2_FT0_under0 >= level_transfer_e2_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con46: level_reuse_e2_FT0_under0 + level_reuse_e2_FT0_under1 >= level_transfer_e2_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con47: level_reuse_e2_FT0_under0 + level_reuse_e2_FT0_under1 + level_reuse_e2_FT0_under2 >= level_transfer_e2_FT0_under2; # reuse level have to be outermost or equal to transfer
subject to con48: level_transfer_e2_FT0_under0 + level_transfer_e2_FT0_under1 + level_transfer_e2_FT0_under2 = 1; # only one level of transfer for e2
subject to con49: level_reuse_e2_FT0_under0 + level_reuse_e2_FT0_under1 + level_reuse_e2_FT0_under2 = 1; # only one level of reuse for e2
subject to con50: Lat_comp_fused_S0_3 = ((Lat_comp_S0_intra_tile)); # latency of the fused task S0 level 3
subject to con51: Lat_comp_fused_S0_2 = (perm0_S0 * TC1_0 + perm1_S0 * TC0_0) * max(Lat_comp_fused_S0_3, level_transfer_A_FT0_under2 * footprint_A_S0 / burst_A, level_transfer_u1_FT0_under2 * footprint_u1_S0 / burst_u1, level_transfer_e1_FT0_under2 * footprint_e1_S0 / burst_e1, level_transfer_u2_FT0_under2 * footprint_u2_S0 / burst_u2, level_transfer_e2_FT0_under2 * footprint_e2_S0 / burst_e2) + Lat_comp_fused_S0_3 + max(level_transfer_A_FT0_under2 * footprint_A_S0 / burst_A, level_transfer_u1_FT0_under2 * footprint_u1_S0 / burst_u1, level_transfer_e1_FT0_under2 * footprint_e1_S0 / burst_e1, level_transfer_u2_FT0_under2 * footprint_u2_S0 / burst_u2, level_transfer_e2_FT0_under2 * footprint_e2_S0 / burst_e2  + level_transfer_A_FT0_under2 * footprint_A_S0 / burst_A); # latency of the fused task S0 level 2
subject to con52: Lat_comp_fused_S0_1 = (perm0_S0 * TC0_0 + perm1_S0 * TC1_0) * max(Lat_comp_fused_S0_2, level_transfer_A_FT0_under1 * footprint_A_S0 / burst_A, level_transfer_u1_FT0_under1 * footprint_u1_S0 / burst_u1, level_transfer_e1_FT0_under1 * footprint_e1_S0 / burst_e1, level_transfer_u2_FT0_under1 * footprint_u2_S0 / burst_u2, level_transfer_e2_FT0_under1 * footprint_e2_S0 / burst_e2) + Lat_comp_fused_S0_2 + max(level_transfer_A_FT0_under1 * footprint_A_S0 / burst_A, level_transfer_u1_FT0_under1 * footprint_u1_S0 / burst_u1, level_transfer_e1_FT0_under1 * footprint_e1_S0 / burst_e1, level_transfer_u2_FT0_under1 * footprint_u2_S0 / burst_u2, level_transfer_e2_FT0_under1 * footprint_e2_S0 / burst_e2  + level_transfer_A_FT0_under1 * footprint_A_S0 / burst_A); # latency of the fused task S0 level 1
subject to con53: Lat_comp_fused_S0 = Lat_comp_fused_S0_1 + level_transfer_A_FT0_under0 * footprint_tot_A_FT0 / burst_A + level_transfer_u1_FT0_under0 * footprint_tot_u1_FT0 / burst_u1 + level_transfer_e1_FT0_under0 * footprint_tot_e1_FT0 / burst_e1 + level_transfer_u2_FT0_under0 * footprint_tot_u2_FT0 / burst_u2 + level_transfer_e2_FT0_under0 * footprint_tot_e2_FT0 / burst_e2; # latency of the fused task S0
subject to con54: level_reuse_x_FT1_under0 = level_transfer_x_FT1_under0; # reuse level have to be outermost or equal to transfer
subject to con55: level_reuse_x_FT1_under1 = 1; # transfer innermost for output
subject to con56: level_reuse_x_FT1_under1 = level_transfer_x_FT1_under1; # reuse level have to be outermost or equal to transfer
subject to con57: level_transfer_x_FT1_under0 + level_transfer_x_FT1_under1 = 1; # only one level of transfer for x
subject to con58: level_reuse_x_FT1_under0 + level_reuse_x_FT1_under1 = 1; # only one level of reuse for x
subject to con59: level_reuse_A_FT1_under0 = level_transfer_A_FT1_under0; # reuse level have to be outermost or equal to transfer
subject to con60: level_reuse_A_FT1_under1 = level_transfer_A_FT1_under1; # reuse level have to be outermost or equal to transfer
subject to con61: level_transfer_A_FT1_under0 + level_transfer_A_FT1_under1 = 1; # only one level of transfer for A
subject to con62: level_reuse_A_FT1_under0 + level_reuse_A_FT1_under1 = 1; # only one level of reuse for A
subject to con63: level_reuse_y_FT1_under0 >= level_transfer_y_FT1_under0; # reuse level have to be outermost or equal to transfer
subject to con64: level_reuse_y_FT1_under0 + level_reuse_y_FT1_under1 >= level_transfer_y_FT1_under1; # reuse level have to be outermost or equal to transfer
subject to con65: level_transfer_y_FT1_under0 + level_transfer_y_FT1_under1 = 1; # only one level of transfer for y
subject to con66: level_reuse_y_FT1_under0 + level_reuse_y_FT1_under1 = 1; # only one level of reuse for y
subject to con67: level_reuse_x_FT1_under0 = level_transfer_x_FT1_under0; # reuse level have to be outermost or equal to transfer
subject to con68: level_reuse_x_FT1_under1 = level_transfer_x_FT1_under1; # reuse level have to be outermost or equal to transfer
subject to con69: level_reuse_z_FT1_under0 = level_transfer_z_FT1_under0; # reuse level have to be outermost or equal to transfer
subject to con70: level_reuse_z_FT1_under1 = level_transfer_z_FT1_under1; # reuse level have to be outermost or equal to transfer
subject to con71: level_transfer_z_FT1_under0 + level_transfer_z_FT1_under1 = 1; # only one level of transfer for z
subject to con72: level_reuse_z_FT1_under0 + level_reuse_z_FT1_under1 = 1; # only one level of reuse for z
subject to con73: Lat_comp_fused_S1_S2_2 = ((Lat_comp_S1_intra_tile + II_S1_seq * TC3_0) + (Lat_comp_S2_intra_tile)); # latency of the fused task S1_S2 level 2
subject to con74: Lat_comp_fused_S1_S2_1 = (perm0_S1 * TC2_0 + perm1_S1 * TC3_0) * max(Lat_comp_fused_S1_S2_2, level_transfer_x_FT1_under1 * footprint_x_S1_S2 / burst_x, level_transfer_A_FT1_under1 * footprint_A_S1 / burst_A, level_transfer_y_FT1_under1 * footprint_y_S1 / burst_y, level_transfer_z_FT1_under1 * footprint_z_S2 / burst_z) + Lat_comp_fused_S1_S2_2 + max(level_transfer_x_FT1_under1 * footprint_x_S1_S2 / burst_x, level_transfer_A_FT1_under1 * footprint_A_S1 / burst_A, level_transfer_y_FT1_under1 * footprint_y_S1 / burst_y, level_transfer_z_FT1_under1 * footprint_z_S2 / burst_z  + level_transfer_x_FT1_under1 * footprint_x_S1_S2 / burst_x); # latency of the fused task S1_S2 level 1
subject to con75: Lat_comp_fused_S1_S2 = Lat_comp_fused_S1_S2_1 + level_transfer_x_FT1_under0 * footprint_tot_x_FT1 / burst_x + level_transfer_A_FT1_under0 * footprint_tot_A_FT1 / burst_A + level_transfer_y_FT1_under0 * footprint_tot_y_FT1 / burst_y + level_transfer_z_FT1_under0 * footprint_tot_z_FT1 / burst_z; # latency of the fused task S1_S2
subject to con76: level_reuse_w_FT2_under0 = level_transfer_w_FT2_under0; # reuse level have to be outermost or equal to transfer
subject to con77: level_reuse_w_FT2_under1 = 1; # transfer innermost for output
subject to con78: level_reuse_w_FT2_under1 = level_transfer_w_FT2_under1; # reuse level have to be outermost or equal to transfer
subject to con79: level_transfer_w_FT2_under0 + level_transfer_w_FT2_under1 = 1; # only one level of transfer for w
subject to con80: level_reuse_w_FT2_under0 + level_reuse_w_FT2_under1 = 1; # only one level of reuse for w
subject to con81: level_reuse_A_FT2_under0 = level_transfer_A_FT2_under0; # reuse level have to be outermost or equal to transfer
subject to con82: level_reuse_A_FT2_under1 = level_transfer_A_FT2_under1; # reuse level have to be outermost or equal to transfer
subject to con83: level_transfer_A_FT2_under0 + level_transfer_A_FT2_under1 = 1; # only one level of transfer for A
subject to con84: level_reuse_A_FT2_under0 + level_reuse_A_FT2_under1 = 1; # only one level of reuse for A
subject to con85: level_reuse_x_FT2_under0 >= level_transfer_x_FT2_under0; # reuse level have to be outermost or equal to transfer
subject to con86: level_reuse_x_FT2_under0 + level_reuse_x_FT2_under1 >= level_transfer_x_FT2_under1; # reuse level have to be outermost or equal to transfer
subject to con87: level_transfer_x_FT2_under0 + level_transfer_x_FT2_under1 = 1; # only one level of transfer for x
subject to con88: level_reuse_x_FT2_under0 + level_reuse_x_FT2_under1 = 1; # only one level of reuse for x
subject to con89: Lat_comp_fused_S3_2 = ((Lat_comp_S3_intra_tile + II_S3_seq * TC6_0)); # latency of the fused task S3 level 2
subject to con90: Lat_comp_fused_S3_1 = (perm0_S3 * TC5_0 + perm1_S3 * TC6_0) * max(Lat_comp_fused_S3_2, level_transfer_w_FT2_under1 * footprint_w_S3 / burst_w, level_transfer_A_FT2_under1 * footprint_A_S3 / burst_A, level_transfer_x_FT2_under1 * footprint_x_S3 / burst_x) + Lat_comp_fused_S3_2 + max(level_transfer_w_FT2_under1 * footprint_w_S3 / burst_w, level_transfer_A_FT2_under1 * footprint_A_S3 / burst_A, level_transfer_x_FT2_under1 * footprint_x_S3 / burst_x  + level_transfer_w_FT2_under1 * footprint_w_S3 / burst_w); # latency of the fused task S3 level 1
subject to con91: Lat_comp_fused_S3 = Lat_comp_fused_S3_1 + level_transfer_w_FT2_under0 * footprint_tot_w_FT2 / burst_w + level_transfer_A_FT2_under0 * footprint_tot_A_FT2 / burst_A + level_transfer_x_FT2_under0 * footprint_tot_x_FT2 / burst_x; # latency of the fused task S3
subject to con92: footprint_A_S0 = level_transfer_A_FT0_under0 * footprint_tot_A_FT0 + level_transfer_A_FT0_under1 * (perm0_S0 * footprint_tot_A_FT0/ TC0_0 + perm1_S0 * footprint_tot_A_FT0/ TC1_0) + level_transfer_A_FT0_under2 * (perm0_S0 * footprint_tot_A_FT0/ TC0_0/ TC1_0 + perm1_S0 * footprint_tot_A_FT0/ TC1_0/ TC0_0); # footprint of the array A for the fused task 0
subject to con93: footprint_A_S0_reuse = level_reuse_A_FT0_under0 * footprint_tot_A_FT0 + level_reuse_A_FT0_under1 * (perm0_S0 * footprint_tot_A_FT0/ TC0_0 + perm1_S0 * footprint_tot_A_FT0/ TC1_0) + level_reuse_A_FT0_under2 * (perm0_S0 * footprint_tot_A_FT0/ TC0_0/ TC1_0 + perm1_S0 * footprint_tot_A_FT0/ TC1_0/ TC0_0); # footprint of the array A for the fused task 0
subject to con94: perm1_S0 * level_transfer_u1_FT0_under1 = 0; # useless to transfer under this loop
subject to con95: perm1_S0 * level_reuse_u1_FT0_under1 = 0; # useless to reuse under this loop
subject to con96: perm0_S0 * level_transfer_u1_FT0_under2 = 0; # useless to transfer under this loop
subject to con97: perm0_S0 * level_reuse_u1_FT0_under2 = 0; # useless to reuse under this loop
subject to con98: footprint_u1_S0 = level_transfer_u1_FT0_under0 * footprint_tot_u1_FT0 + level_transfer_u1_FT0_under1 * (perm0_S0 * footprint_tot_u1_FT0/ TC0_0 + perm1_S0 * footprint_tot_u1_FT0) + level_transfer_u1_FT0_under2 * (perm0_S0 * footprint_tot_u1_FT0/ TC0_0 + perm1_S0 * footprint_tot_u1_FT0/ TC0_0); # footprint of the array u1 for the fused task 0
subject to con99: footprint_u1_S0_reuse = level_reuse_u1_FT0_under0 * footprint_tot_u1_FT0 + level_reuse_u1_FT0_under1 * (perm0_S0 * footprint_tot_u1_FT0/ TC0_0 + perm1_S0 * footprint_tot_u1_FT0) + level_reuse_u1_FT0_under2 * (perm0_S0 * footprint_tot_u1_FT0/ TC0_0 + perm1_S0 * footprint_tot_u1_FT0/ TC0_0); # footprint of the array u1 for the fused task 0
subject to con100: perm0_S0 * level_transfer_e1_FT0_under1 = 0; # useless to transfer under this loop
subject to con101: perm0_S0 * level_reuse_e1_FT0_under1 = 0; # useless to reuse under this loop
subject to con102: perm1_S0 * level_transfer_e1_FT0_under2 = 0; # useless to transfer under this loop
subject to con103: perm1_S0 * level_reuse_e1_FT0_under2 = 0; # useless to reuse under this loop
subject to con104: footprint_e1_S0 = level_transfer_e1_FT0_under0 * footprint_tot_e1_FT0 + level_transfer_e1_FT0_under1 * (perm0_S0 * footprint_tot_e1_FT0 + perm1_S0 * footprint_tot_e1_FT0/ TC1_0) + level_transfer_e1_FT0_under2 * (perm0_S0 * footprint_tot_e1_FT0/ TC1_0 + perm1_S0 * footprint_tot_e1_FT0/ TC1_0); # footprint of the array e1 for the fused task 0
subject to con105: footprint_e1_S0_reuse = level_reuse_e1_FT0_under0 * footprint_tot_e1_FT0 + level_reuse_e1_FT0_under1 * (perm0_S0 * footprint_tot_e1_FT0 + perm1_S0 * footprint_tot_e1_FT0/ TC1_0) + level_reuse_e1_FT0_under2 * (perm0_S0 * footprint_tot_e1_FT0/ TC1_0 + perm1_S0 * footprint_tot_e1_FT0/ TC1_0); # footprint of the array e1 for the fused task 0
subject to con106: perm1_S0 * level_transfer_u2_FT0_under1 = 0; # useless to transfer under this loop
subject to con107: perm1_S0 * level_reuse_u2_FT0_under1 = 0; # useless to reuse under this loop
subject to con108: perm0_S0 * level_transfer_u2_FT0_under2 = 0; # useless to transfer under this loop
subject to con109: perm0_S0 * level_reuse_u2_FT0_under2 = 0; # useless to reuse under this loop
subject to con110: footprint_u2_S0 = level_transfer_u2_FT0_under0 * footprint_tot_u2_FT0 + level_transfer_u2_FT0_under1 * (perm0_S0 * footprint_tot_u2_FT0/ TC0_0 + perm1_S0 * footprint_tot_u2_FT0) + level_transfer_u2_FT0_under2 * (perm0_S0 * footprint_tot_u2_FT0/ TC0_0 + perm1_S0 * footprint_tot_u2_FT0/ TC0_0); # footprint of the array u2 for the fused task 0
subject to con111: footprint_u2_S0_reuse = level_reuse_u2_FT0_under0 * footprint_tot_u2_FT0 + level_reuse_u2_FT0_under1 * (perm0_S0 * footprint_tot_u2_FT0/ TC0_0 + perm1_S0 * footprint_tot_u2_FT0) + level_reuse_u2_FT0_under2 * (perm0_S0 * footprint_tot_u2_FT0/ TC0_0 + perm1_S0 * footprint_tot_u2_FT0/ TC0_0); # footprint of the array u2 for the fused task 0
subject to con112: perm0_S0 * level_transfer_e2_FT0_under1 = 0; # useless to transfer under this loop
subject to con113: perm0_S0 * level_reuse_e2_FT0_under1 = 0; # useless to reuse under this loop
subject to con114: perm1_S0 * level_transfer_e2_FT0_under2 = 0; # useless to transfer under this loop
subject to con115: perm1_S0 * level_reuse_e2_FT0_under2 = 0; # useless to reuse under this loop
subject to con116: footprint_e2_S0 = level_transfer_e2_FT0_under0 * footprint_tot_e2_FT0 + level_transfer_e2_FT0_under1 * (perm0_S0 * footprint_tot_e2_FT0 + perm1_S0 * footprint_tot_e2_FT0/ TC1_0) + level_transfer_e2_FT0_under2 * (perm0_S0 * footprint_tot_e2_FT0/ TC1_0 + perm1_S0 * footprint_tot_e2_FT0/ TC1_0); # footprint of the array e2 for the fused task 0
subject to con117: footprint_e2_S0_reuse = level_reuse_e2_FT0_under0 * footprint_tot_e2_FT0 + level_reuse_e2_FT0_under1 * (perm0_S0 * footprint_tot_e2_FT0 + perm1_S0 * footprint_tot_e2_FT0/ TC1_0) + level_reuse_e2_FT0_under2 * (perm0_S0 * footprint_tot_e2_FT0/ TC1_0 + perm1_S0 * footprint_tot_e2_FT0/ TC1_0); # footprint of the array e2 for the fused task 0
subject to con118: footprint_A_S1 = level_transfer_A_FT1_under0 * footprint_tot_A_FT1 + level_transfer_A_FT1_under1 * (perm0_S1 * footprint_tot_A_FT1/ TC2_0 + perm1_S1 * footprint_tot_A_FT1/ TC3_0); # footprint of the array A for the fused task 1
subject to con119: footprint_A_S1_reuse = level_reuse_A_FT1_under0 * footprint_tot_A_FT1 + level_reuse_A_FT1_under1 * (perm0_S1 * footprint_tot_A_FT1/ TC2_0 + perm1_S1 * footprint_tot_A_FT1/ TC3_0); # footprint of the array A for the fused task 1
subject to con120: perm1_S1 * level_transfer_x_FT1_under1 = 0; # useless to transfer under this loop
subject to con121: perm1_S1 * level_reuse_x_FT1_under1 = 0; # useless to reuse under this loop
subject to con122: footprint_x_S1_S2 = level_transfer_x_FT1_under0 * footprint_tot_x_FT1 + level_transfer_x_FT1_under1 * (perm0_S1 * footprint_tot_x_FT1/ TC2_0 + perm1_S1 * footprint_tot_x_FT1); # footprint of the array x for the fused task 1
subject to con123: footprint_x_S1_S2_reuse = level_reuse_x_FT1_under0 * footprint_tot_x_FT1 + level_reuse_x_FT1_under1 * (perm0_S1 * footprint_tot_x_FT1/ TC2_0 + perm1_S1 * footprint_tot_x_FT1); # footprint of the array x for the fused task 1
subject to con124: perm0_S1 * level_transfer_y_FT1_under1 = 0; # useless to transfer under this loop
subject to con125: perm0_S1 * level_reuse_y_FT1_under1 = 0; # useless to reuse under this loop
subject to con126: footprint_y_S1 = level_transfer_y_FT1_under0 * footprint_tot_y_FT1 + level_transfer_y_FT1_under1 * (perm0_S1 * footprint_tot_y_FT1 + perm1_S1 * footprint_tot_y_FT1/ TC3_0); # footprint of the array y for the fused task 1
subject to con127: footprint_y_S1_reuse = level_reuse_y_FT1_under0 * footprint_tot_y_FT1 + level_reuse_y_FT1_under1 * (perm0_S1 * footprint_tot_y_FT1 + perm1_S1 * footprint_tot_y_FT1/ TC3_0); # footprint of the array y for the fused task 1
subject to con128: footprint_z_S2 = level_transfer_z_FT1_under0 * footprint_tot_z_FT1 + level_transfer_z_FT1_under1 * (perm0_S2 * footprint_tot_z_FT1/ TC4_0); # footprint of the array z for the fused task 1
subject to con129: footprint_z_S2_reuse = level_reuse_z_FT1_under0 * footprint_tot_z_FT1 + level_reuse_z_FT1_under1 * (perm0_S2 * footprint_tot_z_FT1/ TC4_0); # footprint of the array z for the fused task 1
subject to con130: footprint_A_S3 = level_transfer_A_FT2_under0 * footprint_tot_A_FT2 + level_transfer_A_FT2_under1 * (perm0_S3 * footprint_tot_A_FT2/ TC5_0 + perm1_S3 * footprint_tot_A_FT2/ TC6_0); # footprint of the array A for the fused task 2
subject to con131: footprint_A_S3_reuse = level_reuse_A_FT2_under0 * footprint_tot_A_FT2 + level_reuse_A_FT2_under1 * (perm0_S3 * footprint_tot_A_FT2/ TC5_0 + perm1_S3 * footprint_tot_A_FT2/ TC6_0); # footprint of the array A for the fused task 2
subject to con132: perm0_S3 * level_transfer_x_FT2_under1 = 0; # useless to transfer under this loop
subject to con133: perm0_S3 * level_reuse_x_FT2_under1 = 0; # useless to reuse under this loop
subject to con134: footprint_x_S3 = level_transfer_x_FT2_under0 * footprint_tot_x_FT2 + level_transfer_x_FT2_under1 * (perm0_S3 * footprint_tot_x_FT2 + perm1_S3 * footprint_tot_x_FT2/ TC6_0); # footprint of the array x for the fused task 2
subject to con135: footprint_x_S3_reuse = level_reuse_x_FT2_under0 * footprint_tot_x_FT2 + level_reuse_x_FT2_under1 * (perm0_S3 * footprint_tot_x_FT2 + perm1_S3 * footprint_tot_x_FT2/ TC6_0); # footprint of the array x for the fused task 2
subject to con136: perm1_S3 * level_transfer_w_FT2_under1 = 0; # useless to transfer under this loop
subject to con137: perm1_S3 * level_reuse_w_FT2_under1 = 0; # useless to reuse under this loop
subject to con138: footprint_w_S3 = level_transfer_w_FT2_under0 * footprint_tot_w_FT2 + level_transfer_w_FT2_under1 * (perm0_S3 * footprint_tot_w_FT2/ TC5_0 + perm1_S3 * footprint_tot_w_FT2); # footprint of the array w for the fused task 2
subject to con139: footprint_w_S3_reuse = level_reuse_w_FT2_under0 * footprint_tot_w_FT2 + level_reuse_w_FT2_under1 * (perm0_S3 * footprint_tot_w_FT2/ TC5_0 + perm1_S3 * footprint_tot_w_FT2); # footprint of the array w for the fused task 2
subject to con140: shift_0_to_1 = ( + Lat_comp_S0_intra_tile + footprint_A_S0) * footprint_A_S1 / footprint_A_S0;
subject to con141: shift_0_to_2 = ( + Lat_comp_S0_intra_tile + footprint_A_S0) * footprint_A_S3 / footprint_A_S0;
subject to con142: shift_1_to_2 = ( + Lat_comp_S1_intra_tile + II_S1_seq * TC3_0 + Lat_comp_S2_intra_tile + footprint_x_S1_S2) * footprint_x_S3 / footprint_x_S1_S2;
subject to con143: TC0_1 * TC1_1 <= MAX_UF;
subject to con144: TC2_1 * TC3_1 <= MAX_UF;
subject to con145: TC4_1 <= MAX_UF;
subject to con146: TC5_1 * TC6_1 <= MAX_UF;
subject to con147: TC0_1 * TC1_1 * DSP_S0  + TC2_1 * TC3_1 * DSP_S1 / II_S1_seq + TC4_1 * DSP_S2  + TC5_1 * TC6_1 * DSP_S3 / II_S3_seq <= DSP_avail; # DSP constraint
subject to con148: nb_dsp_used_SLR0 = is_fused_task0_in_SLR_0 * (TC0_1 * TC1_1 * DSP_S0) + is_fused_task1_in_SLR_0 * (TC2_1 * TC3_1 * DSP_S1 / II_S1_seq + TC4_1 * DSP_S2) + is_fused_task2_in_SLR_0 * (TC5_1 * TC6_1 * DSP_S3 / II_S3_seq); # DSP constraint per SLR
subject to con149: nb_dsp_used_SLR0 <= SLR0_DSP; # DSP constraint per SLR
subject to con150: nb_dsp_used_SLR1 = is_fused_task0_in_SLR_1 * (TC0_1 * TC1_1 * DSP_S0) + is_fused_task1_in_SLR_1 * (TC2_1 * TC3_1 * DSP_S1 / II_S1_seq + TC4_1 * DSP_S2) + is_fused_task2_in_SLR_1 * (TC5_1 * TC6_1 * DSP_S3 / II_S3_seq); # DSP constraint per SLR
subject to con151: nb_dsp_used_SLR1 <= SLR1_DSP; # DSP constraint per SLR
subject to con152: nb_dsp_used_SLR2 = is_fused_task0_in_SLR_2 * (TC0_1 * TC1_1 * DSP_S0) + is_fused_task1_in_SLR_2 * (TC2_1 * TC3_1 * DSP_S1 / II_S1_seq + TC4_1 * DSP_S2) + is_fused_task2_in_SLR_2 * (TC5_1 * TC6_1 * DSP_S3 / II_S3_seq); # DSP constraint per SLR
subject to con153: nb_dsp_used_SLR2 <= SLR2_DSP; # DSP constraint per SLR
subject to con154: TC0_1 * TC1_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array A 
subject to con155: TC0_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array u1 
subject to con156: TC1_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array e1 
subject to con157: TC0_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array u2 
subject to con158: TC1_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array e2 
subject to con159: TC2_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array x 
subject to con160: TC4_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array x 
subject to con161: TC3_1 * TC2_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array A 
subject to con162: TC3_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array y 
subject to con163: TC4_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array z 
subject to con164: TC5_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array w 
subject to con165: TC5_1 * TC6_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array A 
subject to con166: TC6_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array x 
subject to con167: Lat_comp_S3_for_off_chip = perm0_S3 * TC6_0 * II_S3_seq + perm1_S3 * TC6_0 * TC5_0 * II_S3_par; # stall between task
subject to con168: TC0_0 <= TC0; # TC of split loop
subject to con169: TC0_1 <= TC0; # TC of split loop
subject to con170: TC0_0 * TC0_1 = TC0; # product of the TC of split loop = original TC
subject to con171: TC1_0 <= TC1; # TC of split loop
subject to con172: TC1_1 <= TC1; # TC of split loop
subject to con173: TC1_0 * TC1_1 = TC1; # product of the TC of split loop = original TC
subject to con174: TC2_0 <= TC2; # TC of split loop
subject to con175: TC2_1 <= TC2; # TC of split loop
subject to con176: TC2_0 * TC2_1 = TC2; # product of the TC of split loop = original TC
subject to con177: TC3_0 <= TC3; # TC of split loop
subject to con178: TC3_1 <= TC3; # TC of split loop
subject to con179: TC3_0 * TC3_1 = TC3; # product of the TC of split loop = original TC
subject to con180: TC4_0 <= TC4; # TC of split loop
subject to con181: TC4_1 <= TC4; # TC of split loop
subject to con182: TC4_0 * TC4_1 = TC4; # product of the TC of split loop = original TC
subject to con183: TC5_0 <= TC5; # TC of split loop
subject to con184: TC5_1 <= TC5; # TC of split loop
subject to con185: TC5_0 * TC5_1 = TC5; # product of the TC of split loop = original TC
subject to con186: TC6_0 <= TC6; # TC of split loop
subject to con187: TC6_1 <= TC6; # TC of split loop
subject to con188: TC6_0 * TC6_1 = TC6; # product of the TC of split loop = original TC
subject to con189: TC2_1 = TC4_1; # same intra tile for the same dimension of the array x in the fused task
subject to con190: e1_is_fully_transfered_on_last_dim_FT0 = level_transfer_e1_FT0_under0 + perm0_S0 * (level_transfer_e1_FT0_under1); # the array e1 is fully transfered on the last dimension
subject to con191: burst_e1_is_1 * cte_0 * 1 = burst_e1_is_1 * ((1-is_tc1_burst_witout_tiling_for_e1) * (TC1_1 * (1-e1_is_fully_transfered_on_last_dim_FT0) + TC1 * (e1_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e1 * (cte_burst_without_tiling_TC1_for_e1 + TC1));
subject to con192: is_tc1_burst_witout_tiling_for_e1 =  min(1, cte_burst_without_tiling_TC1_for_e1);
subject to con193: burst_e1_is_2 * cte_1 * 2 = burst_e1_is_2 * ((1-is_tc1_burst_witout_tiling_for_e1) * (TC1_1 * (1-e1_is_fully_transfered_on_last_dim_FT0) + TC1 * (e1_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e1 * (cte_burst_without_tiling_TC1_for_e1 + TC1));
subject to con194: burst_e1_is_4 * cte_2 * 4 = burst_e1_is_4 * ((1-is_tc1_burst_witout_tiling_for_e1) * (TC1_1 * (1-e1_is_fully_transfered_on_last_dim_FT0) + TC1 * (e1_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e1 * (cte_burst_without_tiling_TC1_for_e1 + TC1));
subject to con195: burst_e1_is_8 * cte_3 * 8 = burst_e1_is_8 * ((1-is_tc1_burst_witout_tiling_for_e1) * (TC1_1 * (1-e1_is_fully_transfered_on_last_dim_FT0) + TC1 * (e1_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e1 * (cte_burst_without_tiling_TC1_for_e1 + TC1));
subject to con196: burst_e1_is_16 * cte_4 * 16 = burst_e1_is_16 * ((1-is_tc1_burst_witout_tiling_for_e1) * (TC1_1 * (1-e1_is_fully_transfered_on_last_dim_FT0) + TC1 * (e1_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e1 * (cte_burst_without_tiling_TC1_for_e1 + TC1));
subject to con197: burst_e1 = burst_e1_is_1 * 1 + burst_e1_is_2 * 2 + burst_e1_is_4 * 4 + burst_e1_is_8 * 8 + burst_e1_is_16 * 16; # burst size of the array e1
subject to con198: burst_e1_is_1 + burst_e1_is_2 + burst_e1_is_4 + burst_e1_is_8 + burst_e1_is_16 = 1; # only one burst size for the array e1
subject to con199: is_tc1_burst_witout_tiling_for_e1 <= e1_is_fully_transfered_on_last_dim_FT0;
subject to con200: e2_is_fully_transfered_on_last_dim_FT0 = level_transfer_e2_FT0_under0 + perm0_S0 * (level_transfer_e2_FT0_under1); # the array e2 is fully transfered on the last dimension
subject to con201: burst_e2_is_1 * cte_5 * 1 = burst_e2_is_1 * ((1-is_tc1_burst_witout_tiling_for_e2) * (TC1_1 * (1-e2_is_fully_transfered_on_last_dim_FT0) + TC1 * (e2_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e2 * (cte_burst_without_tiling_TC1_for_e2 + TC1));
subject to con202: is_tc1_burst_witout_tiling_for_e2 =  min(1, cte_burst_without_tiling_TC1_for_e2);
subject to con203: burst_e2_is_2 * cte_6 * 2 = burst_e2_is_2 * ((1-is_tc1_burst_witout_tiling_for_e2) * (TC1_1 * (1-e2_is_fully_transfered_on_last_dim_FT0) + TC1 * (e2_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e2 * (cte_burst_without_tiling_TC1_for_e2 + TC1));
subject to con204: burst_e2_is_4 * cte_7 * 4 = burst_e2_is_4 * ((1-is_tc1_burst_witout_tiling_for_e2) * (TC1_1 * (1-e2_is_fully_transfered_on_last_dim_FT0) + TC1 * (e2_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e2 * (cte_burst_without_tiling_TC1_for_e2 + TC1));
subject to con205: burst_e2_is_8 * cte_8 * 8 = burst_e2_is_8 * ((1-is_tc1_burst_witout_tiling_for_e2) * (TC1_1 * (1-e2_is_fully_transfered_on_last_dim_FT0) + TC1 * (e2_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e2 * (cte_burst_without_tiling_TC1_for_e2 + TC1));
subject to con206: burst_e2_is_16 * cte_9 * 16 = burst_e2_is_16 * ((1-is_tc1_burst_witout_tiling_for_e2) * (TC1_1 * (1-e2_is_fully_transfered_on_last_dim_FT0) + TC1 * (e2_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_e2 * (cte_burst_without_tiling_TC1_for_e2 + TC1));
subject to con207: burst_e2 = burst_e2_is_1 * 1 + burst_e2_is_2 * 2 + burst_e2_is_4 * 4 + burst_e2_is_8 * 8 + burst_e2_is_16 * 16; # burst size of the array e2
subject to con208: burst_e2_is_1 + burst_e2_is_2 + burst_e2_is_4 + burst_e2_is_8 + burst_e2_is_16 = 1; # only one burst size for the array e2
subject to con209: is_tc1_burst_witout_tiling_for_e2 <= e2_is_fully_transfered_on_last_dim_FT0;
subject to con210: y_is_fully_transfered_on_last_dim_FT1 = level_transfer_y_FT1_under0 + perm0_S1 * (level_transfer_y_FT1_under1); # the array y is fully transfered on the last dimension
subject to con211: burst_y_is_1 * cte_10 * 1 = burst_y_is_1 * ((1-is_tc3_burst_witout_tiling_for_y) * (TC3_1 * (1-y_is_fully_transfered_on_last_dim_FT1) + TC3 * (y_is_fully_transfered_on_last_dim_FT1)) + is_tc3_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC3_for_y + TC3));
subject to con212: is_tc3_burst_witout_tiling_for_y =  min(1, cte_burst_without_tiling_TC3_for_y);
subject to con213: burst_y_is_2 * cte_11 * 2 = burst_y_is_2 * ((1-is_tc3_burst_witout_tiling_for_y) * (TC3_1 * (1-y_is_fully_transfered_on_last_dim_FT1) + TC3 * (y_is_fully_transfered_on_last_dim_FT1)) + is_tc3_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC3_for_y + TC3));
subject to con214: burst_y_is_4 * cte_12 * 4 = burst_y_is_4 * ((1-is_tc3_burst_witout_tiling_for_y) * (TC3_1 * (1-y_is_fully_transfered_on_last_dim_FT1) + TC3 * (y_is_fully_transfered_on_last_dim_FT1)) + is_tc3_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC3_for_y + TC3));
subject to con215: burst_y_is_8 * cte_13 * 8 = burst_y_is_8 * ((1-is_tc3_burst_witout_tiling_for_y) * (TC3_1 * (1-y_is_fully_transfered_on_last_dim_FT1) + TC3 * (y_is_fully_transfered_on_last_dim_FT1)) + is_tc3_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC3_for_y + TC3));
subject to con216: burst_y_is_16 * cte_14 * 16 = burst_y_is_16 * ((1-is_tc3_burst_witout_tiling_for_y) * (TC3_1 * (1-y_is_fully_transfered_on_last_dim_FT1) + TC3 * (y_is_fully_transfered_on_last_dim_FT1)) + is_tc3_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC3_for_y + TC3));
subject to con217: burst_y = burst_y_is_1 * 1 + burst_y_is_2 * 2 + burst_y_is_4 * 4 + burst_y_is_8 * 8 + burst_y_is_16 * 16; # burst size of the array y
subject to con218: burst_y_is_1 + burst_y_is_2 + burst_y_is_4 + burst_y_is_8 + burst_y_is_16 = 1; # only one burst size for the array y
subject to con219: is_tc3_burst_witout_tiling_for_y <= y_is_fully_transfered_on_last_dim_FT1;
subject to con220: z_is_fully_transfered_on_last_dim_FT1 = level_transfer_z_FT1_under0; # the array z is fully transfered on the last dimension
subject to con221: burst_z_is_1 * cte_15 * 1 = burst_z_is_1 * ((1-is_tc4_burst_witout_tiling_for_z) * (TC4_1 * (1-z_is_fully_transfered_on_last_dim_FT1) + TC4 * (z_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_z * (cte_burst_without_tiling_TC4_for_z + TC4));
subject to con222: is_tc4_burst_witout_tiling_for_z =  min(1, cte_burst_without_tiling_TC4_for_z);
subject to con223: burst_z_is_2 * cte_16 * 2 = burst_z_is_2 * ((1-is_tc4_burst_witout_tiling_for_z) * (TC4_1 * (1-z_is_fully_transfered_on_last_dim_FT1) + TC4 * (z_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_z * (cte_burst_without_tiling_TC4_for_z + TC4));
subject to con224: burst_z_is_4 * cte_17 * 4 = burst_z_is_4 * ((1-is_tc4_burst_witout_tiling_for_z) * (TC4_1 * (1-z_is_fully_transfered_on_last_dim_FT1) + TC4 * (z_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_z * (cte_burst_without_tiling_TC4_for_z + TC4));
subject to con225: burst_z_is_8 * cte_18 * 8 = burst_z_is_8 * ((1-is_tc4_burst_witout_tiling_for_z) * (TC4_1 * (1-z_is_fully_transfered_on_last_dim_FT1) + TC4 * (z_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_z * (cte_burst_without_tiling_TC4_for_z + TC4));
subject to con226: burst_z_is_16 * cte_19 * 16 = burst_z_is_16 * ((1-is_tc4_burst_witout_tiling_for_z) * (TC4_1 * (1-z_is_fully_transfered_on_last_dim_FT1) + TC4 * (z_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_z * (cte_burst_without_tiling_TC4_for_z + TC4));
subject to con227: burst_z = burst_z_is_1 * 1 + burst_z_is_2 * 2 + burst_z_is_4 * 4 + burst_z_is_8 * 8 + burst_z_is_16 * 16; # burst size of the array z
subject to con228: burst_z_is_1 + burst_z_is_2 + burst_z_is_4 + burst_z_is_8 + burst_z_is_16 = 1; # only one burst size for the array z
subject to con229: is_tc4_burst_witout_tiling_for_z <= z_is_fully_transfered_on_last_dim_FT1;
subject to con230: u1_is_fully_transfered_on_last_dim_FT0 = level_transfer_u1_FT0_under0 + perm1_S0 * (level_transfer_u1_FT0_under1); # the array u1 is fully transfered on the last dimension
subject to con231: burst_u1_is_1 * cte_20 * 1 = burst_u1_is_1 * ((1-is_tc0_burst_witout_tiling_for_u1) * (TC0_1 * (1-u1_is_fully_transfered_on_last_dim_FT0) + TC0 * (u1_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u1 * (cte_burst_without_tiling_TC0_for_u1 + TC0));
subject to con232: is_tc0_burst_witout_tiling_for_u1 =  min(1, cte_burst_without_tiling_TC0_for_u1);
subject to con233: burst_u1_is_2 * cte_21 * 2 = burst_u1_is_2 * ((1-is_tc0_burst_witout_tiling_for_u1) * (TC0_1 * (1-u1_is_fully_transfered_on_last_dim_FT0) + TC0 * (u1_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u1 * (cte_burst_without_tiling_TC0_for_u1 + TC0));
subject to con234: burst_u1_is_4 * cte_22 * 4 = burst_u1_is_4 * ((1-is_tc0_burst_witout_tiling_for_u1) * (TC0_1 * (1-u1_is_fully_transfered_on_last_dim_FT0) + TC0 * (u1_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u1 * (cte_burst_without_tiling_TC0_for_u1 + TC0));
subject to con235: burst_u1_is_8 * cte_23 * 8 = burst_u1_is_8 * ((1-is_tc0_burst_witout_tiling_for_u1) * (TC0_1 * (1-u1_is_fully_transfered_on_last_dim_FT0) + TC0 * (u1_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u1 * (cte_burst_without_tiling_TC0_for_u1 + TC0));
subject to con236: burst_u1_is_16 * cte_24 * 16 = burst_u1_is_16 * ((1-is_tc0_burst_witout_tiling_for_u1) * (TC0_1 * (1-u1_is_fully_transfered_on_last_dim_FT0) + TC0 * (u1_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u1 * (cte_burst_without_tiling_TC0_for_u1 + TC0));
subject to con237: burst_u1 = burst_u1_is_1 * 1 + burst_u1_is_2 * 2 + burst_u1_is_4 * 4 + burst_u1_is_8 * 8 + burst_u1_is_16 * 16; # burst size of the array u1
subject to con238: burst_u1_is_1 + burst_u1_is_2 + burst_u1_is_4 + burst_u1_is_8 + burst_u1_is_16 = 1; # only one burst size for the array u1
subject to con239: is_tc0_burst_witout_tiling_for_u1 <= u1_is_fully_transfered_on_last_dim_FT0;
subject to con240: w_is_fully_transfered_on_last_dim_FT2 = level_transfer_w_FT2_under0 + perm1_S3 * (level_transfer_w_FT2_under1); # the array w is fully transfered on the last dimension
subject to con241: burst_w_is_1 * cte_25 * 1 = burst_w_is_1 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con242: is_tc5_burst_witout_tiling_for_w =  min(1, cte_burst_without_tiling_TC5_for_w);
subject to con243: burst_w_is_1 * cte_26 * 1 = burst_w_is_1 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con244: burst_w_is_2 * cte_27 * 2 = burst_w_is_2 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con245: burst_w_is_2 * cte_28 * 2 = burst_w_is_2 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con246: burst_w_is_4 * cte_29 * 4 = burst_w_is_4 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con247: burst_w_is_4 * cte_30 * 4 = burst_w_is_4 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con248: burst_w_is_8 * cte_31 * 8 = burst_w_is_8 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con249: burst_w_is_8 * cte_32 * 8 = burst_w_is_8 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con250: burst_w_is_16 * cte_33 * 16 = burst_w_is_16 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con251: burst_w_is_16 * cte_34 * 16 = burst_w_is_16 * ((1-is_tc5_burst_witout_tiling_for_w) * (TC5_1 * (1-w_is_fully_transfered_on_last_dim_FT2) + TC5 * (w_is_fully_transfered_on_last_dim_FT2)) + is_tc5_burst_witout_tiling_for_w * (cte_burst_without_tiling_TC5_for_w + TC5));
subject to con252: burst_w = burst_w_is_1 * 1 + burst_w_is_2 * 2 + burst_w_is_4 * 4 + burst_w_is_8 * 8 + burst_w_is_16 * 16; # burst size of the array w
subject to con253: burst_w_is_1 + burst_w_is_2 + burst_w_is_4 + burst_w_is_8 + burst_w_is_16 = 1; # only one burst size for the array w
subject to con254: is_tc5_burst_witout_tiling_for_w <= w_is_fully_transfered_on_last_dim_FT2;
subject to con255: A_is_fully_transfered_on_last_dim_FT0 = level_transfer_A_FT0_under0 + perm0_S0 * (level_transfer_A_FT0_under1); # the array A is fully transfered on the last dimension
subject to con256: A_is_fully_transfered_on_last_dim_FT1 = level_transfer_A_FT1_under0 + perm1_S1 * (level_transfer_A_FT1_under1); # the array A is fully transfered on the last dimension
subject to con257: A_is_fully_transfered_on_last_dim_FT2 = level_transfer_A_FT2_under0 + perm0_S3 * (level_transfer_A_FT2_under1); # the array A is fully transfered on the last dimension
subject to con258: burst_A_is_1 * cte_35 * 1 = burst_A_is_1 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con259: is_tc1_burst_witout_tiling_for_A =  min(1, cte_burst_without_tiling_TC1_for_A);
subject to con260: burst_A_is_1 * cte_36 * 1 = burst_A_is_1 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con261: burst_A_is_1 * cte_37 * 1 = burst_A_is_1 * ((1-is_tc2_burst_witout_tiling_for_A) * (TC2_1 * (1-A_is_fully_transfered_on_last_dim_FT1) + TC2 * (A_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC2_for_A + TC2));
subject to con262: is_tc2_burst_witout_tiling_for_A =  min(1, cte_burst_without_tiling_TC2_for_A);
subject to con263: burst_A_is_1 * cte_38 * 1 = burst_A_is_1 * ((1-is_tc6_burst_witout_tiling_for_A) * (TC6_1 * (1-A_is_fully_transfered_on_last_dim_FT2) + TC6 * (A_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC6_for_A + TC6));
subject to con264: is_tc6_burst_witout_tiling_for_A =  min(1, cte_burst_without_tiling_TC6_for_A);
subject to con265: burst_A_is_2 * cte_39 * 2 = burst_A_is_2 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con266: burst_A_is_2 * cte_40 * 2 = burst_A_is_2 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con267: burst_A_is_2 * cte_41 * 2 = burst_A_is_2 * ((1-is_tc2_burst_witout_tiling_for_A) * (TC2_1 * (1-A_is_fully_transfered_on_last_dim_FT1) + TC2 * (A_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC2_for_A + TC2));
subject to con268: burst_A_is_2 * cte_42 * 2 = burst_A_is_2 * ((1-is_tc6_burst_witout_tiling_for_A) * (TC6_1 * (1-A_is_fully_transfered_on_last_dim_FT2) + TC6 * (A_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC6_for_A + TC6));
subject to con269: burst_A_is_4 * cte_43 * 4 = burst_A_is_4 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con270: burst_A_is_4 * cte_44 * 4 = burst_A_is_4 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con271: burst_A_is_4 * cte_45 * 4 = burst_A_is_4 * ((1-is_tc2_burst_witout_tiling_for_A) * (TC2_1 * (1-A_is_fully_transfered_on_last_dim_FT1) + TC2 * (A_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC2_for_A + TC2));
subject to con272: burst_A_is_4 * cte_46 * 4 = burst_A_is_4 * ((1-is_tc6_burst_witout_tiling_for_A) * (TC6_1 * (1-A_is_fully_transfered_on_last_dim_FT2) + TC6 * (A_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC6_for_A + TC6));
subject to con273: burst_A_is_8 * cte_47 * 8 = burst_A_is_8 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con274: burst_A_is_8 * cte_48 * 8 = burst_A_is_8 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con275: burst_A_is_8 * cte_49 * 8 = burst_A_is_8 * ((1-is_tc2_burst_witout_tiling_for_A) * (TC2_1 * (1-A_is_fully_transfered_on_last_dim_FT1) + TC2 * (A_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC2_for_A + TC2));
subject to con276: burst_A_is_8 * cte_50 * 8 = burst_A_is_8 * ((1-is_tc6_burst_witout_tiling_for_A) * (TC6_1 * (1-A_is_fully_transfered_on_last_dim_FT2) + TC6 * (A_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC6_for_A + TC6));
subject to con277: burst_A_is_16 * cte_51 * 16 = burst_A_is_16 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con278: burst_A_is_16 * cte_52 * 16 = burst_A_is_16 * ((1-is_tc1_burst_witout_tiling_for_A) * (TC1_1 * (1-A_is_fully_transfered_on_last_dim_FT0) + TC1 * (A_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC1_for_A + TC1));
subject to con279: burst_A_is_16 * cte_53 * 16 = burst_A_is_16 * ((1-is_tc2_burst_witout_tiling_for_A) * (TC2_1 * (1-A_is_fully_transfered_on_last_dim_FT1) + TC2 * (A_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC2_for_A + TC2));
subject to con280: burst_A_is_16 * cte_54 * 16 = burst_A_is_16 * ((1-is_tc6_burst_witout_tiling_for_A) * (TC6_1 * (1-A_is_fully_transfered_on_last_dim_FT2) + TC6 * (A_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_A * (cte_burst_without_tiling_TC6_for_A + TC6));
subject to con281: burst_A = burst_A_is_1 * 1 + burst_A_is_2 * 2 + burst_A_is_4 * 4 + burst_A_is_8 * 8 + burst_A_is_16 * 16; # burst size of the array A
subject to con282: burst_A_is_1 + burst_A_is_2 + burst_A_is_4 + burst_A_is_8 + burst_A_is_16 = 1; # only one burst size for the array A
subject to con283: is_tc1_burst_witout_tiling_for_A <= A_is_fully_transfered_on_last_dim_FT0;
subject to con284: is_tc2_burst_witout_tiling_for_A <= A_is_fully_transfered_on_last_dim_FT1;
subject to con285: is_tc6_burst_witout_tiling_for_A <= A_is_fully_transfered_on_last_dim_FT2;
subject to con286: x_is_fully_transfered_on_last_dim_FT1 = level_transfer_x_FT1_under0 + perm1_S1 * (level_transfer_x_FT1_under1); # the array x is fully transfered on the last dimension
subject to con287: x_is_fully_transfered_on_last_dim_FT1 = level_transfer_x_FT1_under0; # the array x is fully transfered on the last dimension
subject to con288: x_is_fully_transfered_on_last_dim_FT2 = level_transfer_x_FT2_under0 + perm0_S3 * (level_transfer_x_FT2_under1); # the array x is fully transfered on the last dimension
subject to con289: burst_x_is_1 * cte_55 * 1 = burst_x_is_1 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con290: is_tc2_burst_witout_tiling_for_x =  min(1, cte_burst_without_tiling_TC2_for_x);
subject to con291: burst_x_is_1 * cte_56 * 1 = burst_x_is_1 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con292: burst_x_is_1 * cte_57 * 1 = burst_x_is_1 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con293: is_tc4_burst_witout_tiling_for_x =  min(1, cte_burst_without_tiling_TC4_for_x);
subject to con294: burst_x_is_1 * cte_58 * 1 = burst_x_is_1 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con295: burst_x_is_1 * cte_59 * 1 = burst_x_is_1 * ((1-is_tc6_burst_witout_tiling_for_x) * (TC6_1 * (1-x_is_fully_transfered_on_last_dim_FT2) + TC6 * (x_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC6_for_x + TC6));
subject to con296: is_tc6_burst_witout_tiling_for_x =  min(1, cte_burst_without_tiling_TC6_for_x);
subject to con297: burst_x_is_2 * cte_60 * 2 = burst_x_is_2 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con298: burst_x_is_2 * cte_61 * 2 = burst_x_is_2 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con299: burst_x_is_2 * cte_62 * 2 = burst_x_is_2 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con300: burst_x_is_2 * cte_63 * 2 = burst_x_is_2 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con301: burst_x_is_2 * cte_64 * 2 = burst_x_is_2 * ((1-is_tc6_burst_witout_tiling_for_x) * (TC6_1 * (1-x_is_fully_transfered_on_last_dim_FT2) + TC6 * (x_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC6_for_x + TC6));
subject to con302: burst_x_is_4 * cte_65 * 4 = burst_x_is_4 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con303: burst_x_is_4 * cte_66 * 4 = burst_x_is_4 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con304: burst_x_is_4 * cte_67 * 4 = burst_x_is_4 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con305: burst_x_is_4 * cte_68 * 4 = burst_x_is_4 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con306: burst_x_is_4 * cte_69 * 4 = burst_x_is_4 * ((1-is_tc6_burst_witout_tiling_for_x) * (TC6_1 * (1-x_is_fully_transfered_on_last_dim_FT2) + TC6 * (x_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC6_for_x + TC6));
subject to con307: burst_x_is_8 * cte_70 * 8 = burst_x_is_8 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con308: burst_x_is_8 * cte_71 * 8 = burst_x_is_8 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con309: burst_x_is_8 * cte_72 * 8 = burst_x_is_8 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con310: burst_x_is_8 * cte_73 * 8 = burst_x_is_8 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con311: burst_x_is_8 * cte_74 * 8 = burst_x_is_8 * ((1-is_tc6_burst_witout_tiling_for_x) * (TC6_1 * (1-x_is_fully_transfered_on_last_dim_FT2) + TC6 * (x_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC6_for_x + TC6));
subject to con312: burst_x_is_16 * cte_75 * 16 = burst_x_is_16 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con313: burst_x_is_16 * cte_76 * 16 = burst_x_is_16 * ((1-is_tc2_burst_witout_tiling_for_x) * (TC2_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC2 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc2_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC2_for_x + TC2));
subject to con314: burst_x_is_16 * cte_77 * 16 = burst_x_is_16 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con315: burst_x_is_16 * cte_78 * 16 = burst_x_is_16 * ((1-is_tc4_burst_witout_tiling_for_x) * (TC4_1 * (1-x_is_fully_transfered_on_last_dim_FT1) + TC4 * (x_is_fully_transfered_on_last_dim_FT1)) + is_tc4_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC4_for_x + TC4));
subject to con316: burst_x_is_16 * cte_79 * 16 = burst_x_is_16 * ((1-is_tc6_burst_witout_tiling_for_x) * (TC6_1 * (1-x_is_fully_transfered_on_last_dim_FT2) + TC6 * (x_is_fully_transfered_on_last_dim_FT2)) + is_tc6_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC6_for_x + TC6));
subject to con317: burst_x = burst_x_is_1 * 1 + burst_x_is_2 * 2 + burst_x_is_4 * 4 + burst_x_is_8 * 8 + burst_x_is_16 * 16; # burst size of the array x
subject to con318: burst_x_is_1 + burst_x_is_2 + burst_x_is_4 + burst_x_is_8 + burst_x_is_16 = 1; # only one burst size for the array x
subject to con319: is_tc2_burst_witout_tiling_for_x <= x_is_fully_transfered_on_last_dim_FT1;
subject to con320: is_tc4_burst_witout_tiling_for_x <= x_is_fully_transfered_on_last_dim_FT1;
subject to con321: is_tc6_burst_witout_tiling_for_x <= x_is_fully_transfered_on_last_dim_FT2;
subject to con322: u2_is_fully_transfered_on_last_dim_FT0 = level_transfer_u2_FT0_under0 + perm1_S0 * (level_transfer_u2_FT0_under1); # the array u2 is fully transfered on the last dimension
subject to con323: burst_u2_is_1 * cte_80 * 1 = burst_u2_is_1 * ((1-is_tc0_burst_witout_tiling_for_u2) * (TC0_1 * (1-u2_is_fully_transfered_on_last_dim_FT0) + TC0 * (u2_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u2 * (cte_burst_without_tiling_TC0_for_u2 + TC0));
subject to con324: is_tc0_burst_witout_tiling_for_u2 =  min(1, cte_burst_without_tiling_TC0_for_u2);
subject to con325: burst_u2_is_2 * cte_81 * 2 = burst_u2_is_2 * ((1-is_tc0_burst_witout_tiling_for_u2) * (TC0_1 * (1-u2_is_fully_transfered_on_last_dim_FT0) + TC0 * (u2_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u2 * (cte_burst_without_tiling_TC0_for_u2 + TC0));
subject to con326: burst_u2_is_4 * cte_82 * 4 = burst_u2_is_4 * ((1-is_tc0_burst_witout_tiling_for_u2) * (TC0_1 * (1-u2_is_fully_transfered_on_last_dim_FT0) + TC0 * (u2_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u2 * (cte_burst_without_tiling_TC0_for_u2 + TC0));
subject to con327: burst_u2_is_8 * cte_83 * 8 = burst_u2_is_8 * ((1-is_tc0_burst_witout_tiling_for_u2) * (TC0_1 * (1-u2_is_fully_transfered_on_last_dim_FT0) + TC0 * (u2_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u2 * (cte_burst_without_tiling_TC0_for_u2 + TC0));
subject to con328: burst_u2_is_16 * cte_84 * 16 = burst_u2_is_16 * ((1-is_tc0_burst_witout_tiling_for_u2) * (TC0_1 * (1-u2_is_fully_transfered_on_last_dim_FT0) + TC0 * (u2_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_u2 * (cte_burst_without_tiling_TC0_for_u2 + TC0));
subject to con329: burst_u2 = burst_u2_is_1 * 1 + burst_u2_is_2 * 2 + burst_u2_is_4 * 4 + burst_u2_is_8 * 8 + burst_u2_is_16 * 16; # burst size of the array u2
subject to con330: burst_u2_is_1 + burst_u2_is_2 + burst_u2_is_4 + burst_u2_is_8 + burst_u2_is_16 = 1; # only one burst size for the array u2
subject to con331: is_tc0_burst_witout_tiling_for_u2 <= u2_is_fully_transfered_on_last_dim_FT0;
subject to con332: footprint_tot_e1_FT0 = TC1_0 * (TC1_1 + cte_burst_without_tiling_TC1_for_e1);
subject to con333: footprint_tot_e2_FT0 = TC1_0 * (TC1_1 + cte_burst_without_tiling_TC1_for_e2);
subject to con334: footprint_tot_y_FT1 = TC3_0 * (TC3_1 + cte_burst_without_tiling_TC3_for_y);
subject to con335: footprint_tot_z_FT1 = TC4_0 * (TC4_1 + cte_burst_without_tiling_TC4_for_z);
subject to con336: footprint_tot_u1_FT0 = TC0_0 * (TC0_1 + cte_burst_without_tiling_TC0_for_u1);
subject to con337: footprint_tot_w_FT2 = TC5_0 * (TC5_1 + cte_burst_without_tiling_TC5_for_w);
subject to con338: footprint_tot_A_FT0 = TC0_ori * TC1_0 * (TC1_1 + cte_burst_without_tiling_TC1_for_A);
subject to con339: footprint_tot_A_FT1 = TC3_ori * TC2_0 * (TC2_1 + cte_burst_without_tiling_TC2_for_A);
subject to con340: footprint_tot_A_FT2 = TC5_ori * TC6_0 * (TC6_1 + cte_burst_without_tiling_TC6_for_A);
subject to con341: footprint_tot_x_FT1 = TC2_0 * (TC2_1 + cte_burst_without_tiling_TC2_for_x);
subject to con342: footprint_tot_x_FT1 = TC4_0 * (TC4_1 + cte_burst_without_tiling_TC4_for_x);
subject to con343: footprint_tot_x_FT2 = TC6_0 * (TC6_1 + cte_burst_without_tiling_TC6_for_x);
subject to con344: footprint_tot_u2_FT0 = TC0_0 * (TC0_1 + cte_burst_without_tiling_TC0_for_u2);
subject to con345: obj = max(shift_0_to_2 + Lat_comp_fused_S3, Lat_comp_fused_S0, shift_1_to_2 + Lat_comp_fused_S3, max(shift_0_to_1 + Lat_comp_fused_S1_S2, Lat_comp_fused_S0)) + 1/burst_e1 + 1/burst_e2 + 1/burst_y + 1/burst_z + 1/burst_u1 + 1/burst_w + 1/burst_A + 1/burst_x + 1/burst_u2 + 1/(is_slr0_used + is_slr1_used + is_slr2_used);
subject to con346: A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT1 * max(TC0_1, TC3_1) = A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT1 * min(TC0_1, TC3_1) * cte_tiling_0; # should divide for A in dim 0
subject to con347: A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT2 * max(TC0_1, TC5_1) = A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT2 * min(TC0_1, TC5_1) * cte_tiling_1; # should divide for A in dim 0
subject to con348: A_is_fully_transfered_on_last_dim_FT1 * A_is_fully_transfered_on_last_dim_FT2 * max(TC3_1, TC5_1) = A_is_fully_transfered_on_last_dim_FT1 * A_is_fully_transfered_on_last_dim_FT2 * min(TC3_1, TC5_1) * cte_tiling_2; # should divide for A in dim 0
subject to con349: A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT1 * max(TC1_1, TC2_1) = A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT1 * min(TC1_1, TC2_1) * cte_tiling_3; # should divide for A in dim 1
subject to con350: A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT2 * max(TC1_1, TC6_1) = A_is_fully_transfered_on_last_dim_FT0 * A_is_fully_transfered_on_last_dim_FT2 * min(TC1_1, TC6_1) * cte_tiling_4; # should divide for A in dim 1
subject to con351: A_is_fully_transfered_on_last_dim_FT1 * A_is_fully_transfered_on_last_dim_FT2 * max(TC2_1, TC6_1) = A_is_fully_transfered_on_last_dim_FT1 * A_is_fully_transfered_on_last_dim_FT2 * min(TC2_1, TC6_1) * cte_tiling_5; # should divide for A in dim 1
subject to con352: x_is_fully_transfered_on_last_dim_FT1 * x_is_fully_transfered_on_last_dim_FT1 * max(TC2_1, TC4_1) = x_is_fully_transfered_on_last_dim_FT1 * x_is_fully_transfered_on_last_dim_FT1 * min(TC2_1, TC4_1) * cte_tiling_6; # should divide for x in dim 0
subject to con353: x_is_fully_transfered_on_last_dim_FT1 * x_is_fully_transfered_on_last_dim_FT2 * max(TC2_1, TC6_1) = x_is_fully_transfered_on_last_dim_FT1 * x_is_fully_transfered_on_last_dim_FT2 * min(TC2_1, TC6_1) * cte_tiling_7; # should divide for x in dim 0
subject to con354: x_is_fully_transfered_on_last_dim_FT1 * x_is_fully_transfered_on_last_dim_FT2 * max(TC4_1, TC6_1) = x_is_fully_transfered_on_last_dim_FT1 * x_is_fully_transfered_on_last_dim_FT2 * min(TC4_1, TC6_1) * cte_tiling_8; # should divide for x in dim 0
subject to con355: buffer_size = footprint_A_S0_reuse + footprint_u1_S0_reuse + footprint_e1_S0_reuse + footprint_u2_S0_reuse + footprint_e2_S0_reuse + footprint_A_S1_reuse + footprint_x_S1_S2_reuse + footprint_y_S1_reuse + footprint_z_S2_reuse + footprint_A_S3_reuse + footprint_x_S3_reuse + footprint_w_S3_reuse; # total buffer size
subject to con356: fifo_size = 0; # total fifo size
subject to con357: buffer_size + fifo_size <= ON_CHIP_MEM_SIZE; # on-chip mem size
subject to con358: perm0_S0 * perm0_S1 * level_transfer_A_FT1_under0 = perm0_S0 * perm0_S1 * 1;
subject to con359: perm1_S0 * perm1_S1 * level_transfer_A_FT1_under0 = perm1_S0 * perm1_S1 * 1;
subject to con360: perm0_S0 * perm1_S3 * level_transfer_A_FT2_under0 = perm0_S0 * perm1_S3 * 1;
subject to con361: perm1_S0 * perm0_S3 * level_transfer_A_FT2_under0 = perm1_S0 * perm0_S3 * 1;
subject to con362: perm0_S0 * level_reuse_e1_FT0_under0 = perm0_S0 * 1;
subject to con363: perm0_S0 * level_reuse_e2_FT0_under0 = perm0_S0 * 1;
subject to con364: perm0_S1 * level_reuse_y_FT1_under0 = perm0_S1 * 1;
subject to con365: perm1_S0 * level_reuse_u1_FT0_under0 = perm1_S0 * 1;
subject to con366: perm1_S3 * level_reuse_w_FT2_under0 = perm1_S3 * 1;
subject to con367: perm1_S1 * level_reuse_x_FT1_under0 = perm1_S1 * 1;
subject to con368: perm0_S3 * level_reuse_x_FT2_under0 = perm0_S3 * 1;
subject to con369: perm1_S0 * level_reuse_u2_FT0_under0 = perm1_S0 * 1;
solve;
display TC0;
display TC1;
display TC2;
display TC3;
display TC4;
display TC5;
display TC6;
display is_fused_task0_in_SLR_0;
display is_fused_task0_in_SLR_1;
display is_fused_task0_in_SLR_2;
display is_fused_task1_in_SLR_0;
display is_fused_task1_in_SLR_1;
display is_fused_task1_in_SLR_2;
display is_fused_task2_in_SLR_0;
display is_fused_task2_in_SLR_1;
display is_fused_task2_in_SLR_2;
display is_slr0_used;
display is_slr1_used;
display is_slr2_used;
display perm0_S0;
display perm1_S0;
display perm0_S1;
display perm1_S1;
display perm0_S2;
display perm0_S3;
display Lat_comp_S3_for_off_chip;
display perm1_S3;
display Lat_comp_S0_intra_tile;
display Lat_comp_S1_intra_tile;
display Lat_comp_S2_intra_tile;
display Lat_comp_S3_intra_tile;
display footprint_A_S0;
display footprint_A_S0_reuse;
display footprint_u1_S0;
display footprint_u1_S0_reuse;
display footprint_e1_S0;
display footprint_e1_S0_reuse;
display footprint_u2_S0;
display footprint_u2_S0_reuse;
display footprint_e2_S0;
display footprint_e2_S0_reuse;
display footprint_A_S1;
display footprint_A_S1_reuse;
display footprint_x_S1_S2;
display footprint_x_S1_S2_reuse;
display footprint_y_S1;
display footprint_y_S1_reuse;
display footprint_z_S2;
display footprint_z_S2_reuse;
display footprint_A_S3;
display footprint_A_S3_reuse;
display footprint_x_S3;
display footprint_x_S3_reuse;
display footprint_w_S3;
display footprint_w_S3_reuse;
display Lat_comp_fused_S0;
display level_transfer_A_FT0_under0;
display level_reuse_A_FT0_under0;
display level_transfer_A_FT0_under1;
display level_reuse_A_FT0_under1;
display level_transfer_A_FT0_under2;
display level_reuse_A_FT0_under2;
display level_transfer_u1_FT0_under0;
display level_reuse_u1_FT0_under0;
display level_transfer_u1_FT0_under1;
display level_reuse_u1_FT0_under1;
display level_transfer_u1_FT0_under2;
display level_reuse_u1_FT0_under2;
display level_transfer_e1_FT0_under0;
display level_reuse_e1_FT0_under0;
display level_transfer_e1_FT0_under1;
display level_reuse_e1_FT0_under1;
display level_transfer_e1_FT0_under2;
display level_reuse_e1_FT0_under2;
display level_transfer_u2_FT0_under0;
display level_reuse_u2_FT0_under0;
display level_transfer_u2_FT0_under1;
display level_reuse_u2_FT0_under1;
display level_transfer_u2_FT0_under2;
display level_reuse_u2_FT0_under2;
display level_transfer_e2_FT0_under0;
display level_reuse_e2_FT0_under0;
display level_transfer_e2_FT0_under1;
display level_reuse_e2_FT0_under1;
display level_transfer_e2_FT0_under2;
display level_reuse_e2_FT0_under2;
display Lat_comp_fused_S0_3;
display Lat_comp_fused_S0_2;
display Lat_comp_fused_S0_1;
display Lat_comp_fused_S1_S2;
display level_transfer_x_FT1_under0;
display level_reuse_x_FT1_under0;
display level_transfer_x_FT1_under1;
display level_reuse_x_FT1_under1;
display level_transfer_A_FT1_under0;
display level_reuse_A_FT1_under0;
display level_transfer_A_FT1_under1;
display level_reuse_A_FT1_under1;
display level_transfer_y_FT1_under0;
display level_reuse_y_FT1_under0;
display level_transfer_y_FT1_under1;
display level_reuse_y_FT1_under1;
display level_transfer_z_FT1_under0;
display level_reuse_z_FT1_under0;
display level_transfer_z_FT1_under1;
display level_reuse_z_FT1_under1;
display Lat_comp_fused_S1_S2_2;
display Lat_comp_fused_S1_S2_1;
display Lat_comp_fused_S3;
display level_transfer_w_FT2_under0;
display level_reuse_w_FT2_under0;
display level_transfer_w_FT2_under1;
display level_reuse_w_FT2_under1;
display level_transfer_A_FT2_under0;
display level_reuse_A_FT2_under0;
display level_transfer_A_FT2_under1;
display level_reuse_A_FT2_under1;
display level_transfer_x_FT2_under0;
display level_reuse_x_FT2_under0;
display level_transfer_x_FT2_under1;
display level_reuse_x_FT2_under1;
display Lat_comp_fused_S3_2;
display Lat_comp_fused_S3_1;
display shift_0_to_1;
display shift_0_to_2;
display shift_1_to_2;
display nb_dsp_used_SLR0;
display nb_dsp_used_SLR1;
display nb_dsp_used_SLR2;
display TC0_0;
display TC0_1;
display TC1_0;
display TC1_1;
display TC2_0;
display TC2_1;
display TC3_0;
display TC3_1;
display TC4_0;
display TC4_1;
display TC5_0;
display TC5_1;
display TC6_0;
display TC6_1;
display e1_is_fully_transfered_on_last_dim_FT0;
display burst_e1_is_1;
display cte_0;
display cte_burst_without_tiling_TC1_for_e1;
display is_tc1_burst_witout_tiling_for_e1;
display burst_e1_is_2;
display cte_1;
display burst_e1_is_4;
display cte_2;
display burst_e1_is_8;
display cte_3;
display burst_e1_is_16;
display cte_4;
display e2_is_fully_transfered_on_last_dim_FT0;
display burst_e2_is_1;
display cte_5;
display cte_burst_without_tiling_TC1_for_e2;
display is_tc1_burst_witout_tiling_for_e2;
display burst_e2_is_2;
display cte_6;
display burst_e2_is_4;
display cte_7;
display burst_e2_is_8;
display cte_8;
display burst_e2_is_16;
display cte_9;
display y_is_fully_transfered_on_last_dim_FT1;
display burst_y_is_1;
display cte_10;
display cte_burst_without_tiling_TC3_for_y;
display is_tc3_burst_witout_tiling_for_y;
display burst_y_is_2;
display cte_11;
display burst_y_is_4;
display cte_12;
display burst_y_is_8;
display cte_13;
display burst_y_is_16;
display cte_14;
display z_is_fully_transfered_on_last_dim_FT1;
display burst_z_is_1;
display cte_15;
display cte_burst_without_tiling_TC4_for_z;
display is_tc4_burst_witout_tiling_for_z;
display burst_z_is_2;
display cte_16;
display burst_z_is_4;
display cte_17;
display burst_z_is_8;
display cte_18;
display burst_z_is_16;
display cte_19;
display u1_is_fully_transfered_on_last_dim_FT0;
display burst_u1_is_1;
display cte_20;
display cte_burst_without_tiling_TC0_for_u1;
display is_tc0_burst_witout_tiling_for_u1;
display burst_u1_is_2;
display cte_21;
display burst_u1_is_4;
display cte_22;
display burst_u1_is_8;
display cte_23;
display burst_u1_is_16;
display cte_24;
display w_is_fully_transfered_on_last_dim_FT2;
display burst_w_is_1;
display cte_25;
display cte_burst_without_tiling_TC5_for_w;
display is_tc5_burst_witout_tiling_for_w;
display cte_26;
display burst_w_is_2;
display cte_27;
display cte_28;
display burst_w_is_4;
display cte_29;
display cte_30;
display burst_w_is_8;
display cte_31;
display cte_32;
display burst_w_is_16;
display cte_33;
display cte_34;
display A_is_fully_transfered_on_last_dim_FT0;
display A_is_fully_transfered_on_last_dim_FT1;
display A_is_fully_transfered_on_last_dim_FT2;
display burst_A_is_1;
display cte_35;
display cte_burst_without_tiling_TC1_for_A;
display is_tc1_burst_witout_tiling_for_A;
display cte_36;
display cte_37;
display cte_burst_without_tiling_TC2_for_A;
display is_tc2_burst_witout_tiling_for_A;
display cte_38;
display cte_burst_without_tiling_TC6_for_A;
display is_tc6_burst_witout_tiling_for_A;
display burst_A_is_2;
display cte_39;
display cte_40;
display cte_41;
display cte_42;
display burst_A_is_4;
display cte_43;
display cte_44;
display cte_45;
display cte_46;
display burst_A_is_8;
display cte_47;
display cte_48;
display cte_49;
display cte_50;
display burst_A_is_16;
display cte_51;
display cte_52;
display cte_53;
display cte_54;
display x_is_fully_transfered_on_last_dim_FT1;
display x_is_fully_transfered_on_last_dim_FT2;
display burst_x_is_1;
display cte_55;
display cte_burst_without_tiling_TC2_for_x;
display is_tc2_burst_witout_tiling_for_x;
display cte_56;
display cte_57;
display cte_burst_without_tiling_TC4_for_x;
display is_tc4_burst_witout_tiling_for_x;
display cte_58;
display cte_59;
display cte_burst_without_tiling_TC6_for_x;
display is_tc6_burst_witout_tiling_for_x;
display burst_x_is_2;
display cte_60;
display cte_61;
display cte_62;
display cte_63;
display cte_64;
display burst_x_is_4;
display cte_65;
display cte_66;
display cte_67;
display cte_68;
display cte_69;
display burst_x_is_8;
display cte_70;
display cte_71;
display cte_72;
display cte_73;
display cte_74;
display burst_x_is_16;
display cte_75;
display cte_76;
display cte_77;
display cte_78;
display cte_79;
display u2_is_fully_transfered_on_last_dim_FT0;
display burst_u2_is_1;
display cte_80;
display cte_burst_without_tiling_TC0_for_u2;
display is_tc0_burst_witout_tiling_for_u2;
display burst_u2_is_2;
display cte_81;
display burst_u2_is_4;
display cte_82;
display burst_u2_is_8;
display cte_83;
display burst_u2_is_16;
display cte_84;
display footprint_tot_e1_FT0;
display burst_e1;
display footprint_tot_e2_FT0;
display burst_e2;
display footprint_tot_y_FT1;
display burst_y;
display footprint_tot_z_FT1;
display burst_z;
display footprint_tot_u1_FT0;
display burst_u1;
display footprint_tot_w_FT2;
display burst_w;
display footprint_tot_A_FT0;
display burst_A;
display footprint_tot_A_FT1;
display footprint_tot_A_FT2;
display footprint_tot_x_FT1;
display burst_x;
display footprint_tot_x_FT2;
display footprint_tot_u2_FT0;
display burst_u2;
display Lat_comp_1_2;
display obj;
display cte_tiling_0;
display cte_tiling_1;
display cte_tiling_2;
display cte_tiling_3;
display cte_tiling_4;
display cte_tiling_5;
display cte_tiling_6;
display cte_tiling_7;
display cte_tiling_8;
display buffer_size;
display fifo_size;
display _total_solve_time;
