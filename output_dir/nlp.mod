#option solver baron;
#option baron_options 'maxtime=60 trace=nlp.trace sumfile=nlp.sum';
option solver gurobi;
option gurobi_options 'lim:time=169200 tech:logfile=gurobi.log qp:nonconvex=2';
#option solver octeract;
#option octeract_options 'max_solver_time=60';

param DSP_avail = 10848;
param ON_CHIP_MEM_SIZE = 634192;
param MAX_BUFFER_SIZE = 1024;
param CONSTRAINT_ARRAY_PARTITIONING_VALUE = 1024;
param MAX_UF = 32;
param SLR0_mem = 211397;
param SLR0_DSP = 3616;
param SLR1_mem = 211397;
param SLR1_DSP = 3616;
param SLR2_mem = 211397;
param SLR2_DSP = 3616;
param II_S0_par = 1;
param II_S0_seq = 3;
param II_S1_par = 1;
param II_S1_seq = 3;
param TC0_ori = 256;
param TC1_ori = 256;
param TC2_ori = 7;
param IL_par_S0 = 1;
param IL_seq_S0 = 0;
param IL_par_S1 = 4;
param IL_seq_S1 = 7;
param DSP_S0 = 0;
param DSP_S1 = 5;

var TC0 integer >= 256 <= 256;
var TC1 integer >= 256 <= 256;
var TC2 integer >= 7 <= 16;
var is_fused_task0_in_SLR_0 binary;
var is_fused_task0_in_SLR_1 binary;
var is_fused_task0_in_SLR_2 binary;
var is_slr0_used binary;
var is_slr1_used binary;
var is_slr2_used binary;
var perm0_S0 binary; # [0, 0, 0, 0, 0]
var perm0_S1 binary; # [1, 1, 0, 2, 0, 1, 0, 2, 0]
var Lat_comp_S1_for_off_chip >= 0;
var perm1_S1 binary; # [1, 2, 0, 1, 0, 2, 0, 1, 0]
var Lat_comp_S0_intra_tile >= 0;
var Lat_comp_S1_intra_tile >= 0;
var footprint_y_S0_S1 integer >= 0;
var footprint_y_S0_S1_reuse integer >= 0;
var footprint_val_S1 integer >= 0;
var footprint_val_S1_reuse integer >= 0;
var Lat_comp_fused_S0_S1 >= 0;
var level_transfer_y_FT0_under0 binary;
var level_reuse_y_FT0_under0 binary;
var level_transfer_y_FT0_under1 binary;
var level_reuse_y_FT0_under1 binary;
var level_transfer_val_FT0_under0 binary;
var level_reuse_val_FT0_under0 binary;
var level_transfer_val_FT0_under1 binary;
var level_reuse_val_FT0_under1 binary;
var level_transfer_x_FT0_under0 binary;
var level_reuse_x_FT0_under0 binary;
var level_transfer_x_FT0_under1 binary;
var level_reuse_x_FT0_under1 binary;
var Lat_comp_fused_S0_S1_2 >= 0;
var Lat_comp_fused_S0_S1_1 >= 0;
var nb_dsp_used_SLR0 >= 0;
var nb_dsp_used_SLR1 >= 0;
var nb_dsp_used_SLR2 >= 0;
var TC0_0 integer >= 1;
var TC0_1 integer >= 1;
var TC1_0 integer >= 1;
var TC1_1 integer >= 1;
var TC2_0 integer >= 1;
var TC2_1 integer >= 1;
var val_is_fully_transfered_on_last_dim_FT0 binary;
var burst_val_is_1 binary;
var cte_0 integer >=0;
var cte_burst_without_tiling_TC2_for_val integer >= 0 <= 0;
var is_tc2_burst_witout_tiling_for_val binary;
var burst_val_is_2 binary;
var cte_1 integer >=0;
var burst_val_is_4 binary;
var cte_2 integer >=0;
var burst_val_is_8 binary;
var cte_3 integer >=0;
var burst_val_is_16 binary;
var cte_4 integer >=0;
var y_is_fully_transfered_on_last_dim_FT0 binary;
var burst_y_is_1 binary;
var cte_5 integer >=0;
var cte_burst_without_tiling_TC0_for_y integer >= 0 <= 0;
var is_tc0_burst_witout_tiling_for_y binary;
var cte_6 integer >=0;
var cte_burst_without_tiling_TC1_for_y integer >= 0 <= 0;
var is_tc1_burst_witout_tiling_for_y binary;
var cte_7 integer >=0;
var burst_y_is_2 binary;
var cte_8 integer >=0;
var cte_9 integer >=0;
var cte_10 integer >=0;
var burst_y_is_4 binary;
var cte_11 integer >=0;
var cte_12 integer >=0;
var cte_13 integer >=0;
var burst_y_is_8 binary;
var cte_14 integer >=0;
var cte_15 integer >=0;
var cte_16 integer >=0;
var burst_y_is_16 binary;
var cte_17 integer >=0;
var cte_18 integer >=0;
var cte_19 integer >=0;
var x_is_fully_transfered_on_last_dim_FT0 binary;
var burst_x_is_1 binary;
var cte_20 integer >=0;
var cte_burst_without_tiling_TC1_for_x integer >= 0 <= 0;
var is_tc1_burst_witout_tiling_for_x binary;
var burst_x_is_2 binary;
var cte_21 integer >=0;
var burst_x_is_4 binary;
var cte_22 integer >=0;
var burst_x_is_8 binary;
var cte_23 integer >=0;
var burst_x_is_16 binary;
var cte_24 integer >=0;
var footprint_tot_val_FT0 integer >= 1;
var burst_val integer >= 0;
var footprint_tot_y_FT0 integer >= 1;
var burst_y integer >= 0;
var footprint_tot_x_FT0 integer >= 1;
var burst_x integer >= 0;
var Lat_comp_0_1 >= 0;
var obj >= 0;
var cte_tiling_0 integer >= 0;
var buffer_size >= 0;
var fifo_size >= 0;

#comment: Fuse [0, 1]
#comment: Task 1 writes y to off-chip
#comment: Statement 0: y[i] = 0;
#comment: Statement 1: y[i] = y[i] + val[i][j] * x[i + j];
#comment: Loop_0: i
#comment: Loop_1: i
#comment: Loop_2: j
#comment: Argument 0: float val[256][7]
#comment: Argument 1: float x[262]
#comment: Argument 2: float y[256]
#comment:  2 is a reduction loop
#comment: Task 1 reads val from off-chip
#comment: Task 1 reads x from off-chip
#comment: Array val has for tc in dim 0 TC1 (ori=TC1_ori) arg0
#comment: Array val has for tc in dim 1 TC2 (ori=TC2_ori) arg0
#comment: Array y has for tc in dim 0 TC0 (ori=TC0_ori) arg0
#comment: Array y has for tc in dim 0 TC1 (ori=TC1_ori) arg0
#comment: Array y has for tc in dim 0 TC0 (ori=TC0_ori) arg0
#comment: Array y has for tc in dim 0 TC1 (ori=TC1_ori) arg0
#comment: Array x has for tc in dim 0 TC1 (ori=TC1_ori) arg0
#comment: Array x has for tc in dim 0 TC2 (ori=TC2_ori) arg1
#comment: Array x has for tc in dim 0 TC1 (ori=TC1_ori) arg0
#comment: Array x has for tc in dim 0 TC2 (ori=TC2_ori) arg1
#comment: Sched 0 has reuse buffer y[TC0_1]
#comment: Sched 1 has reuse buffer y[TC1_1]
#comment: Sched 1 has reuse buffer val[TC1_1][TC2_1]
#comment: Sched 1 has reuse buffer x[TC1_1+TC2_1]

minimize cost: obj;

subject to con0: is_slr0_used = min(1,is_fused_task0_in_SLR_0);
subject to con1: is_slr1_used = min(1,is_fused_task0_in_SLR_1);
subject to con2: is_slr2_used = min(1,is_fused_task0_in_SLR_2);
subject to con3: is_fused_task0_in_SLR_0 + is_fused_task0_in_SLR_1 + is_fused_task0_in_SLR_2 = 1; # only one SLR for fused task 0
subject to con4: perm0_S0 = 1; # only one permutation
subject to con5: perm0_S1 + perm1_S1 = 1; # only one permutation
subject to con6: Lat_comp_S0_intra_tile = IL_par_S0 + IL_seq_S0; # latency of the intra-tile S0
subject to con7: Lat_comp_S1_intra_tile = IL_par_S1 + IL_seq_S1 * log(TC2_1)/log(2); # latency of the intra-tile S1
subject to con8: perm1_S1 = 0; # because of the fused task 0
subject to con9: perm0_S0 = perm0_S1; # same iteration of output in FT 0
subject to con10: is_fused_task0_in_SLR_0 * (footprint_y_S0_S1_reuse + footprint_val_S1_reuse) <= SLR0_mem; # memory constraint per SLR
subject to con11: is_fused_task0_in_SLR_1 * (footprint_y_S0_S1_reuse + footprint_val_S1_reuse) <= SLR1_mem; # memory constraint per SLR
subject to con12: is_fused_task0_in_SLR_2 * (footprint_y_S0_S1_reuse + footprint_val_S1_reuse) <= SLR2_mem; # memory constraint per SLR
subject to con13: level_reuse_y_FT0_under0 = level_transfer_y_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con14: level_reuse_y_FT0_under1 = 1; # transfer innermost for output
subject to con15: level_reuse_y_FT0_under1 = level_transfer_y_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con16: level_transfer_y_FT0_under0 + level_transfer_y_FT0_under1 = 1; # only one level of transfer for y
subject to con17: level_reuse_y_FT0_under0 + level_reuse_y_FT0_under1 = 1; # only one level of reuse for y
subject to con18: level_reuse_y_FT0_under0 = level_transfer_y_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con19: level_reuse_y_FT0_under1 = level_transfer_y_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con20: level_reuse_val_FT0_under0 = level_transfer_val_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con21: level_reuse_val_FT0_under1 = level_transfer_val_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con22: level_transfer_val_FT0_under0 + level_transfer_val_FT0_under1 = 1; # only one level of transfer for val
subject to con23: level_reuse_val_FT0_under0 + level_reuse_val_FT0_under1 = 1; # only one level of reuse for val
subject to con24: level_reuse_x_FT0_under0 >= level_transfer_x_FT0_under0; # reuse level have to be outermost or equal to transfer
subject to con25: level_reuse_x_FT0_under0 + level_reuse_x_FT0_under1 >= level_transfer_x_FT0_under1; # reuse level have to be outermost or equal to transfer
subject to con26: level_transfer_x_FT0_under0 + level_transfer_x_FT0_under1 = 1; # only one level of transfer for x
subject to con27: level_reuse_x_FT0_under0 + level_reuse_x_FT0_under1 = 1; # only one level of reuse for x
subject to con28: Lat_comp_fused_S0_S1_2 = ((Lat_comp_S0_intra_tile) + (Lat_comp_S1_intra_tile + II_S1_seq * TC2_0)); # latency of the fused task S0_S1 level 2
subject to con29: Lat_comp_fused_S0_S1_1 = (perm0_S0 * TC0_0) * max(Lat_comp_fused_S0_S1_2, level_transfer_y_FT0_under1 * footprint_y_S0_S1 / burst_y, level_transfer_val_FT0_under1 * footprint_val_S1 / burst_val) + Lat_comp_fused_S0_S1_2 + max(level_transfer_y_FT0_under1 * footprint_y_S0_S1 / burst_y, level_transfer_val_FT0_under1 * footprint_val_S1 / burst_val  + level_transfer_y_FT0_under1 * footprint_y_S0_S1 / burst_y); # latency of the fused task S0_S1 level 1
subject to con30: Lat_comp_fused_S0_S1 = Lat_comp_fused_S0_S1_1 + level_transfer_y_FT0_under0 * footprint_tot_y_FT0 / burst_y + level_transfer_val_FT0_under0 * footprint_tot_val_FT0 / burst_val + level_transfer_x_FT0_under0 * footprint_tot_x_FT0 / burst_x; # latency of the fused task S0_S1
subject to con31: footprint_y_S0_S1 = level_transfer_y_FT0_under0 * footprint_tot_y_FT0 + level_transfer_y_FT0_under1 * (perm0_S0 * footprint_tot_y_FT0/ TC0_0); # footprint of the array y for the fused task 0
subject to con32: footprint_y_S0_S1_reuse = level_reuse_y_FT0_under0 * footprint_tot_y_FT0 + level_reuse_y_FT0_under1 * (perm0_S0 * footprint_tot_y_FT0/ TC0_0); # footprint of the array y for the fused task 0
subject to con33: footprint_val_S1 = level_transfer_val_FT0_under0 * footprint_tot_val_FT0 + level_transfer_val_FT0_under1 * (perm0_S1 * footprint_tot_val_FT0/ TC1_0 + perm1_S1 * footprint_tot_val_FT0/ TC2_0); # footprint of the array val for the fused task 0
subject to con34: footprint_val_S1_reuse = level_reuse_val_FT0_under0 * footprint_tot_val_FT0 + level_reuse_val_FT0_under1 * (perm0_S1 * footprint_tot_val_FT0/ TC1_0 + perm1_S1 * footprint_tot_val_FT0/ TC2_0); # footprint of the array val for the fused task 0
subject to con35: TC0_1 <= MAX_UF;
subject to con36: TC1_1 * TC2_1 <= MAX_UF;
subject to con37: TC0_1 * DSP_S0  + TC1_1 * TC2_1 * DSP_S1 / II_S1_seq <= DSP_avail; # DSP constraint
subject to con38: nb_dsp_used_SLR0 = is_fused_task0_in_SLR_0 * (TC0_1 * DSP_S0 + TC1_1 * TC2_1 * DSP_S1 / II_S1_seq); # DSP constraint per SLR
subject to con39: nb_dsp_used_SLR0 <= SLR0_DSP; # DSP constraint per SLR
subject to con40: nb_dsp_used_SLR1 = is_fused_task0_in_SLR_1 * (TC0_1 * DSP_S0 + TC1_1 * TC2_1 * DSP_S1 / II_S1_seq); # DSP constraint per SLR
subject to con41: nb_dsp_used_SLR1 <= SLR1_DSP; # DSP constraint per SLR
subject to con42: nb_dsp_used_SLR2 = is_fused_task0_in_SLR_2 * (TC0_1 * DSP_S0 + TC1_1 * TC2_1 * DSP_S1 / II_S1_seq); # DSP constraint per SLR
subject to con43: nb_dsp_used_SLR2 <= SLR2_DSP; # DSP constraint per SLR
subject to con44: TC0_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array y 
subject to con45: TC1_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array y 
subject to con46: TC1_1 * TC2_1 <= CONSTRAINT_ARRAY_PARTITIONING_VALUE; # array part for array val 
subject to con47: Lat_comp_S1_for_off_chip = perm0_S1 * TC2_0 * II_S1_seq + perm1_S1 * TC2_0 * TC1_0 * II_S1_par; # stall between task
subject to con48: TC0_0 <= TC0; # TC of split loop
subject to con49: TC0_1 <= TC0; # TC of split loop
subject to con50: TC0_0 * TC0_1 = TC0; # product of the TC of split loop = original TC
subject to con51: TC1_0 <= TC1; # TC of split loop
subject to con52: TC1_1 <= TC1; # TC of split loop
subject to con53: TC1_0 * TC1_1 = TC1; # product of the TC of split loop = original TC
subject to con54: TC2_0 <= TC2; # TC of split loop
subject to con55: TC2_1 <= TC2; # TC of split loop
subject to con56: TC2_0 * TC2_1 = TC2; # product of the TC of split loop = original TC
subject to con57: TC0_1 = TC1_1; # same intra tile for the same dimension of the array y in the fused task
subject to con58: TC1_1 = TC2_1; # same intra tile for the same dimension of the array x in the fused task
subject to con59: val_is_fully_transfered_on_last_dim_FT0 = level_transfer_val_FT0_under0 + perm0_S1 * (level_transfer_val_FT0_under1); # the array val is fully transfered on the last dimension
subject to con60: burst_val_is_1 * cte_0 * 1 = burst_val_is_1 * ((1-is_tc2_burst_witout_tiling_for_val) * (TC2_1 * (1-val_is_fully_transfered_on_last_dim_FT0) + TC2 * (val_is_fully_transfered_on_last_dim_FT0)) + is_tc2_burst_witout_tiling_for_val * (cte_burst_without_tiling_TC2_for_val + TC2));
subject to con61: is_tc2_burst_witout_tiling_for_val =  min(1, cte_burst_without_tiling_TC2_for_val);
subject to con62: burst_val_is_2 * cte_1 * 2 = burst_val_is_2 * ((1-is_tc2_burst_witout_tiling_for_val) * (TC2_1 * (1-val_is_fully_transfered_on_last_dim_FT0) + TC2 * (val_is_fully_transfered_on_last_dim_FT0)) + is_tc2_burst_witout_tiling_for_val * (cte_burst_without_tiling_TC2_for_val + TC2));
subject to con63: burst_val_is_4 * cte_2 * 4 = burst_val_is_4 * ((1-is_tc2_burst_witout_tiling_for_val) * (TC2_1 * (1-val_is_fully_transfered_on_last_dim_FT0) + TC2 * (val_is_fully_transfered_on_last_dim_FT0)) + is_tc2_burst_witout_tiling_for_val * (cte_burst_without_tiling_TC2_for_val + TC2));
subject to con64: burst_val_is_8 * cte_3 * 8 = burst_val_is_8 * ((1-is_tc2_burst_witout_tiling_for_val) * (TC2_1 * (1-val_is_fully_transfered_on_last_dim_FT0) + TC2 * (val_is_fully_transfered_on_last_dim_FT0)) + is_tc2_burst_witout_tiling_for_val * (cte_burst_without_tiling_TC2_for_val + TC2));
subject to con65: burst_val_is_16 * cte_4 * 16 = burst_val_is_16 * ((1-is_tc2_burst_witout_tiling_for_val) * (TC2_1 * (1-val_is_fully_transfered_on_last_dim_FT0) + TC2 * (val_is_fully_transfered_on_last_dim_FT0)) + is_tc2_burst_witout_tiling_for_val * (cte_burst_without_tiling_TC2_for_val + TC2));
subject to con66: burst_val = burst_val_is_1 * 1 + burst_val_is_2 * 2 + burst_val_is_4 * 4 + burst_val_is_8 * 8 + burst_val_is_16 * 16; # burst size of the array val
subject to con67: burst_val_is_1 + burst_val_is_2 + burst_val_is_4 + burst_val_is_8 + burst_val_is_16 = 1; # only one burst size for the array val
subject to con68: is_tc2_burst_witout_tiling_for_val <= val_is_fully_transfered_on_last_dim_FT0;
subject to con69: y_is_fully_transfered_on_last_dim_FT0 = level_transfer_y_FT0_under0; # the array y is fully transfered on the last dimension
subject to con70: y_is_fully_transfered_on_last_dim_FT0 = level_transfer_y_FT0_under0 + perm1_S1 * (level_transfer_y_FT0_under1); # the array y is fully transfered on the last dimension
subject to con71: burst_y_is_1 * cte_5 * 1 = burst_y_is_1 * ((1-is_tc0_burst_witout_tiling_for_y) * (TC0_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC0 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC0_for_y + TC0));
subject to con72: is_tc0_burst_witout_tiling_for_y =  min(1, cte_burst_without_tiling_TC0_for_y);
subject to con73: burst_y_is_1 * cte_6 * 1 = burst_y_is_1 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con74: is_tc1_burst_witout_tiling_for_y =  min(1, cte_burst_without_tiling_TC1_for_y);
subject to con75: burst_y_is_1 * cte_7 * 1 = burst_y_is_1 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con76: burst_y_is_2 * cte_8 * 2 = burst_y_is_2 * ((1-is_tc0_burst_witout_tiling_for_y) * (TC0_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC0 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC0_for_y + TC0));
subject to con77: burst_y_is_2 * cte_9 * 2 = burst_y_is_2 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con78: burst_y_is_2 * cte_10 * 2 = burst_y_is_2 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con79: burst_y_is_4 * cte_11 * 4 = burst_y_is_4 * ((1-is_tc0_burst_witout_tiling_for_y) * (TC0_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC0 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC0_for_y + TC0));
subject to con80: burst_y_is_4 * cte_12 * 4 = burst_y_is_4 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con81: burst_y_is_4 * cte_13 * 4 = burst_y_is_4 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con82: burst_y_is_8 * cte_14 * 8 = burst_y_is_8 * ((1-is_tc0_burst_witout_tiling_for_y) * (TC0_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC0 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC0_for_y + TC0));
subject to con83: burst_y_is_8 * cte_15 * 8 = burst_y_is_8 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con84: burst_y_is_8 * cte_16 * 8 = burst_y_is_8 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con85: burst_y_is_16 * cte_17 * 16 = burst_y_is_16 * ((1-is_tc0_burst_witout_tiling_for_y) * (TC0_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC0 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc0_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC0_for_y + TC0));
subject to con86: burst_y_is_16 * cte_18 * 16 = burst_y_is_16 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con87: burst_y_is_16 * cte_19 * 16 = burst_y_is_16 * ((1-is_tc1_burst_witout_tiling_for_y) * (TC1_1 * (1-y_is_fully_transfered_on_last_dim_FT0) + TC1 * (y_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_y * (cte_burst_without_tiling_TC1_for_y + TC1));
subject to con88: burst_y = burst_y_is_1 * 1 + burst_y_is_2 * 2 + burst_y_is_4 * 4 + burst_y_is_8 * 8 + burst_y_is_16 * 16; # burst size of the array y
subject to con89: burst_y_is_1 + burst_y_is_2 + burst_y_is_4 + burst_y_is_8 + burst_y_is_16 = 1; # only one burst size for the array y
subject to con90: is_tc0_burst_witout_tiling_for_y <= y_is_fully_transfered_on_last_dim_FT0;
subject to con91: is_tc1_burst_witout_tiling_for_y <= y_is_fully_transfered_on_last_dim_FT0;
subject to con92: x_is_fully_transfered_on_last_dim_FT0 = level_transfer_x_FT0_under0 + perm1_S1 * (level_transfer_x_FT0_under1); # the array x is fully transfered on the last dimension
subject to con93: x_is_fully_transfered_on_last_dim_FT0 = level_transfer_x_FT0_under0 + perm0_S1 * (level_transfer_x_FT0_under1); # the array x is fully transfered on the last dimension
subject to con94: burst_x_is_1 * cte_20 * 1 = burst_x_is_1 * ((1-is_tc1_burst_witout_tiling_for_x) * (TC1_1 * (1-x_is_fully_transfered_on_last_dim_FT0) + TC1 * (x_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC1_for_x + TC1));
subject to con95: is_tc1_burst_witout_tiling_for_x =  min(1, cte_burst_without_tiling_TC1_for_x);
subject to con96: burst_x_is_2 * cte_21 * 2 = burst_x_is_2 * ((1-is_tc1_burst_witout_tiling_for_x) * (TC1_1 * (1-x_is_fully_transfered_on_last_dim_FT0) + TC1 * (x_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC1_for_x + TC1));
subject to con97: burst_x_is_4 * cte_22 * 4 = burst_x_is_4 * ((1-is_tc1_burst_witout_tiling_for_x) * (TC1_1 * (1-x_is_fully_transfered_on_last_dim_FT0) + TC1 * (x_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC1_for_x + TC1));
subject to con98: burst_x_is_8 * cte_23 * 8 = burst_x_is_8 * ((1-is_tc1_burst_witout_tiling_for_x) * (TC1_1 * (1-x_is_fully_transfered_on_last_dim_FT0) + TC1 * (x_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC1_for_x + TC1));
subject to con99: burst_x_is_16 * cte_24 * 16 = burst_x_is_16 * ((1-is_tc1_burst_witout_tiling_for_x) * (TC1_1 * (1-x_is_fully_transfered_on_last_dim_FT0) + TC1 * (x_is_fully_transfered_on_last_dim_FT0)) + is_tc1_burst_witout_tiling_for_x * (cte_burst_without_tiling_TC1_for_x + TC1));
subject to con100: burst_x = burst_x_is_1 * 1 + burst_x_is_2 * 2 + burst_x_is_4 * 4 + burst_x_is_8 * 8 + burst_x_is_16 * 16; # burst size of the array x
subject to con101: burst_x_is_1 + burst_x_is_2 + burst_x_is_4 + burst_x_is_8 + burst_x_is_16 = 1; # only one burst size for the array x
subject to con102: is_tc1_burst_witout_tiling_for_x <= x_is_fully_transfered_on_last_dim_FT0;
subject to con103: footprint_tot_val_FT0 = TC1_ori * TC2_0 * (TC2_1 + cte_burst_without_tiling_TC2_for_val);
subject to con104: footprint_tot_y_FT0 = TC0_0 * (TC0_1 + cte_burst_without_tiling_TC0_for_y);
subject to con105: footprint_tot_y_FT0 = TC1_0 * (TC1_1 + cte_burst_without_tiling_TC1_for_y);
subject to con106: footprint_tot_x_FT0 = TC1_0 * (TC1_1 + cte_burst_without_tiling_TC1_for_x);
subject to con107: footprint_tot_x_FT0 = TC2;
subject to con108: obj = Lat_comp_fused_S0_S1 + 1/burst_val + 1/burst_y + 1/burst_x + 1/(is_slr0_used + is_slr1_used + is_slr2_used);
subject to con109: y_is_fully_transfered_on_last_dim_FT0 * y_is_fully_transfered_on_last_dim_FT0 * max(TC0_1, TC1_1) = y_is_fully_transfered_on_last_dim_FT0 * y_is_fully_transfered_on_last_dim_FT0 * min(TC0_1, TC1_1) * cte_tiling_0; # should divide for y in dim 0
subject to con110: buffer_size = footprint_y_S0_S1_reuse + footprint_val_S1_reuse; # total buffer size
subject to con111: fifo_size = 0; # total fifo size
subject to con112: buffer_size + fifo_size <= ON_CHIP_MEM_SIZE; # on-chip mem size
subject to con113: perm1_S1 * level_reuse_y_FT0_under0 = perm1_S1 * 1;
subject to con114: perm1_S1 * level_reuse_x_FT0_under0 = perm1_S1 * 1;
subject to con115: perm0_S1 * level_reuse_x_FT0_under0 = perm0_S1 * 1;
solve;
display TC0;
display TC1;
display TC2;
display is_fused_task0_in_SLR_0;
display is_fused_task0_in_SLR_1;
display is_fused_task0_in_SLR_2;
display is_slr0_used;
display is_slr1_used;
display is_slr2_used;
display perm0_S0;
display perm0_S1;
display Lat_comp_S1_for_off_chip;
display perm1_S1;
display Lat_comp_S0_intra_tile;
display Lat_comp_S1_intra_tile;
display footprint_y_S0_S1;
display footprint_y_S0_S1_reuse;
display footprint_val_S1;
display footprint_val_S1_reuse;
display Lat_comp_fused_S0_S1;
display level_transfer_y_FT0_under0;
display level_reuse_y_FT0_under0;
display level_transfer_y_FT0_under1;
display level_reuse_y_FT0_under1;
display level_transfer_val_FT0_under0;
display level_reuse_val_FT0_under0;
display level_transfer_val_FT0_under1;
display level_reuse_val_FT0_under1;
display level_transfer_x_FT0_under0;
display level_reuse_x_FT0_under0;
display level_transfer_x_FT0_under1;
display level_reuse_x_FT0_under1;
display Lat_comp_fused_S0_S1_2;
display Lat_comp_fused_S0_S1_1;
display nb_dsp_used_SLR0;
display nb_dsp_used_SLR1;
display nb_dsp_used_SLR2;
display TC0_0;
display TC0_1;
display TC1_0;
display TC1_1;
display TC2_0;
display TC2_1;
display val_is_fully_transfered_on_last_dim_FT0;
display burst_val_is_1;
display cte_0;
display cte_burst_without_tiling_TC2_for_val;
display is_tc2_burst_witout_tiling_for_val;
display burst_val_is_2;
display cte_1;
display burst_val_is_4;
display cte_2;
display burst_val_is_8;
display cte_3;
display burst_val_is_16;
display cte_4;
display y_is_fully_transfered_on_last_dim_FT0;
display burst_y_is_1;
display cte_5;
display cte_burst_without_tiling_TC0_for_y;
display is_tc0_burst_witout_tiling_for_y;
display cte_6;
display cte_burst_without_tiling_TC1_for_y;
display is_tc1_burst_witout_tiling_for_y;
display cte_7;
display burst_y_is_2;
display cte_8;
display cte_9;
display cte_10;
display burst_y_is_4;
display cte_11;
display cte_12;
display cte_13;
display burst_y_is_8;
display cte_14;
display cte_15;
display cte_16;
display burst_y_is_16;
display cte_17;
display cte_18;
display cte_19;
display x_is_fully_transfered_on_last_dim_FT0;
display burst_x_is_1;
display cte_20;
display cte_burst_without_tiling_TC1_for_x;
display is_tc1_burst_witout_tiling_for_x;
display burst_x_is_2;
display cte_21;
display burst_x_is_4;
display cte_22;
display burst_x_is_8;
display cte_23;
display burst_x_is_16;
display cte_24;
display footprint_tot_val_FT0;
display burst_val;
display footprint_tot_y_FT0;
display burst_y;
display footprint_tot_x_FT0;
display burst_x;
display Lat_comp_0_1;
display obj;
display cte_tiling_0;
display buffer_size;
display fifo_size;
display _total_solve_time;
