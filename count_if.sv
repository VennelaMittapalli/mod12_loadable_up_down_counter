interface count_if(input bit clock);

logic [3:0] din;
logic load;
logic up_down;
logic resetn;
logic [3:0] count;

clocking dr_cb@(posedge clock);
default input #1 output #1;
output load;
output din;
output up_down;
output resetn;
endclocking : dr_cb


clocking wr_cb@(posedge clock);
default input #1 output #1;
input load;
input din;
input up_down;
input resetn;
endclocking : wr_cb


clocking rd_cb@(posedge clock);
default input #1 output #1;
input count;
endclocking : rd_cb

modport DRV(clocking dr_cb);

modport WR_MON(clocking wr_cb);

modport RD_MON(clocking rd_cb);

endinterface
