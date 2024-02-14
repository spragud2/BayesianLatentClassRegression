struct GumbelSoftmax <: ContinuousMultivariateDistribution
	π::Vector{Float64}
	τ::Float64
end


function Distributions.pdf(d::GumbelSoftmax,y::Vector{Float64})
	k = size(d.π,1)

	gamma(k) * d.τ^(k-1) * sum(d.π ./ (y).^d.τ)^-k * prod(d.π ./ (y).^(d.τ+1))
	
end

function Distributions.logpdf(d::GumbelSoftmax,y::Vector{Float64})
	k = size(d.π,1)

	loggamma(k) + ((k-1) * log(d.τ)) + (-k * log(sum(d.π ./ (y).^d.τ))) + sum(log.(d.π ./ (y).^(d.τ+1)))
	
end

function Distributions.rand(rng::Random.AbstractRNG,d::GumbelSoftmax)
	k = size(d.π,1)
	G = rand(Gumbel(0,1),k)
	Z = (G .+ log.(d.π)) ./ d.τ
	
	softmax(Z)
	
end

Bijectors.bijector(d::GumbelSoftmax) = SimplexBijector()

Base.length(d::GumbelSoftmax) = length(d.π)

begin 
	r = GumbelSoftmax([0.5,0.5],.1)
	@assert log(pdf(r,[.1,.9])) ≈ logpdf(r,[.1,.9])
end
