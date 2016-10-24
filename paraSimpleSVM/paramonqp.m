function [alpha , lambda , pos] = paramonqp(H,e,A,b,c,lambda,verbose,x,ps,alphainit);
%paramonqp use monqp in parallel
%   make it faster !
    if(size(H,1)<2000)% chosen arbitrarly
        [alpha , lambda , pos] = monqp(H,e,A,b,c,lambda,verbose,x,ps,alphainit);
    else
        x1=round(size(H,1)/2);
        x2=x1+1:size(H,1);
        x1=1:x1;
        parfor i=1:2
            if i==1
                [paralpha{i}, lambda1, parpos{i}] = paramonqp(H(x1,x1),e(x1),A(x1),b,c,lambda,verbose,x,ps,alphainit);
            else
                [paralpha{i}, lambda2, parpos{i}] = paramonqp(H(x2,x2),e(x2),A(x2),b,c,lambda,verbose,x,ps,alphainit);
            end
        end
        alphainit=zeros(1,size(H,1))';
        alphainit(parpos{1})=paralpha{1};
        alphainit(parpos{2}+round(size(H,1)/2))=paralpha{2};
        [alpha , lambda , pos] = monqp(H,e,A,b,c,lambda,verbose,x,ps,alphainit);
    end
end

