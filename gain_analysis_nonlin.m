% how we choose b and xi = dumping factor
%take whole trajectory as input 
%compute the mean velocities v_avg, w_avg, and w_max_abs

v_avg = mean(data{1}{2}.Values.Data) ; 
w_avg = mean(data{1}{3}.Values.Data);
w_max = max(data{1}{3}.Values.Data);
w_min = min(data{1}{3}.Values.Data);
w_avg_2 = (w_max + abs(w_min)) * 0.5;
 
%increase b --> speed dominant behaviour 
%decrease b --> turn dominant behaviour 

b = w_avg/v_avg;

%to balance k3/k2 ratio

xi = b / (2 * sqrt(b * v_avg + w_avg^2));  


%------------%
b = w_avg_2/v_avg;

%to balance k3/k2 ratio

xi = b / (2 * sqrt(b * v_avg + w_avg_2^2));  

%the result from this analysis (data from trajectory2)
%b = 0.1132
%xi = 0.0024


