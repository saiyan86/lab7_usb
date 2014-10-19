library verilog;
use verilog.vl_types.all;
entity ball is
    generic(
        Ball_X_Center   : vl_logic_vector(9 downto 0) := (Hi0, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        Ball_Y_Center   : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0);
        Ball_X_Min      : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        Ball_X_Max      : vl_logic_vector(9 downto 0) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1);
        Ball_Y_Min      : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        Ball_Y_Max      : vl_logic_vector(9 downto 0) := (Hi0, Hi1, Hi1, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1);
        Ball_X_Step     : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        Ball_Y_Step     : vl_logic_vector(9 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1)
    );
    port(
        Reset           : in     vl_logic;
        frame_clk       : in     vl_logic;
        BallX           : out    vl_logic_vector(9 downto 0);
        BallY           : out    vl_logic_vector(9 downto 0);
        BallS           : out    vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Ball_X_Center : constant is 2;
    attribute mti_svvh_generic_type of Ball_Y_Center : constant is 2;
    attribute mti_svvh_generic_type of Ball_X_Min : constant is 2;
    attribute mti_svvh_generic_type of Ball_X_Max : constant is 2;
    attribute mti_svvh_generic_type of Ball_Y_Min : constant is 2;
    attribute mti_svvh_generic_type of Ball_Y_Max : constant is 2;
    attribute mti_svvh_generic_type of Ball_X_Step : constant is 2;
    attribute mti_svvh_generic_type of Ball_Y_Step : constant is 2;
end ball;
