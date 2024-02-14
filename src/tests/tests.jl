r = GumbelSoftmax([0.5,0.5],.1)
@assert log(pdf(r,[.1,.9])) ≈ logpdf(r,[.1,.9])