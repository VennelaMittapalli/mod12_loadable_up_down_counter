class count_model;

count_trans w_data;

mailbox #(count_trans) wrmon2rm;
mailbox #(count_trans) rm2sb;

static logic [3:0] ref_count = 0;

function new(mailbox #(count_trans)wrmon2rm, mailbox #(count_trans) rm2sb);
        this.wrmon2rm = wrmon2rm;
        this.rm2sb = rm2sb;
endfunction : new

virtual task count_mod(count_trans model_counter);
        begin
                if(model_counter.resetn) ref_count <= 4'b0000;
                else if(model_counter.load)
                        ref_count <= model_counter.din;
                else
                                begin
                                if(model_counter.up_down == 1)
                                begin
                                        if(ref_count > 12)
                                                ref_count <= 4'd0;
                                        else
                                                ref_count <= ref_count + 1'b1;
                                end
                                else if (model_counter.up_down == 0)
                                begin
                                        if(ref_count < 0)
                                                ref_count <= 4'd11;
                                        else
                                                ref_count <= ref_count - 1'b1;
                                end
                        end
        end
endtask : count_mod

virtual task start();
fork
        begin
                forever
                        begin
                                wrmon2rm.get(w_data);
                                count_mod(w_data);
                                w_data.count = ref_count;
                                rm2sb.put(w_data);
                        end
        end
join_none
endtask : start

endclass
