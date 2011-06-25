function [wp,vpq]= liquidizer(U, C, method)

np= size(U,1); % number of participants
nq= size(U,2); % number of queries

T= 500000;               % number of voting iterations
vpq= 1e-8*ones(size(U)); % initial voting weights
wp=zeros(1,nq);          % initial manifesto

% iterate over the voting rounds
for t=1:T
    for ii=1:np
        i= floor(rand()*np)+1;
        vpq_old= vpq;
        wp_old= wp;
        R_old=sum(vpq,1);

        % user i optimizers her voting preferences
        vc= log(rand(1,nq)).*(rand(1,nq)-0.5);
        vpq(i, :)= vpq(i,:) + (T-t+1)/T * vc/norm(vc);
	if strcmp(method, 'liquidizer')
          vpq= diag(1./sqrt(sum(vpq.^2,2)))* vpq;
	elseif strcmp(method, 'cumulative')
          vpq= diag(1./sum(abs(vpq),2)) * vpq;
	elseif strcmp(method, 'approval')
          vpq= diag(1./max(abs(vpq),[],2))* vpq;
	else
	  error('Unknown method')
        end
        
        if rand() < (t/T)^2
            % vote results according to cummulative voting
            R=sum(vpq,1);
            wp= R>0;

            u_old= satisfaction(U(i,:), C(:,:,i), wp_old);
            u_new= satisfaction(U(i,:), C(:,:,i), wp);
            if u_new<u_old || (u_new==u_old && ...
                     satisfaction(U(i,:), C(:,:,i), R) <...
                     satisfaction(U(i,:), C(:,:,i), R_old)) 
                 wp= wp_old;
                 vpq= vpq_old;
            end
        end
    end
end
end

