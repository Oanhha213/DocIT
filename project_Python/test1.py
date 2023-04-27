from math import sqrt
a,b,c = map(int(input().split()))
d = b*b-4*a*c
if a==b==c : print("vo so nghiem")
elif a==b==0 or d<0 : print("vo nghiem")
elif a==0 : print(-c/b)
elif d==0 : print(-b/2/a)
else:
    x1 = (-b-sqrt(d))/2/a
    x2 = -b/2-x1
    print(x1,x2, sep="\n")