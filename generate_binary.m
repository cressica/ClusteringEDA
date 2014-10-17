%% binary map 

function [Mbw] = generate_binary(Mcolor)

Mcolor=Mcolor';

units=size(Mcolor,1); % units is the number of time interval(5 min, 288) in a day 
obs=size(Mcolor,2); % obs is number of persons
num_labels=13; %12 activities; 1 travel
Mbw = zeros(obs,num_labels*units);

for i = 1:obs
       for j = 1:units
          place=Mcolor(j,i);
          if(place==0) % travel in last column 
             Ji=units*(num_labels-1)+1; 
             J=Ji+j-1;
             Mbw(i,J)=1;
          else
                %Ji=units*(place-1)+1;
                J=units*(place-1)+j;
                Mbw(i,J)=1;
             end
          end
       end
end