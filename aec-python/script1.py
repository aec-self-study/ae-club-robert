x = 2

print (x)

my_fruit_list = ['apple', 'banana','orange']

my_int_list = [1,2,3]
my_first_list = ['apple',1,'banana',2,3]

####################

for r in my_first_list:
    if isinstance(r, int):
       sq_int(r)
    else:
       if r in cal_lookup:
           print (cal_lookup[r])

####################

for keys, values in cal_lookup.items():
    print(keys,":", values**2)

####################
i = 0
while i < 10:   
    print (i)
    i=i+1
####################


cal_lookup = {'apple':95, 'banana':105, 'orange':45}

for values in cal_lookup.values():
    print(values)

for f in my_fruit_list:
    print(f)

def sq_int(x):
    y = x**2
    return(y)

####################

y = 5
x = 4

def is_even(x):
    if (x % 2) == 0:
        return True
    else:
        return False

def is_odd(x):
    if (x % 2) != 0:
        return True
    else:
        return False


def describe_evenness(x):
    if is_even(x):
        print("It's even")
    elif is_odd(x):
        print("It's odd")
    else:
        print("It's neither even nor odd")

######################
import random
denoms = list(range(10))
random.shuffle(denoms)

for i in range (10):
    x=denoms[i]
    try:
        result = 100/x
    except:
        breakpoint()
    print(result)

    ######################