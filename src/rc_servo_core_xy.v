module filter_shift_register
  (input  clk_i,
   input  reset_i,
   input  strb_data_valid_i,
   input  [7:0] data_i,
   output [7:0] data_o);
  wire [7:0] data;
  wire [7:0] next_data;
  wire [7:0] n284;
  reg [7:0] n286;
  assign data_o = data; //(module output)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:23:16  */
  assign data = n286; // (signal)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:23:22  */
  assign next_data = n284; // (signal)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:40:33  */
  assign n284 = strb_data_valid_i ? data_i : data;
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:31:33  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n286 <= 8'b00000000;
    else
      n286 <= next_data;
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
  wire n265;
  wire n268;
  wire n269;
  wire [7:0] n271;
  wire [7:0] n273;
  reg [7:0] n275;
  assign pwm_pin_o = pwm_output; //(module output)
  /* ../../vhdl/rtl/pwm_ea.vhd:23:16  */
  always @*
    clk_cnt = n275; // (isignal)
  initial
    clk_cnt = 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:23:25  */
  always @*
    next_clk_cnt = n273; // (isignal)
  initial
    next_clk_cnt = 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:24:16  */
  always @*
    pwm_output = n268; // (isignal)
  initial
    pwm_output = 1'b0;
  /* ../../vhdl/rtl/pwm_ea.vhd:44:44  */
  assign n265 = $unsigned(clk_cnt) < $unsigned(on_counter_val_i);
  /* ../../vhdl/rtl/pwm_ea.vhd:44:33  */
  assign n268 = n265 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/pwm_ea.vhd:50:44  */
  assign n269 = $unsigned(clk_cnt) < $unsigned(period_counter_val_i);
  /* ../../vhdl/rtl/pwm_ea.vhd:51:65  */
  assign n271 = clk_cnt + 8'b00000001;
  /* ../../vhdl/rtl/pwm_ea.vhd:50:33  */
  assign n273 = n269 ? n271 : 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:35:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n275 <= 8'b00000000;
    else
      n275 <= next_clk_cnt;
endmodule

module dff
  (input  clk_i,
   input  reset_i,
   input  d_i,
   output q_o);
  reg n253;
  assign q_o = n253; //(module output)
  /* ../../vhdl/rtl/d_ff_ea.vhd:25:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n253 <= 1'b0;
    else
      n253 <= d_i;
endmodule

module adc_value
  (input  clk_i,
   input  reset_i,
   input  comparator_i,
   input  strb_i,
   output [7:0] adc_value_o);
  reg [7:0] adc_value_state;
  reg [7:0] next_adc_value;
  wire n233;
  wire [7:0] n235;
  wire [7:0] n236;
  wire n238;
  wire [7:0] n240;
  wire [7:0] n241;
  wire [7:0] n242;
  wire [7:0] n243;
  reg [7:0] n245;
  assign adc_value_o = adc_value_state; //(module output)
  /* ../../vhdl/rtl/adc_value_ea.vhd:23:16  */
  always @*
    adc_value_state = n245; // (isignal)
  initial
    adc_value_state = 8'b11111111;
  /* ../../vhdl/rtl/adc_value_ea.vhd:24:16  */
  always @*
    next_adc_value = n243; // (isignal)
  initial
    next_adc_value = 8'b11111111;
  /* ../../vhdl/rtl/adc_value_ea.vhd:44:52  */
  assign n233 = adc_value_state == 8'b11111010;
  /* ../../vhdl/rtl/adc_value_ea.vhd:47:74  */
  assign n235 = adc_value_state + 8'b00000001;
  /* ../../vhdl/rtl/adc_value_ea.vhd:44:33  */
  assign n236 = n233 ? adc_value_state : n235;
  /* ../../vhdl/rtl/adc_value_ea.vhd:50:52  */
  assign n238 = adc_value_state == 8'b00000000;
  /* ../../vhdl/rtl/adc_value_ea.vhd:53:74  */
  assign n240 = adc_value_state - 8'b00000001;
  /* ../../vhdl/rtl/adc_value_ea.vhd:50:33  */
  assign n241 = n238 ? adc_value_state : n240;
  /* ../../vhdl/rtl/adc_value_ea.vhd:43:25  */
  assign n242 = comparator_i ? n236 : n241;
  /* ../../vhdl/rtl/adc_value_ea.vhd:42:17  */
  assign n243 = strb_i ? n242 : adc_value_state;
  /* ../../vhdl/rtl/adc_value_ea.vhd:32:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n245 <= 8'b00000000;
    else
      n245 <= next_adc_value;
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
  wire [7:0] n161;
  wire [7:0] \gen_reg_rest_gen_regs_n2_register_i.data_o ;
  wire [7:0] n163;
  wire [7:0] \gen_reg_rest_gen_regs_n3_register_i.data_o ;
  wire [7:0] n165;
  wire [7:0] \gen_reg_rest_gen_regs_n4_register_i.data_o ;
  wire [7:0] n167;
  wire [7:0] \gen_reg_rest_gen_regs_n5_register_i.data_o ;
  wire [7:0] n169;
  wire [7:0] \gen_reg_rest_gen_regs_n6_register_i.data_o ;
  wire [7:0] n171;
  wire [7:0] \gen_reg_rest_gen_regs_n7_register_i.data_o ;
  wire [7:0] n173;
  wire [7:0] n179;
  wire [10:0] n180;
  wire [10:0] n182;
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
  wire [7:0] n199;
  wire [10:0] n200;
  wire [10:0] n201;
  wire [7:0] n202;
  wire [10:0] n203;
  wire [10:0] n204;
  wire [10:0] n206;
  wire [7:0] n207;
  wire [7:0] n208;
  wire [7:0] n211;
  wire n213;
  wire [63:0] n219;
  reg [7:0] n220;
  reg n221;
  assign strb_data_valid_o = strb_data_valid_o_reg; //(module output)
  assign data_o = data_o_reg; //(module output)
  /* ../../vhdl/rtl/moving_average_ea.vhd:45:12  */
  always @*
    moving_average_value = n219; // (isignal)
  initial
    moving_average_value = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:48:12  */
  always @*
    data_o_reg = n220; // (isignal)
  initial
    data_o_reg = 8'b00000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:49:12  */
  always @*
    strb_data_valid_o_reg = n221; // (isignal)
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
    .data_i(n161),
    .data_o(\gen_reg_rest_gen_regs_n1_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n161 = moving_average_value[63:56]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n2_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n163),
    .data_o(\gen_reg_rest_gen_regs_n2_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n163 = moving_average_value[55:48]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n3_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n165),
    .data_o(\gen_reg_rest_gen_regs_n3_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n165 = moving_average_value[47:40]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n4_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n167),
    .data_o(\gen_reg_rest_gen_regs_n4_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n167 = moving_average_value[39:32]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n5_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n169),
    .data_o(\gen_reg_rest_gen_regs_n5_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n169 = moving_average_value[31:24]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n6_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n171),
    .data_o(\gen_reg_rest_gen_regs_n6_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n171 = moving_average_value[23:16]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n7_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n173),
    .data_o(\gen_reg_rest_gen_regs_n7_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n173 = moving_average_value[15:8]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n179 = moving_average_value[63:56]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n180 = {3'b0, n179};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n182 = 11'b00000000000 + n180;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n184 = moving_average_value[55:48]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n185 = {3'b0, n184};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n186 = n182 + n185;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n187 = moving_average_value[47:40]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n188 = {3'b0, n187};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n189 = n186 + n188;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n190 = moving_average_value[39:32]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n191 = {3'b0, n190};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n192 = n189 + n191;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n193 = moving_average_value[31:24]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n194 = {3'b0, n193};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n195 = n192 + n194;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n196 = moving_average_value[23:16]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n197 = {3'b0, n196};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n198 = n195 + n197;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n199 = moving_average_value[15:8]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n200 = {3'b0, n199};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n201 = n198 + n200;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n202 = moving_average_value[7:0]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n203 = {3'b0, n202};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n204 = n201 + n203;
  /* ../../vhdl/rtl/moving_average_ea.vhd:105:62  */
  assign n206 = n204 >> 31'b0000000000000000000000000000011;
  /* ../../vhdl/rtl/moving_average_ea.vhd:105:55  */
  assign n207 = n206[7:0];  // trunc
  /* ../../vhdl/rtl/moving_average_ea.vhd:95:17  */
  assign n208 = strb_data_valid_i ? n207 : data_o_reg;
  /* ../../vhdl/rtl/moving_average_ea.vhd:88:13  */
  assign n211 = reset_i ? 8'b00000000 : n208;
  /* ../../vhdl/rtl/moving_average_ea.vhd:88:13  */
  assign n213 = reset_i ? 1'b0 : strb_data_valid_i;
  assign n219 = {\gen_reg_0_register_i0.data_o , \gen_reg_rest_gen_regs_n1_register_i.data_o , \gen_reg_rest_gen_regs_n2_register_i.data_o , \gen_reg_rest_gen_regs_n3_register_i.data_o , \gen_reg_rest_gen_regs_n4_register_i.data_o , \gen_reg_rest_gen_regs_n5_register_i.data_o , \gen_reg_rest_gen_regs_n6_register_i.data_o , \gen_reg_rest_gen_regs_n7_register_i.data_o };
  /* ../../vhdl/rtl/moving_average_ea.vhd:87:9  */
  always @(posedge clk_i)
    n220 <= n211;
  initial
    n220 = 8'b00000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:87:9  */
  always @(posedge clk_i)
    n221 <= n213;
  initial
    n221 = 1'b0;
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
  localparam [7:0] n153 = 8'b11111010;
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
    .period_counter_val_i(n153),
    .on_counter_val_i(adc_value_signal),
    .pwm_pin_o(\pwm_port.pwm_pin_o ));
endmodule

module synchronizer_1
  (input  clk_i,
   input  reset_i,
   input  async_i,
   output sync_o);
  reg sync_reg;
  reg n147;
  assign sync_o = sync_reg; //(module output)
  /* ../../vhdl/rtl/synchonizer_ea.vhd:22:16  */
  always @*
    sync_reg = n147; // (isignal)
  initial
    sync_reg = 1'b0;
  /* ../../vhdl/rtl/synchonizer_ea.vhd:28:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n147 <= 1'b0;
    else
      n147 <= async_i;
endmodule

module strb_generator
  (input  clk_i,
   input  reset_i,
   output strb_o);
  reg [19:0] strb_cnt;
  reg [19:0] next_strb_cnt;
  wire strb_cnt_out;
  wire n128;
  wire [19:0] n130;
  wire [19:0] n132;
  wire n135;
  reg [19:0] n137;
  assign strb_o = strb_cnt_out; //(module output)
  /* ../../vhdl/rtl/strb_ea.vhd:22:16  */
  always @*
    strb_cnt = n137; // (isignal)
  initial
    strb_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:23:16  */
  always @*
    next_strb_cnt = n132; // (isignal)
  initial
    next_strb_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:24:16  */
  assign strb_cnt_out = n135; // (signal)
  /* ../../vhdl/rtl/strb_ea.vhd:43:37  */
  assign n128 = $unsigned(strb_cnt) < $unsigned(20'b11110100001001000000);
  /* ../../vhdl/rtl/strb_ea.vhd:45:59  */
  assign n130 = strb_cnt + 20'b00000000000000000001;
  /* ../../vhdl/rtl/strb_ea.vhd:43:25  */
  assign n132 = n128 ? n130 : 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:43:25  */
  assign n135 = n128 ? 1'b0 : 1'b1;
  /* ../../vhdl/rtl/strb_ea.vhd:34:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n137 <= 20'b00000000000000000000;
    else
      n137 <= next_strb_cnt;
endmodule

module servo_control
  (input  clk_i,
   input  reset_i,
   input  [19:0] period_counter_val_i,
   input  [16:0] on_counter_val_i,
   output pwm_pin_o);
  reg [19:0] clk_cnt;
  reg [19:0] next_clk_cnt;
  wire [19:0] n103;
  wire n104;
  wire n107;
  wire [19:0] n109;
  wire n110;
  wire [19:0] n112;
  wire [19:0] n114;
  reg [19:0] n116;
  assign pwm_pin_o = n107; //(module output)
  /* ../../vhdl/rtl/servo_control_ea.vhd:23:16  */
  always @*
    clk_cnt = n116; // (isignal)
  initial
    clk_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:24:16  */
  always @*
    next_clk_cnt = n114; // (isignal)
  initial
    next_clk_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:44  */
  assign n103 = {3'b0, on_counter_val_i};  //  uext
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:44  */
  assign n104 = $unsigned(clk_cnt) < $unsigned(n103);
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:33  */
  assign n107 = n104 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:66  */
  assign n109 = period_counter_val_i - 20'b00000000000000000001;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:44  */
  assign n110 = $unsigned(clk_cnt) < $unsigned(n109);
  /* ../../vhdl/rtl/servo_control_ea.vhd:48:65  */
  assign n112 = clk_cnt + 20'b00000000000000000001;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:33  */
  assign n114 = n110 ? n112 : 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:31:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n116 <= 20'b00000000000000000000;
    else
      n116 <= next_clk_cnt;
endmodule

module tilt
  (input  clk_i,
   input  reset_i,
   input  [7:0] hold_value_i,
   output [16:0] on_counter_val_o);
  reg [16:0] on_value;
  reg [16:0] next_on_value;
  wire n70;
  wire n72;
  wire n74;
  wire [11:0] n75;
  wire [11:0] n77;
  wire [23:0] n78;
  wire [23:0] n81;
  wire [16:0] n82;
  wire [16:0] n84;
  wire [16:0] n86;
  wire [16:0] n88;
  wire [16:0] n90;
  reg [16:0] n92;
  assign on_counter_val_o = on_value; //(module output)
  /* ../../vhdl/rtl/Tilt_ea.vhd:23:16  */
  always @*
    on_value = n92; // (isignal)
  initial
    on_value = 17'b00000000000000000;
  /* ../../vhdl/rtl/Tilt_ea.vhd:24:16  */
  always @*
    next_on_value = n90; // (isignal)
  initial
    next_on_value = 17'b00000000000000000;
  /* ../../vhdl/rtl/Tilt_ea.vhd:40:29  */
  assign n70 = $unsigned(hold_value_i) < $unsigned(8'b01011011);
  /* ../../vhdl/rtl/Tilt_ea.vhd:43:32  */
  assign n72 = $unsigned(hold_value_i) >= $unsigned(8'b10001001);
  /* ../../vhdl/rtl/Tilt_ea.vhd:46:44  */
  assign n74 = hold_value_i == 8'b01110010;
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:80  */
  assign n75 = {4'b0, hold_value_i};  //  uext
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:104  */
  assign n77 = n75 - 12'b000001011011;
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:136  */
  assign n78 = {12'b0, n77};  //  uext
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:136  */
  assign n81 = n78 * 24'b000000000000010000111111; // umul
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:72  */
  assign n82 = n81[16:0];  // trunc
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:70  */
  assign n84 = 17'b01100001101010000 + n82;
  /* ../../vhdl/rtl/Tilt_ea.vhd:46:25  */
  assign n86 = n74 ? 17'b10010010011111000 : n84;
  /* ../../vhdl/rtl/Tilt_ea.vhd:43:13  */
  assign n88 = n72 ? 17'b11000011010100000 : n86;
  /* ../../vhdl/rtl/Tilt_ea.vhd:40:13  */
  assign n90 = n70 ? 17'b01100001101010000 : n88;
  /* ../../vhdl/rtl/Tilt_ea.vhd:30:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n92 <= 17'b00000000000000000;
    else
      n92 <= next_on_value;
endmodule

module holdvalueonstrb
  (input  clk_i,
   input  reset_i,
   input  adc_valid_strb_i,
   input  [7:0] adc_value_i,
   output [7:0] holdvalue_o);
  reg [7:0] holdvalue;
  reg [7:0] next_holdvalue;
  wire [7:0] n56;
  reg [7:0] n58;
  assign holdvalue_o = holdvalue; //(module output)
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:24:16  */
  always @*
    holdvalue = n58; // (isignal)
  initial
    holdvalue = 8'b00000000;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:25:16  */
  always @*
    next_holdvalue = n56; // (isignal)
  initial
    next_holdvalue = 8'b00000000;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:42:17  */
  assign n56 = adc_valid_strb_i ? adc_value_i : holdvalue;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:33:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n58 <= 8'b00000000;
    else
      n58 <= next_holdvalue;
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

module rc_servo_core_xy
  (input  clk_i,
   input  reset_i,
   input  comp_async_x_i,
   input  comp_async_y_i,
   output pwm_x_o,
   output pwm_y_o,
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
  wire n4;
  wire \delta_adc_port.pwm_x_o ;
  wire \delta_adc_port.pwm_y_o ;
  wire \servo_control_x_port.pwm_pin_o ;
  localparam [19:0] n15 = 20'b11110100001001000000;
  wire \servo_control_y_port.pwm_pin_o ;
  localparam [19:0] n17 = 20'b11110100001001000000;
  assign pwm_x_o = \delta_adc_port.pwm_x_o ; //(module output)
  assign pwm_y_o = \delta_adc_port.pwm_y_o ; //(module output)
  assign pwm_pin_x_o = \servo_control_x_port.pwm_pin_o ; //(module output)
  assign pwm_pin_y_o = \servo_control_y_port.pwm_pin_o ; //(module output)
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:42:16  */
  assign reset_n = n4; // (signal)
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:46:28  */
  assign n4 = ~reset_i;
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:48:17  */
  delta_adc_xy delta_adc_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .comp_async_x_i(comp_async_x_i),
    .comp_async_y_i(comp_async_y_i),
    .pwm_x_o(\delta_adc_port.pwm_x_o ),
    .pwm_y_o(\delta_adc_port.pwm_y_o ),
    .adc_valid_strb_x_o(adc_valid_strb_x),
    .adc_valid_strb_y_o(adc_valid_strb_y),
    .adc_value_x_o(adc_value_x),
    .adc_value_y_o(adc_value_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:62:17  */
  holdvalueonstrb holdvalue_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .adc_valid_strb_i(adc_valid_strb_x),
    .adc_value_i(adc_value_x),
    .holdvalue_o(holdvalue_x));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:71:17  */
  holdvalueonstrb holdvalue_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .adc_valid_strb_i(adc_valid_strb_y),
    .adc_value_i(adc_value_y),
    .holdvalue_o(holdvalue_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:80:17  */
  tilt tilt_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .hold_value_i(holdvalue_x),
    .on_counter_val_o(on_counter_val_x));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:88:17  */
  tilt tilt_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .hold_value_i(holdvalue_y),
    .on_counter_val_o(on_counter_val_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:96:17  */
  servo_control servo_control_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .period_counter_val_i(n15),
    .on_counter_val_i(on_counter_val_x),
    .pwm_pin_o(\servo_control_x_port.pwm_pin_o ));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:105:17  */
  servo_control servo_control_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .period_counter_val_i(n17),
    .on_counter_val_i(on_counter_val_y),
    .pwm_pin_o(\servo_control_y_port.pwm_pin_o ));
endmodule

