# calc.py

import argparse

parser = argparse.ArgumentParser(description= "CLI Calculator")

subparsers = parser.add_subparsers(help = "sub-command help", dest="command")

add = subparsers.add_parser("add", help = "add integers")
add.add_argument("ints_to_sum", nargs='*' , type=int)

sub = subparsers.add_parser("sub", help = "subtract integers")
sub.add_argument("ints_to_sub", nargs=2 , type=int)

div = subparsers.add_parser("div", help = "divide integers")
div.add_argument("ints_to_div", nargs=2 , type=int)

mult = subparsers.add_parser("mult", help = "multiply integers")
mult.add_argument("ints_to_mult", nargs=2 , type=int)

args = parser.parse_args()

if args.command =="add":
    our_sum = sum(args.ints_to_sum)
    print(f"the sum of values is:  {our_sum}")

if args.command =="sub":
    our_sub = args.ints_to_sub[0] - args.ints_to_sub[1]
    print(f"the subtraction of values is:  {our_sub}")

if args.command =="div":
    try:
        our_div = args.ints_to_div[0] / args.ints_to_div[1]
        print(f"the result of dividing values is:  {our_div}")
    except ZeroDivisionError:
       print("cannot divide")
    
if args.command =="mult":
    our_mult = args.ints_to_mult[0] * args.ints_to_mult[1]
    print(f"the result of multiplying values is:  {our_mult}")
