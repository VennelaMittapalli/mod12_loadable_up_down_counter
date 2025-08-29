package count_pkg;
int no_of_transactions = 1;
`include "count_trans.sv"
`include "count_gen.sv"
`include "count_driver.sv"
`include "count_wr_monitor.sv"
`include "count_rd_monitor.sv"
`include "count_model.sv"
`include "count_sb.sv"
`include "count_env.sv"
`include "test.sv"
endpackage
