library ieee;
  use ieee.std_logic_1164.all;

library work;
  use work.PWM_Types.all;
  use work.CommonTypes.all;

entity StateMachine is

  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    hold  : in  std_logic;
    tick  : in  std_logic;

    state : out state_t

  );

end entity;

architecture rtl of StateMachine is
  signal current_state, next_state : state_t := S0;

  signal direction : std_logic := '1';

begin

  -- state machine
  state_machine: process (clk, reset)
  begin
    if reset = BUTTON_ACTIVE then
      current_state <= S0;

    elsif rising_edge(clk) then
      if tick = '1' and hold = '1' then
        current_state <= next_state;
      end if;

      if current_state = S0 then
        direction <= '1';
      end if;

      if current_state = S9 then
        direction <= '0';
      end if;

    end if;

  end process;

  determine_next: process (direction, current_state)
  begin
    -- forward direction
    if direction = '1' then
      case current_state is
        when S0 => next_state <= S1;
        when S1 => next_state <= S2;
        when S2 => next_state <= S3;
        when S3 => next_state <= S4;
        when S4 => next_state <= S5;
        when S5 => next_state <= S6;
        when S6 => next_state <= S7;
        when S7 => next_state <= S8;
        when S8 => next_state <= S9;
        when S9 => next_state <= S8;
        when others => next_state <= S_Err;

      end case;

      -- reverse direction
    else
      case current_state is
        when S9 => next_state <= S8;
        when S8 => next_state <= S7;
        when S7 => next_state <= S6;
        when S6 => next_state <= S5;
        when S5 => next_state <= S4;
        when S4 => next_state <= S3;
        when S3 => next_state <= S2;
        when S2 => next_state <= S1;
        when S1 => next_state <= S0;
        when S0 => next_state <= S1;
        when others => next_state <= S_Err;

      end case;

    end if;

  end process;

  state <= current_state;

end architecture;




