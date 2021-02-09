function Tfit=T_dis(Tmin,Tmax,T)
if T>Tmax
    Tfit=0;
elseif T<Tmin
    Tfit=0;
else
    Tfit=(0.006/1.1394*(T-Tmin)^2*(1-exp(0.04*(T-Tmax))));
end
end