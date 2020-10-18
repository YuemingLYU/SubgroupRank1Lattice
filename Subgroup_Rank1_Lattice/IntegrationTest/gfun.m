function y = gfun(x, c, b)


y = reshape( ...
exp(c * (1:size(x,1)).^(-b) * x(:,:)), ...
max((1:ndims(x) ~= 1) .* size(x), 1) ... % first dim to 1
);

y= mean(y);


%gexact = @(s, c, b) prod(expm1(c*(1:s).^(-b))./(c*(1:s).^(-b)));

end

