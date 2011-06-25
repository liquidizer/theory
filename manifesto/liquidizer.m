function wp= liquidizer(U, C)

np= size(U,1);
nq= size(U,2);

S= floor(nq/2);
T= 300; % number of voting iterations

vpq= 1e-8*ones(size(U));
wp=zeros(1,nq);
for t=1:T
    for ii=1:np
        i= floor(rand()*np)+1;
        vpq_old= vpq;
        wp_old= wp;
        u_old= satisfaction(U(i, :), C(:,:,i), wp);
        R_old=sum(vpq,1);

        % user i optimizers her voting preferences
        vc= log(rand(1,nq)).*(rand(1,nq)-0.5);
        vpq(i, :)= vpq(i,:) + (T-t+1)/T * vc/norm(vc);
        vpq= diag(1./sum(abs(vpq),2))* vpq;
        
        if randn() < t/T
            % vote results according to cummulative voting
            R=sum(vpq,1);
            %sr= sort(R);
            wp= R>0;%sr(end-S);

            u_new= satisfaction(U(i, :), C(:,:,i), wp);
            if u_new<u_old || (u_new==u_old && ...
                     satisfaction(U(i,:),C(:,:,i),R) <...
                     satisfaction(U(i,:),C(:,:,i),R_old)) 
                 wp= wp_old;
                 vpq= vpq_old;
            end
        end
    end
    
end

% vote results according to cummulative voting
R=sum(vpq,1);
%sr= sort(R);
wp= R>0;%sr(end-S);
end

