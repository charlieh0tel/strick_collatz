import random

def Collatz(a):
    seen = set([a])
    while True:
        if a % 2 == 0:
            a = a // 2
            p = 'even'
        else:
            a = 3 * a + 1
            p = 'odd'

        if a == 1:
            print('finished in %d moves' % len(seen))
            return len(seen)

        if a in seen:
            raise Exception( 'COUNTEREXAMPLE: %d' % a )

        seen.add(a)
        print('[%5d] : %d  %s' % (len(seen), a, 'odd' if a%2==0 else ''))


def Trial(seed):
    random.seed(seed)
    a = random.randrange(int(10**1000))
    print('============= [%10d]  a:  %d' % (seed, a))
    Collatz(a)
    print('=============')

for seed in range(1000000):
    Trial(seed)
