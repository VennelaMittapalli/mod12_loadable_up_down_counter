class count_rd_monitor;

virtual count_if.RD_MON rdmon_if;

mailbox #(count_trans) mon2sb;

count_trans rd_data,data2sb;

function new(virtual count_if.RD_MON rdmon_if, mailbox #(count_trans) mon2sb);
        this.rdmon_if = rdmon_if;
        this.mon2sb = mon2sb;
        this.rd_data = new();
endfunction : new

virtual task monitor();
        @(rdmon_if.rd_cb);
        rd_data.count=rdmon_if.rd_cb.count;
        rd_data.display("FROM READ MONITOR");
endtask : monitor

virtual task start();
fork
        forever
        begin
                monitor();
                data2sb = new rd_data;
                mon2sb.put(data2sb);
        end
join_none
endtask : start

endclass : count_rd_monitor
