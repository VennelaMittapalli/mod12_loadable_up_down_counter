class count_trans;

rand logic load;
rand logic [3:0] din;
rand logic up_down;
logic resetn;
logic [3:0] count;

constraint c1 {din inside {[2:6]};}
constraint c2 {load dist {1 := 30, 0 := 70};}
constraint c3 {up_down dist { 1 := 50, 0 := 50 };}

virtual function void display(input string s);
        $display("-----------------------%s-------------------------",s);
        $display("UP_DOWN : %d",up_down);
        $display("DATA_IN : %d",din);
        $display("COUNT : %d",count);
        $display("LOAD : %d",load);
        $display("RESET : %d",resetn);
        $display("OUTPUT : %d",count);
        $display("-------------------------------------------------");
endfunction

endclass : count_trans

~
~
