use IEEE.math_real."ceil";
use IEEE.math_real."log2";

-- produce required vector length for integer
function int_vec_length(x: positive) return natural is
begin
  return natural(ceil(log2(real(x))));
end function;
