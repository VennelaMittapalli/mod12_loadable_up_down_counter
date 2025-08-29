class count_wr_monitor;

virtual count_if.WR_MON wrmon_if;
mailbox #(count_trans) mon2rm;
count_trans wr_data,data2rm;

function new(virtual count_if.WR_MON wrmon_if, mailbox #(count_trans) mon2rm);
        this.wrmon_if = wrmon_if;
        this.mon2rm = mon2rm;
        this.wr_data = new();
endfunction : new

virtual task monitor();
        @(wrmon_if.wr_cb);
        wr_data.load = wrmon_if.wr_cb.load;
        wr_data.din = wrmon_if.wr_cb.din;
        wr_data.up_down = wrmon_if.wr_cb.up_down;
        wr_data.display("FROM WRITE MONITOR");
endtask : monitor

virtual task start();
fork
        forever
        begin
                monitor();
                data2rm = new wr_data;
                mon2rm.put(data2rm);
        end
join_none
endtask : start

endclass : count_wr_monitor
