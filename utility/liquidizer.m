function vpq= liquidizer(U, C, method, vpq)

np= size(U,1); % number of participants
nq= size(U,2); % number of queries

T= 100;          % number of voting iterations
wp= zeros(1,nq); % initial implementation

% iterate over the voting rounds
for t=1:T
    for i=1:np
        vpq_old= vpq;
        wp_old= wp;
        R_old=sum(vpq,1);
        
        % user i optimizers her voting preferences
        vc= randn(1,nq).^3;
        vpq(i, :)= vpq(i,:) + 0.02* vc/norm(vc);
        % (T-t+1)/T *
        
        if strcmp(method, 'liquidizer')
            vpq= diag(1./sqrt(sum(vpq.^2,2)))* vpq;
        elseif strcmp(method, 'cumulative')
            vpq= diag(1./sum(abs(vpq),2)) * vpq;
        elseif strcmp(method, 'approval')
            vpq= min(1.0, max(-1.0, vpq));
        else
            error('Unknown method')
        end

        % vote results according to cummulative voting
        x= [1:nq];
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

