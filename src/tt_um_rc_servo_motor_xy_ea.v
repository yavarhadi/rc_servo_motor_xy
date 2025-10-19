module filter_shift_register
  (input  clk_i,
   input  reset_i,
   input  strb_data_valid_i,
   input  [7:0] data_i,
   output [7:0] data_o);
  wire [7:0] data;
  wire [7:0] next_data;
  wire [7:0] n278;
  reg [7:0] n280;
  assign data_o = data; //(module output)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:23:16  */
  assign data = n280; // (signal)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:23:22  */
  assign next_data = n278; // (signal)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:40:33  */
  assign n278 = strb_data_valid_i ? data_i : data;
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:31:33  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n280 <= 8'b00000000;
    else
      n280 <= next_data;
endmodule

module pwm
  (input  clk_i,
   input  reset_i,
   input  [7:0] period_counter_val_i,
   input  [7:0] on_counter_val_i,
   output pwm_pin_o);
  reg [7:0] clk_cnt;
  reg [7:0] next_clk_cnt;
  reg pwm_output;
  wire n259;
  wire n262;
  wire n263;
  wire [7:0] n265;
  wire [7:0] n267;
  reg [7:0] n269;
  assign pwm_pin_o = pwm_output; //(module output)
  /* ../../vhdl/rtl/pwm_ea.vhd:23:16  */
  always @*
    clk_cnt = n269; // (isignal)
  initial
    clk_cnt = 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:23:25  */
  always @*
    next_clk_cnt = n267; // (isignal)
  initial
    next_clk_cnt = 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:24:16  */
  always @*
    pwm_output = n262; // (isignal)
  initial
    pwm_output = 1'b0;
  /* ../../vhdl/rtl/pwm_ea.vhd:44:44  */
  assign n259 = $unsigned(clk_cnt) < $unsigned(on_counter_val_i);
  /* ../../vhdl/rtl/pwm_ea.vhd:44:33  */
  assign n262 = n259 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/pwm_ea.vhd:50:44  */
  assign n263 = $unsigned(clk_cnt) < $unsigned(period_counter_val_i);
  /* ../../vhdl/rtl/pwm_ea.vhd:51:65  */
  assign n265 = clk_cnt + 8'b00000001;
  /* ../../vhdl/rtl/pwm_ea.vhd:50:33  */
  assign n267 = n263 ? n265 : 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:35:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n269 <= 8'b00000000;
    else
      n269 <= next_clk_cnt;
endmodule

module dff
  (input  clk_i,
   input  reset_i,
   input  d_i,
   output q_o);
  reg n247;
  assign q_o = n247; //(module output)
  /* ../../vhdl/rtl/d_ff_ea.vhd:25:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n247 <= 1'b0;
    else
      n247 <= d_i;
endmodule

module adc_value
  (input  clk_i,
   input  reset_i,
   input  comparator_i,
   input  strb_i,
   output [7:0] adc_value_o);
  reg [7:0] adc_value_state;
  reg [7:0] next_adc_value;
  wire n227;
  wire [7:0] n229;
  wire [7:0] n230;
  wire n232;
  wire [7:0] n234;
  wire [7:0] n235;
  wire [7:0] n236;
  wire [7:0] n237;
  reg [7:0] n239;
  assign adc_value_o = adc_value_state; //(module output)
  /* ../../vhdl/rtl/adc_value_ea.vhd:23:16  */
  always @*
    adc_value_state = n239; // (isignal)
  initial
    adc_value_state = 8'b11111111;
  /* ../../vhdl/rtl/adc_value_ea.vhd:24:16  */
  always @*
    next_adc_value = n237; // (isignal)
  initial
    next_adc_value = 8'b11111111;
  /* ../../vhdl/rtl/adc_value_ea.vhd:44:52  */
  assign n227 = adc_value_state == 8'b11111010;
  /* ../../vhdl/rtl/adc_value_ea.vhd:47:74  */
  assign n229 = adc_value_state + 8'b00000001;
  /* ../../vhdl/rtl/adc_value_ea.vhd:44:33  */
  assign n230 = n227 ? adc_value_state : n229;
  /* ../../vhdl/rtl/adc_value_ea.vhd:50:52  */
  assign n232 = adc_value_state == 8'b00000000;
  /* ../../vhdl/rtl/adc_value_ea.vhd:53:74  */
  assign n234 = adc_value_state - 8'b00000001;
  /* ../../vhdl/rtl/adc_value_ea.vhd:50:33  */
  assign n235 = n232 ? adc_value_state : n234;
  /* ../../vhdl/rtl/adc_value_ea.vhd:43:25  */
  assign n236 = comparator_i ? n230 : n235;
  /* ../../vhdl/rtl/adc_value_ea.vhd:42:17  */
  assign n237 = strb_i ? n236 : adc_value_state;
  /* ../../vhdl/rtl/adc_value_ea.vhd:32:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n239 <= 8'b00000000;
    else
      n239 <= next_adc_value;
endmodule

module moving_average
  (input  clk_i,
   input  reset_i,
   input  strb_data_valid_i,
   input  [7:0] data_i,
   output strb_data_valid_o,
   output [7:0] data_o);
  reg [63:0] moving_average_value;
  reg [7:0] data_o_reg;
  reg strb_data_valid_o_reg;
  wire [7:0] \gen_reg_0_register_i0.data_o ;
  wire [7:0] \gen_reg_rest_gen_regs_n1_register_i.data_o ;
  wire [7:0] n155;
  wire [7:0] \gen_reg_rest_gen_regs_n2_register_i.data_o ;
  wire [7:0] n157;
  wire [7:0] \gen_reg_rest_gen_regs_n3_register_i.data_o ;
  wire [7:0] n159;
  wire [7:0] \gen_reg_rest_gen_regs_n4_register_i.data_o ;
  wire [7:0] n161;
  wire [7:0] \gen_reg_rest_gen_regs_n5_register_i.data_o ;
  wire [7:0] n163;
  wire [7:0] \gen_reg_rest_gen_regs_n6_register_i.data_o ;
  wire [7:0] n165;
  wire [7:0] \gen_reg_rest_gen_regs_n7_register_i.data_o ;
  wire [7:0] n167;
  wire [7:0] n173;
  wire [10:0] n174;
  wire [10:0] n176;
  wire [7:0] n178;
  wire [10:0] n179;
  wire [10:0] n180;
  wire [7:0] n181;
  wire [10:0] n182;
  wire [10:0] n183;
  wire [7:0] n184;
  wire [10:0] n185;
  wire [10:0] n186;
  wire [7:0] n187;
  wire [10:0] n188;
  wire [10:0] n189;
  wire [7:0] n190;
  wire [10:0] n191;
  wire [10:0] n192;
  wire [7:0] n193;
  wire [10:0] n194;
  wire [10:0] n195;
  wire [7:0] n196;
  wire [10:0] n197;
  wire [10:0] n198;
  wire [10:0] n200;
  wire [7:0] n201;
  wire [7:0] n202;
  wire [7:0] n205;
  wire n207;
  wire [63:0] n213;
  reg [7:0] n214;
  reg n215;
  assign strb_data_valid_o = strb_data_valid_o_reg; //(module output)
  assign data_o = data_o_reg; //(module output)
  /* ../../vhdl/rtl/moving_average_ea.vhd:45:12  */
  always @*
    moving_average_value = n213; // (isignal)
  initial
    moving_average_value = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:48:12  */
  always @*
    data_o_reg = n214; // (isignal)
  initial
    data_o_reg = 8'b00000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:49:12  */
  always @*
    strb_data_valid_o_reg = n215; // (isignal)
  initial
    strb_data_valid_o_reg = 1'b0;
  /* ../../vhdl/rtl/moving_average_ea.vhd:58:17  */
  filter_shift_register gen_reg_0_register_i0 (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(data_i),
    .data_o(\gen_reg_0_register_i0.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n1_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n155),
    .data_o(\gen_reg_rest_gen_regs_n1_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n155 = moving_average_value[63:56]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n2_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n157),
    .data_o(\gen_reg_rest_gen_regs_n2_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n157 = moving_average_value[55:48]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n3_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n159),
    .data_o(\gen_reg_rest_gen_regs_n3_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n159 = moving_average_value[47:40]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n4_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n161),
    .data_o(\gen_reg_rest_gen_regs_n4_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n161 = moving_average_value[39:32]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n5_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n163),
    .data_o(\gen_reg_rest_gen_regs_n5_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n163 = moving_average_value[31:24]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n6_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n165),
    .data_o(\gen_reg_rest_gen_regs_n6_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n165 = moving_average_value[23:16]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n7_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n167),
    .data_o(\gen_reg_rest_gen_regs_n7_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n167 = moving_average_value[15:8]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n173 = moving_average_value[63:56]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n174 = {3'b0, n173};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n176 = 11'b00000000000 + n174;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n178 = moving_average_value[55:48]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n179 = {3'b0, n178};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n180 = n176 + n179;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n181 = moving_average_value[47:40]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n182 = {3'b0, n181};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n183 = n180 + n182;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n184 = moving_average_value[39:32]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n185 = {3'b0, n184};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n186 = n183 + n185;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n187 = moving_average_value[31:24]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n188 = {3'b0, n187};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n189 = n186 + n188;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n190 = moving_average_value[23:16]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n191 = {3'b0, n190};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n192 = n189 + n191;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n193 = moving_average_value[15:8]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n194 = {3'b0, n193};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n195 = n192 + n194;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n196 = moving_average_value[7:0]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n197 = {3'b0, n196};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n198 = n195 + n197;
  /* ../../vhdl/rtl/moving_average_ea.vhd:105:62  */
  assign n200 = n198 >> 31'b0000000000000000000000000000011;
  /* ../../vhdl/rtl/moving_average_ea.vhd:105:55  */
  assign n201 = n200[7:0];  // trunc
  /* ../../vhdl/rtl/moving_average_ea.vhd:95:17  */
  assign n202 = strb_data_valid_i ? n201 : data_o_reg;
  /* ../../vhdl/rtl/moving_average_ea.vhd:88:13  */
  assign n205 = reset_i ? 8'b00000000 : n202;
  /* ../../vhdl/rtl/moving_average_ea.vhd:88:13  */
  assign n207 = reset_i ? 1'b0 : strb_data_valid_i;
  assign n213 = {\gen_reg_0_register_i0.data_o , \gen_reg_rest_gen_regs_n1_register_i.data_o , \gen_reg_rest_gen_regs_n2_register_i.data_o , \gen_reg_rest_gen_regs_n3_register_i.data_o , \gen_reg_rest_gen_regs_n4_register_i.data_o , \gen_reg_rest_gen_regs_n5_register_i.data_o , \gen_reg_rest_gen_regs_n6_register_i.data_o , \gen_reg_rest_gen_regs_n7_register_i.data_o };
  /* ../../vhdl/rtl/moving_average_ea.vhd:87:9  */
  always @(posedge clk_i)
    n214 <= n205;
  initial
    n214 = 8'b00000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:87:9  */
  always @(posedge clk_i)
    n215 <= n207;
  initial
    n215 = 1'b0;
endmodule

module deltaadc
  (input  clk_i,
   input  reset_i,
   input  comparator_i,
   input  strb_signal_i,
   output adc_valid_strb_o,
   output pwm_o,
   output [7:0] adc_value_o);
  wire [7:0] adc_value_signal;
  wire \d_ff_port.q_o ;
  wire \pwm_port.pwm_pin_o ;
  localparam [7:0] n147 = 8'b11111010;
  assign adc_valid_strb_o = \d_ff_port.q_o ; //(module output)
  assign pwm_o = \pwm_port.pwm_pin_o ; //(module output)
  assign adc_value_o = adc_value_signal; //(module output)
  /* ../../vhdl/rtl/DeltaADC_ea.vhd:30:17  */
  adc_value adc_value_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .comparator_i(comparator_i),
    .strb_i(strb_signal_i),
    .adc_value_o(adc_value_signal));
  /* ../../vhdl/rtl/DeltaADC_ea.vhd:39:17  */
  dff d_ff_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .d_i(strb_signal_i),
    .q_o(\d_ff_port.q_o ));
  /* ../../vhdl/rtl/DeltaADC_ea.vhd:47:17  */
  pwm pwm_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .period_counter_val_i(n147),
    .on_counter_val_i(adc_value_signal),
    .pwm_pin_o(\pwm_port.pwm_pin_o ));
endmodule

module synchronizer_1
  (input  clk_i,
   input  reset_i,
   input  async_i,
   output sync_o);
  reg sync_reg;
  reg n141;
  assign sync_o = sync_reg; //(module output)
  /* ../../vhdl/rtl/synchonizer_ea.vhd:22:16  */
  always @*
    sync_reg = n141; // (isignal)
  initial
    sync_reg = 1'b0;
  /* ../../vhdl/rtl/synchonizer_ea.vhd:28:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n141 <= 1'b0;
    else
      n141 <= async_i;
endmodule

module strb_generator
  (input  clk_i,
   input  reset_i,
   output strb_o);
  reg [19:0] strb_cnt;
  reg [19:0] next_strb_cnt;
  wire strb_cnt_out;
  wire n122;
  wire [19:0] n124;
  wire [19:0] n126;
  wire n129;
  reg [19:0] n131;
  assign strb_o = strb_cnt_out; //(module output)
  /* ../../vhdl/rtl/strb_ea.vhd:22:16  */
  always @*
    strb_cnt = n131; // (isignal)
  initial
    strb_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:23:16  */
  always @*
    next_strb_cnt = n126; // (isignal)
  initial
    next_strb_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:24:16  */
  assign strb_cnt_out = n129; // (signal)
  /* ../../vhdl/rtl/strb_ea.vhd:43:37  */
  assign n122 = $unsigned(strb_cnt) < $unsigned(20'b11110100001001000000);
  /* ../../vhdl/rtl/strb_ea.vhd:45:59  */
  assign n124 = strb_cnt + 20'b00000000000000000001;
  /* ../../vhdl/rtl/strb_ea.vhd:43:25  */
  assign n126 = n122 ? n124 : 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:43:25  */
  assign n129 = n122 ? 1'b0 : 1'b1;
  /* ../../vhdl/rtl/strb_ea.vhd:34:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n131 <= 20'b00000000000000000000;
    else
      n131 <= next_strb_cnt;
endmodule

module servo_control
  (input  clk_i,
   input  reset_i,
   input  [19:0] period_counter_val_i,
   input  [16:0] on_counter_val_i,
   output pwm_pin_o);
  reg [19:0] clk_cnt;
  reg [19:0] next_clk_cnt;
  wire [19:0] n97;
  wire n98;
  wire n101;
  wire [19:0] n103;
  wire n104;
  wire [19:0] n106;
  wire [19:0] n108;
  reg [19:0] n110;
  assign pwm_pin_o = n101; //(module output)
  /* ../../vhdl/rtl/servo_control_ea.vhd:23:16  */
  always @*
    clk_cnt = n110; // (isignal)
  initial
    clk_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:24:16  */
  always @*
    next_clk_cnt = n108; // (isignal)
  initial
    next_clk_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:44  */
  assign n97 = {3'b0, on_counter_val_i};  //  uext
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:44  */
  assign n98 = $unsigned(clk_cnt) < $unsigned(n97);
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:33  */
  assign n101 = n98 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:66  */
  assign n103 = period_counter_val_i - 20'b00000000000000000001;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:44  */
  assign n104 = $unsigned(clk_cnt) < $unsigned(n103);
  /* ../../vhdl/rtl/servo_control_ea.vhd:48:65  */
  assign n106 = clk_cnt + 20'b00000000000000000001;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:33  */
  assign n108 = n104 ? n106 : 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:31:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n110 <= 20'b00000000000000000000;
    else
      n110 <= next_clk_cnt;
endmodule

module tilt
  (input  clk_i,
   input  reset_i,
   input  [7:0] hold_value_i,
   output [16:0] on_counter_val_o);
  reg [16:0] on_value;
  reg [16:0] next_on_value;
  wire n66;
  wire n68;
  wire n70;
  wire [7:0] n72;
  wire [15:0] n73;
  wire [15:0] n75;
  wire [16:0] n77;
  wire [16:0] n78;
  wire [16:0] n80;
  wire [16:0] n82;
  wire [16:0] n84;
  reg [16:0] n86;
  assign on_counter_val_o = on_value; //(module output)
  /* ../../vhdl/rtl/Tilt_ea.vhd:24:16  */
  always @*
    on_value = n86; // (isignal)
  initial
    on_value = 17'b00000000000000000;
  /* ../../vhdl/rtl/Tilt_ea.vhd:25:16  */
  always @*
    next_on_value = n84; // (isignal)
  initial
    next_on_value = 17'b00000000000000000;
  /* ../../vhdl/rtl/Tilt_ea.vhd:41:29  */
  assign n66 = $unsigned(hold_value_i) < $unsigned(8'b01011011);
  /* ../../vhdl/rtl/Tilt_ea.vhd:44:32  */
  assign n68 = $unsigned(hold_value_i) >= $unsigned(8'b10001001);
  /* ../../vhdl/rtl/Tilt_ea.vhd:47:44  */
  assign n70 = hold_value_i == 8'b01110010;
  /* ../../vhdl/rtl/Tilt_ea.vhd:51:104  */
  assign n72 = hold_value_i - 8'b01011010;
  /* ../../vhdl/rtl/Tilt_ea.vhd:51:109  */
  assign n73 = {8'b0, n72};  //  uext
  /* ../../vhdl/rtl/Tilt_ea.vhd:51:109  */
  assign n75 = $signed(n73) * $signed(16'b0000010000111111); // smul
  /* ../../vhdl/rtl/Tilt_ea.vhd:51:78  */
  assign n77 = {1'b0, n75};  //  uext
  /* ../../vhdl/rtl/Tilt_ea.vhd:51:78  */
  assign n78 = 17'b01100001101010000 + n77;
  /* ../../vhdl/rtl/Tilt_ea.vhd:47:25  */
  assign n80 = n70 ? 17'b10010010011111000 : n78;
  /* ../../vhdl/rtl/Tilt_ea.vhd:44:13  */
  assign n82 = n68 ? 17'b11000011010100000 : n80;
  /* ../../vhdl/rtl/Tilt_ea.vhd:41:13  */
  assign n84 = n66 ? 17'b01100001101010000 : n82;
  /* ../../vhdl/rtl/Tilt_ea.vhd:31:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n86 <= 17'b00000000000000000;
    else
      n86 <= next_on_value;
endmodule

module holdvalueonstrb
  (input  clk_i,
   input  reset_i,
   input  adc_valid_strb_i,
   input  [7:0] adc_value_i,
   output [7:0] holdvalue_o);
  reg [7:0] holdvalue;
  reg [7:0] next_holdvalue;
  wire [7:0] n52;
  reg [7:0] n54;
  assign holdvalue_o = holdvalue; //(module output)
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:24:16  */
  always @*
    holdvalue = n54; // (isignal)
  initial
    holdvalue = 8'b00000000;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:25:16  */
  always @*
    next_holdvalue = n52; // (isignal)
  initial
    next_holdvalue = 8'b00000000;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:42:17  */
  assign n52 = adc_valid_strb_i ? adc_value_i : holdvalue;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:33:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n54 <= 8'b00000000;
    else
      n54 <= next_holdvalue;
endmodule

module delta_adc_xy
  (input  clk_i,
   input  reset_i,
   input  comp_async_x_i,
   input  comp_async_y_i,
   output pwm_x_o,
   output pwm_y_o,
   output adc_valid_strb_x_o,
   output adc_valid_strb_y_o,
   output [7:0] adc_value_x_o,
   output [7:0] adc_value_y_o);
  wire strb_signal;
  wire comp_synch_x;
  wire comp_synch_y;
  wire adc_valid_strb_x;
  wire adc_valid_strb_y;
  wire [7:0] adc_value_x;
  wire [7:0] adc_value_y;
  wire \delta_adc_port_x.pwm_o ;
  wire \delta_adc_port_y.pwm_o ;
  wire \moving_average_x_port.strb_data_valid_o ;
  wire [7:0] \moving_average_x_port.data_o ;
  wire \moving_average_y_port.strb_data_valid_o ;
  wire [7:0] \moving_average_y_port.data_o ;
  assign pwm_x_o = \delta_adc_port_x.pwm_o ; //(module output)
  assign pwm_y_o = \delta_adc_port_y.pwm_o ; //(module output)
  assign adc_valid_strb_x_o = \moving_average_x_port.strb_data_valid_o ; //(module output)
  assign adc_valid_strb_y_o = \moving_average_y_port.strb_data_valid_o ; //(module output)
  assign adc_value_x_o = \moving_average_x_port.data_o ; //(module output)
  assign adc_value_y_o = \moving_average_y_port.data_o ; //(module output)
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:47:17  */
  strb_generator strb_generator_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_o(strb_signal));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:54:9  */
  synchronizer_1 synchronizer_port_x (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .async_i(comp_async_x_i),
    .sync_o(comp_synch_x));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:63:17  */
  synchronizer_1 synchronizer_port_y (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .async_i(comp_async_y_i),
    .sync_o(comp_synch_y));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:72:9  */
  deltaadc delta_adc_port_x (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .comparator_i(comp_synch_x),
    .strb_signal_i(strb_signal),
    .adc_valid_strb_o(adc_valid_strb_x),
    .pwm_o(\delta_adc_port_x.pwm_o ),
    .adc_value_o(adc_value_x));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:83:9  */
  deltaadc delta_adc_port_y (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .comparator_i(comp_synch_y),
    .strb_signal_i(strb_signal),
    .adc_valid_strb_o(adc_valid_strb_y),
    .pwm_o(\delta_adc_port_y.pwm_o ),
    .adc_value_o(adc_value_y));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:94:17  */
  moving_average moving_average_x_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(adc_valid_strb_x),
    .data_i(adc_value_x),
    .strb_data_valid_o(\moving_average_x_port.strb_data_valid_o ),
    .data_o(\moving_average_x_port.data_o ));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:105:17  */
  moving_average moving_average_y_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(adc_valid_strb_y),
    .data_i(adc_value_y),
    .strb_data_valid_o(\moving_average_y_port.strb_data_valid_o ),
    .data_o(\moving_average_y_port.data_o ));
endmodule

module rc_servo_xy
  (input  clk_i,
   input  reset_i,
   input  comp_async_x_i,
   input  comp_async_y_i,
   output pwm_pin_x_o,
   output pwm_pin_y_o);
  wire adc_valid_strb_x;
  wire adc_valid_strb_y;
  wire [7:0] adc_value_x;
  wire [7:0] adc_value_y;
  wire [7:0] holdvalue_x;
  wire [7:0] holdvalue_y;
  wire [16:0] on_counter_val_x;
  wire [16:0] on_counter_val_y;
  wire reset_n;
  wire n2;
  wire \delta_adc_port.pwm_x_o ;
  wire \delta_adc_port.pwm_y_o ;
  wire \servo_control_x_port.pwm_pin_o ;
  localparam [19:0] n13 = 20'b11110100001001000000;
  wire \servo_control_y_port.pwm_pin_o ;
  localparam [19:0] n15 = 20'b11110100001001000000;
  assign pwm_pin_x_o = \servo_control_x_port.pwm_pin_o ; //(module output)
  assign pwm_pin_y_o = \servo_control_y_port.pwm_pin_o ; //(module output)
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:40:16  */
  assign reset_n = n2; // (signal)
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:44:28  */
  assign n2 = ~reset_i;
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:46:17  */
  delta_adc_xy delta_adc_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .comp_async_x_i(comp_async_x_i),
    .comp_async_y_i(comp_async_y_i),
    .pwm_x_o(),
    .pwm_y_o(),
    .adc_valid_strb_x_o(adc_valid_strb_x),
    .adc_valid_strb_y_o(adc_valid_strb_y),
    .adc_value_x_o(adc_value_x),
    .adc_value_y_o(adc_value_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:60:17  */
  holdvalueonstrb holdvalue_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .adc_valid_strb_i(adc_valid_strb_x),
    .adc_value_i(adc_value_x),
    .holdvalue_o(holdvalue_x));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:69:17  */
  holdvalueonstrb holdvalue_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .adc_valid_strb_i(adc_valid_strb_y),
    .adc_value_i(adc_value_y),
    .holdvalue_o(holdvalue_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:78:17  */
  tilt tilt_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .hold_value_i(holdvalue_x),
    .on_counter_val_o(on_counter_val_x));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:86:17  */
  tilt tilt_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .hold_value_i(holdvalue_y),
    .on_counter_val_o(on_counter_val_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:94:17  */
  servo_control servo_control_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .period_counter_val_i(n13),
    .on_counter_val_i(on_counter_val_x),
    .pwm_pin_o(\servo_control_x_port.pwm_pin_o ));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:103:17  */
  servo_control servo_control_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .period_counter_val_i(n15),
    .on_counter_val_i(on_counter_val_y),
    .pwm_pin_o(\servo_control_y_port.pwm_pin_o ));
endmodule

