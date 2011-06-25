
[X1,Y1]= utility('approval')
[X2,Y2]= utility('cumulative')
[X3,Y3]= utility('liquidizer')

subplot(3,1,1)
plot(X1,Y1,'.')

subplot(3,1,2)
plot(X2,Y2,'.')

subplot(3,1,3)
plot(X3,Y3,'.')