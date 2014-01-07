u = linspace(173,100);
v = 0;
f =50;

v = 1./(1./f - 1./u);
plot(u,v)
xlabel('u')
ylabel('v')