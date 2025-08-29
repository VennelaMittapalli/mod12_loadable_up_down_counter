class count_driver;

virtual count_if.DRV dr_if;
count_trans data2duv;

mailbox #(count_trans) gen2dr;

function new(virtual count_if.DRV dr_if, mailbox #(count_trans) gen2dr);
        this.dr_if = dr_if;
        this.gen2dr = gen2dr;
endfunction : new

virtual task drive();
        @(dr_if.dr_cb);
        dr_if.dr_cb.load <= data2duv.load;
        dr_if.dr_cb.up_down <= data2duv.up_down;
        dr_if.dr_cb.din <= data2duv.din;
endtask : drive

virtual task start();
fork
        forever begin
        gen2dr.get(data2duv);
        drive();
        end
join_none

endtask : start

endclass : count_driver
