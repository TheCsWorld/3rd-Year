Fit =  0
Unfit = 1
Dead = 2
Exercise = 1
Relax = 0
exerciseList = [[[.891, .009, .1],[8, 8, 0]], [[.18, .72, .1],[0, 0, 0]], [[0,0,1],[0,0,0]]]
relaxList =    [[[.693, .297, .01],[10, 10, 0]],[[0, .99, .01],[5, 5, 0]],  [[0,0,1],[0, 0, 0]]]

def show(n,s,gamma):
    if n < 0:
        return "n must be a positive int!"
    if  s != Fit and s != Unfit and s != Dead:
        return "State must be Fit, Unfit, or Dead!"
    if gamma >= 1 or gamma <= 0:
        return "0 < g < 1!"
    global g
    g = gamma
    for i in range(0, n+1):
        print('n=%d exer: %f relax: %f' % (i, q(s, Exercise, i), q(s, Relax, i)))

#q0(s, a) := p(s, a, fit)r(s, a, fit) + p(s, a, unfit)r(s, a, unfit)
def q(s, a, n):
    q0 = (p(s, a, Fit) * r(s, a, Fit)) + (p(s, a, Unfit) * r(s, a, Unfit))
    if n == 0:
        return q0
    # qn+1(s, a) := q0(s, a) + γ p(s, a, fit)Vn(fit) + p(s, a, unfit)Vn(unfit)
    else:
        return q0 + (g * ((p(s, a, Fit) * v(Fit, n-1)) + (p(s, a, Unfit) * v(Unfit, n-1))))

#Vn(s) := max(qn(s, exercise), qn(s,relax))
def v(s,n):
    return max(q(s, Exercise, n), q(s,Relax,n))

# Get probability from probability matrix
def p(s,a,result):
    if a == Exercise:
        return exerciseList[s][0][result]
    else:
         return relaxList[s][0][result]

# Get result from result matrix
def r(s,a,result):
    if a == Exercise:
        return exerciseList[s][1][result]
    else:
         return relaxList[s][1][result]

show(10,Fit,0.5)
print()
show(8,Unfit,0.8)
print()
show(10,Dead,0.99)
