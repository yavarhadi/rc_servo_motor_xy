module filter_shift_register
  (input  clk_i,
   input  reset_i,
   input  strb_data_valid_i,
   input  [7:0] data_i,
   output [7:0] data_o);
  wire [7:0] data;
  wire [7:0] next_data;
  wire [7:0] n258;
  reg [7:0] n260;
  assign data_o = data; //(module output)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:23:16  */
  assign data = n260; // (signal)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:23:22  */
  assign next_data = n258; // (signal)
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:40:33  */
  assign n258 = strb_data_valid_i ? data_i : data;
  /* ../../vhdl/rtl/filter_shift_register_ea.vhd:31:33  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n260 <= 8'b00000000;
    else
      n260 <= next_data;
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
  wire n237;
  wire n240;
  wire [7:0] n242;
  wire n243;
  wire [7:0] n245;
  wire [7:0] n247;
  reg [7:0] n249;
  assign pwm_pin_o = pwm_output; //(module output)
  /* ../../vhdl/rtl/pwm_ea.vhd:23:16  */
  always @*
    clk_cnt = n249; // (isignal)
  initial
    clk_cnt = 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:23:25  */
  always @*
    next_clk_cnt = n247; // (isignal)
  initial
    next_clk_cnt = 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:24:16  */
  always @*
    pwm_output = n240; // (isignal)
  initial
    pwm_output = 1'b0;
  /* ../../vhdl/rtl/pwm_ea.vhd:44:44  */
  assign n237 = $unsigned(clk_cnt) < $unsigned(on_counter_val_i);
  /* ../../vhdl/rtl/pwm_ea.vhd:44:33  */
  assign n240 = n237 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/pwm_ea.vhd:50:66  */
  assign n242 = period_counter_val_i - 8'b00000001;
  /* ../../vhdl/rtl/pwm_ea.vhd:50:44  */
  assign n243 = $unsigned(clk_cnt) < $unsigned(n242);
  /* ../../vhdl/rtl/pwm_ea.vhd:51:65  */
  assign n245 = clk_cnt + 8'b00000001;
  /* ../../vhdl/rtl/pwm_ea.vhd:50:33  */
  assign n247 = n243 ? n245 : 8'b00000000;
  /* ../../vhdl/rtl/pwm_ea.vhd:35:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n249 <= 8'b00000000;
    else
      n249 <= next_clk_cnt;
endmodule

module dff
  (input  clk_i,
   input  reset_i,
   input  d_i,
   output q_o);
  reg n225;
  assign q_o = n225; //(module output)
  /* ../../vhdl/rtl/d_ff_ea.vhd:25:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n225 <= 1'b0;
    else
      n225 <= d_i;
endmodule

module adc_value
  (input  clk_i,
   input  reset_i,
   input  comparator_i,
   input  strb_i,
   output [7:0] adc_value_o);
  reg [7:0] adc_value_state;
  reg [7:0] next_adc_value;
  wire n205;
  wire [7:0] n207;
  wire [7:0] n208;
  wire n210;
  wire [7:0] n212;
  wire [7:0] n213;
  wire [7:0] n214;
  wire [7:0] n215;
  reg [7:0] n217;
  assign adc_value_o = adc_value_state; //(module output)
  /* ../../vhdl/rtl/adc_value_ea.vhd:23:16  */
  always @*
    adc_value_state = n217; // (isignal)
  initial
    adc_value_state = 8'b11111111;
  /* ../../vhdl/rtl/adc_value_ea.vhd:24:16  */
  always @*
    next_adc_value = n215; // (isignal)
  initial
    next_adc_value = 8'b11111111;
  /* ../../vhdl/rtl/adc_value_ea.vhd:44:52  */
  assign n205 = adc_value_state == 8'b11111010;
  /* ../../vhdl/rtl/adc_value_ea.vhd:47:74  */
  assign n207 = adc_value_state + 8'b00000001;
  /* ../../vhdl/rtl/adc_value_ea.vhd:44:33  */
  assign n208 = n205 ? adc_value_state : n207;
  /* ../../vhdl/rtl/adc_value_ea.vhd:50:52  */
  assign n210 = adc_value_state == 8'b00000000;
  /* ../../vhdl/rtl/adc_value_ea.vhd:53:74  */
  assign n212 = adc_value_state - 8'b00000001;
  /* ../../vhdl/rtl/adc_value_ea.vhd:50:33  */
  assign n213 = n210 ? adc_value_state : n212;
  /* ../../vhdl/rtl/adc_value_ea.vhd:43:25  */
  assign n214 = comparator_i ? n208 : n213;
  /* ../../vhdl/rtl/adc_value_ea.vhd:42:17  */
  assign n215 = strb_i ? n214 : adc_value_state;
  /* ../../vhdl/rtl/adc_value_ea.vhd:32:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n217 <= 8'b00000000;
    else
      n217 <= next_adc_value;
endmodule

module moving_average
  (input  clk_i,
   input  reset_i,
   input  strb_data_valid_i,
   input  [7:0] data_i,
   output strb_data_valid_o,
   output [7:0] data_o);
  reg [31:0] moving_average_value;
  reg [7:0] data_o_reg;
  reg strb_data_valid_o_reg;
  wire [7:0] \gen_reg_0_register_i0.data_o ;
  wire [7:0] \gen_reg_rest_gen_regs_n1_register_i.data_o ;
  wire [7:0] n153;
  wire [7:0] \gen_reg_rest_gen_regs_n2_register_i.data_o ;
  wire [7:0] n155;
  wire [7:0] \gen_reg_rest_gen_regs_n3_register_i.data_o ;
  wire [7:0] n157;
  wire [7:0] n163;
  wire [9:0] n164;
  wire [9:0] n166;
  wire [7:0] n168;
  wire [9:0] n169;
  wire [9:0] n170;
  wire [7:0] n171;
  wire [9:0] n172;
  wire [9:0] n173;
  wire [7:0] n174;
  wire [9:0] n175;
  wire [9:0] n176;
  wire [9:0] n178;
  wire [7:0] n179;
  wire [7:0] n180;
  wire [7:0] n183;
  wire n185;
  wire [31:0] n191;
  reg [7:0] n192;
  reg n193;
  assign strb_data_valid_o = strb_data_valid_o_reg; //(module output)
  assign data_o = data_o_reg; //(module output)
  /* ../../vhdl/rtl/moving_average_ea.vhd:45:12  */
  always @*
    moving_average_value = n191; // (isignal)
  initial
    moving_average_value = 32'b00000000000000000000000000000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:48:12  */
  always @*
    data_o_reg = n192; // (isignal)
  initial
    data_o_reg = 8'b00000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:49:12  */
  always @*
    strb_data_valid_o_reg = n193; // (isignal)
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
    .data_i(n153),
    .data_o(\gen_reg_rest_gen_regs_n1_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n153 = moving_average_value[31:24]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n2_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n155),
    .data_o(\gen_reg_rest_gen_regs_n2_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n155 = moving_average_value[23:16]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:71:25  */
  filter_shift_register gen_reg_rest_gen_regs_n3_register_i (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(strb_data_valid_i),
    .data_i(n157),
    .data_o(\gen_reg_rest_gen_regs_n3_register_i.data_o ));
  /* ../../vhdl/rtl/moving_average_ea.vhd:76:71  */
  assign n157 = moving_average_value[15:8]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n163 = moving_average_value[31:24]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n164 = {2'b0, n163};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n166 = 10'b0000000000 + n164;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n168 = moving_average_value[23:16]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n169 = {2'b0, n168};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n170 = n166 + n169;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n171 = moving_average_value[15:8]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n172 = {2'b0, n171};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n173 = n170 + n172;
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:73  */
  assign n174 = moving_average_value[7:0]; // extract
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:46  */
  assign n175 = {2'b0, n174};  //  uext
  /* ../../vhdl/rtl/moving_average_ea.vhd:100:44  */
  assign n176 = n173 + n175;
  /* ../../vhdl/rtl/moving_average_ea.vhd:105:62  */
  assign n178 = n176 >> 31'b0000000000000000000000000000010;
  /* ../../vhdl/rtl/moving_average_ea.vhd:105:55  */
  assign n179 = n178[7:0];  // trunc
  /* ../../vhdl/rtl/moving_average_ea.vhd:95:17  */
  assign n180 = strb_data_valid_i ? n179 : data_o_reg;
  /* ../../vhdl/rtl/moving_average_ea.vhd:88:13  */
  assign n183 = reset_i ? 8'b00000000 : n180;
  /* ../../vhdl/rtl/moving_average_ea.vhd:88:13  */
  assign n185 = reset_i ? 1'b0 : strb_data_valid_i;
  assign n191 = {\gen_reg_0_register_i0.data_o , \gen_reg_rest_gen_regs_n1_register_i.data_o , \gen_reg_rest_gen_regs_n2_register_i.data_o , \gen_reg_rest_gen_regs_n3_register_i.data_o };
  /* ../../vhdl/rtl/moving_average_ea.vhd:87:9  */
  always @(posedge clk_i)
    n192 <= n183;
  initial
    n192 = 8'b00000000;
  /* ../../vhdl/rtl/moving_average_ea.vhd:87:9  */
  always @(posedge clk_i)
    n193 <= n185;
  initial
    n193 = 1'b0;
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
  localparam [7:0] n145 = 8'b11111010;
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
    .period_counter_val_i(n145),
    .on_counter_val_i(adc_value_signal),
    .pwm_pin_o(\pwm_port.pwm_pin_o ));
endmodule

module synchronizer_1
  (input  clk_i,
   input  reset_i,
   input  async_i,
   output sync_o);
  reg sync_reg;
  reg n139;
  assign sync_o = sync_reg; //(module output)
  /* ../../vhdl/rtl/synchonizer_ea.vhd:22:16  */
  always @*
    sync_reg = n139; // (isignal)
  initial
    sync_reg = 1'b0;
  /* ../../vhdl/rtl/synchonizer_ea.vhd:28:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n139 <= 1'b0;
    else
      n139 <= async_i;
endmodule

module strb_generator
  (input  clk_i,
   input  reset_i,
   output strb_o);
  reg [19:0] strb_cnt;
  reg [19:0] next_strb_cnt;
  wire strb_cnt_out;
  wire n120;
  wire [19:0] n122;
  wire [19:0] n124;
  wire n127;
  reg [19:0] n129;
  assign strb_o = strb_cnt_out; //(module output)
  /* ../../vhdl/rtl/strb_ea.vhd:22:16  */
  always @*
    strb_cnt = n129; // (isignal)
  initial
    strb_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:23:16  */
  always @*
    next_strb_cnt = n124; // (isignal)
  initial
    next_strb_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:24:16  */
  assign strb_cnt_out = n127; // (signal)
  /* ../../vhdl/rtl/strb_ea.vhd:41:37  */
  assign n120 = $unsigned(strb_cnt) < $unsigned(20'b11110100001000111111);
  /* ../../vhdl/rtl/strb_ea.vhd:43:59  */
  assign n122 = strb_cnt + 20'b00000000000000000001;
  /* ../../vhdl/rtl/strb_ea.vhd:41:25  */
  assign n124 = n120 ? n122 : 20'b00000000000000000000;
  /* ../../vhdl/rtl/strb_ea.vhd:41:25  */
  assign n127 = n120 ? 1'b0 : 1'b1;
  /* ../../vhdl/rtl/strb_ea.vhd:32:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n129 <= 20'b00000000000000000000;
    else
      n129 <= next_strb_cnt;
endmodule

module servo_control
  (input  clk_i,
   input  reset_i,
   input  [19:0] period_counter_val_i,
   input  [16:0] on_counter_val_i,
   output pwm_pin_o);
  reg [19:0] clk_cnt;
  reg [19:0] next_clk_cnt;
  wire [19:0] n95;
  wire n96;
  wire n99;
  wire [19:0] n101;
  wire n102;
  wire [19:0] n104;
  wire [19:0] n106;
  reg [19:0] n108;
  assign pwm_pin_o = n99; //(module output)
  /* ../../vhdl/rtl/servo_control_ea.vhd:23:16  */
  always @*
    clk_cnt = n108; // (isignal)
  initial
    clk_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:24:16  */
  always @*
    next_clk_cnt = n106; // (isignal)
  initial
    next_clk_cnt = 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:44  */
  assign n95 = {3'b0, on_counter_val_i};  //  uext
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:44  */
  assign n96 = $unsigned(clk_cnt) < $unsigned(n95);
  /* ../../vhdl/rtl/servo_control_ea.vhd:41:33  */
  assign n99 = n96 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:66  */
  assign n101 = period_counter_val_i - 20'b00000000000000000001;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:44  */
  assign n102 = $unsigned(clk_cnt) < $unsigned(n101);
  /* ../../vhdl/rtl/servo_control_ea.vhd:48:65  */
  assign n104 = clk_cnt + 20'b00000000000000000001;
  /* ../../vhdl/rtl/servo_control_ea.vhd:47:33  */
  assign n106 = n102 ? n104 : 20'b00000000000000000000;
  /* ../../vhdl/rtl/servo_control_ea.vhd:31:17  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n108 <= 20'b00000000000000000000;
    else
      n108 <= next_clk_cnt;
endmodule

module tilt
  (input  clk_i,
   input  reset_i,
   input  [7:0] hold_value_i,
   output [16:0] on_counter_val_o);
  reg [16:0] on_value;
  reg [16:0] next_on_value;
  wire n62;
  wire n64;
  wire n66;
  wire [11:0] n67;
  wire [11:0] n69;
  wire [23:0] n70;
  wire [23:0] n73;
  wire [16:0] n74;
  wire [16:0] n76;
  wire [16:0] n78;
  wire [16:0] n80;
  wire [16:0] n82;
  reg [16:0] n84;
  assign on_counter_val_o = on_value; //(module output)
  /* ../../vhdl/rtl/Tilt_ea.vhd:23:16  */
  always @*
    on_value = n84; // (isignal)
  initial
    on_value = 17'b00000000000000000;
  /* ../../vhdl/rtl/Tilt_ea.vhd:24:16  */
  always @*
    next_on_value = n82; // (isignal)
  initial
    next_on_value = 17'b00000000000000000;
  /* ../../vhdl/rtl/Tilt_ea.vhd:40:29  */
  assign n62 = $unsigned(hold_value_i) < $unsigned(8'b01100110);
  /* ../../vhdl/rtl/Tilt_ea.vhd:43:32  */
  assign n64 = $unsigned(hold_value_i) >= $unsigned(8'b10010100);
  /* ../../vhdl/rtl/Tilt_ea.vhd:46:44  */
  assign n66 = hold_value_i == 8'b01111101;
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:80  */
  assign n67 = {4'b0, hold_value_i};  //  uext
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:104  */
  assign n69 = n67 - 12'b000001100110;
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:136  */
  assign n70 = {12'b0, n69};  //  uext
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:136  */
  assign n73 = n70 * 24'b000000000000010000111111; // umul
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:72  */
  assign n74 = n73[16:0];  // trunc
  /* ../../vhdl/rtl/Tilt_ea.vhd:50:70  */
  assign n76 = 17'b01100001101010000 + n74;
  /* ../../vhdl/rtl/Tilt_ea.vhd:46:25  */
  assign n78 = n66 ? 17'b10010010011111000 : n76;
  /* ../../vhdl/rtl/Tilt_ea.vhd:43:13  */
  assign n80 = n64 ? 17'b11000011010100000 : n78;
  /* ../../vhdl/rtl/Tilt_ea.vhd:40:13  */
  assign n82 = n62 ? 17'b01100001101010000 : n80;
  /* ../../vhdl/rtl/Tilt_ea.vhd:30:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n84 <= 17'b00000000000000000;
    else
      n84 <= next_on_value;
endmodule

module holdvalueonstrb
  (input  clk_i,
   input  reset_i,
   input  adc_valid_strb_i,
   input  [7:0] adc_value_i,
   output [7:0] holdvalue_o);
  reg [7:0] holdvalue;
  reg [7:0] next_holdvalue;
  wire [7:0] n48;
  reg [7:0] n50;
  assign holdvalue_o = holdvalue; //(module output)
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:24:16  */
  always @*
    holdvalue = n50; // (isignal)
  initial
    holdvalue = 8'b00000000;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:25:16  */
  always @*
    next_holdvalue = n48; // (isignal)
  initial
    next_holdvalue = 8'b00000000;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:42:17  */
  assign n48 = adc_valid_strb_i ? adc_value_i : holdvalue;
  /* ../../vhdl/rtl/HoldValueOnStrb_ea.vhd:33:25  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n50 <= 8'b00000000;
    else
      n50 <= next_holdvalue;
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
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:39:17  */
  strb_generator strb_generator_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_o(strb_signal));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:46:9  */
  synchronizer_1 synchronizer_port_x (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .async_i(comp_async_x_i),
    .sync_o(comp_synch_x));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:55:17  */
  synchronizer_1 synchronizer_port_y (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .async_i(comp_async_y_i),
    .sync_o(comp_synch_y));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:64:9  */
  deltaadc delta_adc_port_x (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .comparator_i(comp_synch_x),
    .strb_signal_i(strb_signal),
    .adc_valid_strb_o(adc_valid_strb_x),
    .pwm_o(\delta_adc_port_x.pwm_o ),
    .adc_value_o(adc_value_x));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:75:9  */
  deltaadc delta_adc_port_y (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .comparator_i(comp_synch_y),
    .strb_signal_i(strb_signal),
    .adc_valid_strb_o(adc_valid_strb_y),
    .pwm_o(\delta_adc_port_y.pwm_o ),
    .adc_value_o(adc_value_y));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:86:17  */
  moving_average moving_average_x_port (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .strb_data_valid_i(adc_valid_strb_x),
    .data_i(adc_value_x),
    .strb_data_valid_o(\moving_average_x_port.strb_data_valid_o ),
    .data_o(\moving_average_x_port.data_o ));
  /* ../../vhdl/rtl/Delta_ADC_XY_ea.vhd:97:17  */
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
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:40:16  */
  assign reset_n = n4; // (signal)
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:43:28  */
  assign n4 = ~reset_i;
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:45:17  */
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
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:59:17  */
  holdvalueonstrb holdvalue_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .adc_valid_strb_i(adc_valid_strb_x),
    .adc_value_i(adc_value_x),
    .holdvalue_o(holdvalue_x));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:68:17  */
  holdvalueonstrb holdvalue_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .adc_valid_strb_i(adc_valid_strb_y),
    .adc_value_i(adc_value_y),
    .holdvalue_o(holdvalue_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:77:17  */
  tilt tilt_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .hold_value_i(holdvalue_x),
    .on_counter_val_o(on_counter_val_x));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:85:17  */
  tilt tilt_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .hold_value_i(holdvalue_y),
    .on_counter_val_o(on_counter_val_y));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:93:17  */
  servo_control servo_control_x_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .period_counter_val_i(n15),
    .on_counter_val_i(on_counter_val_x),
    .pwm_pin_o(\servo_control_x_port.pwm_pin_o ));
  /* ../../vhdl/rtl/rc_servo_xy_ea.vhd:102:17  */
  servo_control servo_control_y_port (
    .clk_i(clk_i),
    .reset_i(reset_n),
    .period_counter_val_i(n17),
    .on_counter_val_i(on_counter_val_y),
    .pwm_pin_o(\servo_control_y_port.pwm_pin_o ));
endmodule
