function Mfit=M_dis(Mhalf,M)
Mfit=1/(1+exp(20*(-M+Mhalf)));
end