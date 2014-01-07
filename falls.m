fall = @(p,x)p(1)*.5*9.8*x.^2 + p(2);
options = optimset('Display','off','TolX',1e-128,'TolFun',1e-128);

a0 = 1/1.6094e-5;
initials = [a0,285];

fp = nlinfit(TOF, yfcenters, fall, initials,options);

ypts = .002:10^(-5):25e-3;
yfalls = fall(fp,ypts);

plot(TOF,yfcenters,'x',ypts,yfalls);