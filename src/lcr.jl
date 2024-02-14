@model function LCR(X,Y)
	K = 2
	τ = .3
	
	w ~ Dirichlet(ones(K))

	response ~ arraydist(GumbelSoftmax(w),size(y,2))
	μ ~ filldist(Normal(),K)
	σ ~ filldist(Normal(),K)

	for i ∈ 1:size(y,2)
		z = 
	end

end
	
	
