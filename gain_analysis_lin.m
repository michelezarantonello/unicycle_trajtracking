% how we choose a (=natural frequency) and xi = dumping factor
%take whole trajectory as input 
%compute the mean velocities v_avg, w_avg, and w_max_abs

v_avg = mean(data{1}{2}.Values.Data) ; 
w_avg = mean(data{1}{3}.Values.Data);
w_max = max(data{1}{3}.Values.Data);
w_min = min(data{1}{3}.Values.Data);
w_max_abs = max(w_max , abs(w_min));

%to have k2 positive 
alpha=2; % should be alpha between 1.5, 2.5 
a= alpha * w_max_abs; 


%to balance k1/(k2*k3) ratio

xi = 1 / (2* sqrt(v_avg)); %under w close to 0 assumption 

xi = sqrt((a^2 - w_avg)/a^2) * (1 / (2* sqrt(v_avg)) ); 
 

% to balance k2/k3 ratio 
%xi = (a^2 - w_avg) * 4 /(2*v_avg*a); 