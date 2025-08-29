class count_sb;
event DONE;

count_trans sb_data;
count_trans refm_data;

mailbox #(count_trans) ref2sb;
mailbox #(count_trans) rdmn2sb;

static int ref_data, rm_data, data_verified;

function new(mailbox #(count_trans) ref2sb, mailbox #(count_trans) rdmn2sb);
        this.ref2sb = ref2sb;
        this.rdmn2sb = rdmn2sb;
endfunction : new

virtual task check(count_trans rddata);
        begin
        if(refm_data.count == rddata.count)
                $display("COMPARISION IS SUCCESSFUL");
        else
                $display("COMPARISION MISMATCH");
        end
        data_verified++;
        if(data_verified >= no_of_transactions+2 )      begin
                -> DONE;
        end
endtask


virtual task start();
        fork
                while(1)
                 begin
                        ref2sb.get(refm_data);
                        rm_data++;
                        rdmn2sb.get(sb_data);
                        ref_data++;
                        check(sb_data);
                end
        join_none
endtask

virtual function void report();
        $display("---------------------------SCOREBOARD REPORT------------------------------");
        $display("Data generated = %d",rm_data);
        $display("Data verified :%d",data_verified);
endfunction

endclass

"count_sb.sv" 52L, 1090C                                        
