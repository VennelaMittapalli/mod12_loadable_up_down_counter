class test;

virtual count_if.DRV dr_if;
virtual count_if.WR_MON wrmon_if;
virtual count_if.RD_MON rdmon_if;

count_env env_h;

function new(virtual count_if.DRV dr_if, virtual count_if.WR_MON wrmon_if,virtual count_if.RD_MON rdmon_if);
        this.dr_if = dr_if;
        this.wrmon_if = wrmon_if;
        this.rdmon_if = rdmon_if;
        env_h = new(dr_if,rdmon_if,wrmon_if);
endfunction : new

virtual task build();
        env_h.build();
endtask : build

virtual task run();
        env_h.run();
endtask : run

endclass : test
~
~
