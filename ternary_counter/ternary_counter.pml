/*
 * Ternary Counter Promera Program: counter.pml
 *
 * Run simulation by random mode
 * $ spin -v ternary_counter.pml
 *
 * Generate the LTL program
 * $ spin -f "<>(A&B&C)" > ternary_counter_1.ltl
 *
 * Insert following codes in head of ternary_counter_1.ltl
 * $ vi ternary_counter_1.ltl
 * #define A (digit0==1)
 * #define B (digit1==1)
 * #define C (digit2==1)
 *
 * Generate the verification program (written C)
 * $ spin -a -N ternary_counter_1.ltl ternary_counter.pml
 *
 * Compile the program
 * gcc pan.c
 *
 * Run
 * $ ./a.out
  (Spin Version 6.4.2 -- 8 October 2014)
  	+ Partial Order Reduction

  Full statespace search for:
  	never claim         	+ (never_0)
  	assertion violations	+ (if within scope of claim)
  	acceptance   cycles 	- (not selected)
  	invalid end states	- (disabled by never claim)

  State-vector 36 byte, depth reached 61, errors: 1
         27 states, stored
          0 states, matched
         27 transitions (= stored+matched)
          9 atomic steps
  hash conflicts:         0 (resolved)
 */

int digit0 = 0;
int digit1 = 0;
int digit2 = 0;

active proctype counter()
{
  do
  ::(digit0 == 2) -> atomic {
    digit0 = 0;
    if
    ::(digit1 == 2) ->
      digit1 = 0;
      if
      ::(digit2 == 2) ->
        digit2 = 0;
      ::else ->
        digit2++
      fi
    ::else ->
      digit1++
    fi
  }
  ::else ->
    digit0++
  od
}
