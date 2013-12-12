wrap.norm2 <-
  function(observations, score.range = c(30, 10, 10, 10, 10, 10),
           Covs=NULL, model = "normal", var.model = "hom", nChains = 3, 
           conv.limit = 1.05, niters = 50000, nruns = 5000, setsize = 4000, 
           alphaprior, betaprior, varprior,varprior.params, path = "")
  {
    # Pain, Fatigue, Drowsy, Sleep, Thinking, Constipation are vectors of outcomes
    # Treat is vector of treatment labels
    # score.range is vector of upper limits of scores (with 0 as lower limit)
    # Covs is matrix of covariates in meta-regression model; if none given, it is NULL
    # model is normal (for now)
    # var.model is homogeneous by default for now
    # nChains is number of MCMC chains to run
    # conv.limit is limit for BGR convergence
    # niters is number of MCMC iterations to run
    # nruns is number of MCMC iterations to save
    # setsize is number of MCMC iterations after which convergence diagnostics should be checked
    # alphaprior is prior for intercept as 3 element list (distribution, mean, precision)
    # betaprior is prior for treatment effect as 3 element list (distribution, mean, precision)
    # varprior is 2 element list of parameter and distribution upon which prior for variance is put 
    #    choices for parameter: precision(prec), variance(var), sd(sd)
    #    choices for distribution: gamma(gamma), Wishart(wish), uniform(unif), halfnormal(hn)
    # varprior.params is vector of parameters of variance distribution
    # path is directory where data are stored
    
    
    if(all(c("Constipation", "Drowsy", "Fatigue", "Pain", "Sleep", "Thinking", "Treat") %in% names(observations))){
      stop("Input argument 'observations' must contain fields Pain, Fatigue, Drowsy, Sleep, Thinking, Constipation, Treat.")
    }
    
    if(any(is.na(observations))){
      stop("Input argument 'observations' contained missing values for some fields.")
    }
    
    Constipation <- observations$Constipation
    Drowsy <- observations$Drowsy
    Fatigue <- observations$Fatigue
    Pain <- observations$Pain
    Sleep <- observations$Sleep
    Thinking <- observations$Thinking
    Treat <- observations$Treat
    
    stopifnot(length(varprior)==2)
    stopifnot(length(alphaprior)==3, length(betaprior)==3)
    stopifnot(length(varprior.params)==2)
    
    varprior = as.list(varprior)
    alphaprior = as.list(alphaprior)
    betaprior = as.list(betaprior)
    
    outnames = c("Pain", "Fatigue", "Drowsy", "Sleep", "Thinking", "Constipation")
    names(score.range) = outnames
    
    Pain.out = run.norm(Pain, Treat, Covs, model, var.model, nChains, conv.limit, niters, nruns, setsize, alphaprior, betaprior, varprior,varprior.params, path = "")
    Fatigue.out = run.norm(Fatigue, Treat, Covs, model, var.model, nChains, conv.limit, niters, nruns, setsize, alphaprior, betaprior, varprior,varprior.params, path = "")
    Drowsy.out = run.norm(Drowsy, Treat, Covs, model, var.model, nChains, conv.limit, niters, nruns, setsize, alphaprior, betaprior, varprior,varprior.params, path = "")
    Sleep.out = run.norm(Sleep, Treat, Covs, model, var.model, nChains, conv.limit, niters, nruns, setsize, alphaprior, betaprior, varprior,varprior.params, path = "")
    Thinking.out = run.norm(Thinking, Treat, Covs, model, var.model, nChains, conv.limit, niters, nruns, setsize, alphaprior, betaprior, varprior,varprior.params, path = "")
    Constipation.out = run.norm(Constipation, Treat, Covs, model, var.model, nChains, conv.limit, niters, nruns, setsize, alphaprior, betaprior, varprior,varprior.params, path = "")
    
    Pain.beta = Pain.out[["beta"]]
    Fatigue.beta = Fatigue.out[["beta"]]
    Drowsy.beta = Drowsy.out[["beta"]]
    Sleep.beta = Pain.out[["beta"]]
    Thinking.beta = Thinking.out[["beta"]]
    Constipation.beta = Constipation.out[["beta"]]
    
    Pain.beta.change = beta.change(Pain.beta, score.range["Pain"])
    Fatigue.beta.change = beta.change(Fatigue.beta, score.range["Fatigue"])
    Drowsy.beta.change = beta.change(Drowsy.beta, score.range["Drowsy"])
    Sleep.beta.change = beta.change(Sleep.beta, score.range["Sleep"])
    Thinking.beta.change = beta.change(Thinking.beta, score.range["Thinking"])
    Constipation.beta.change = beta.change(Constipation.beta, score.range["Constipation"])
    
    beta.change.interval = round(rbind(Pain.beta.change[[1]], Fatigue.beta.change[[1]], Drowsy.beta.change[[1]], Sleep.beta.change[[1]], Thinking.beta.change[[1]], Constipation.beta.change[[1]]),3)
    beta.change.probs = round(rbind(Pain.beta.change[[2]], Fatigue.beta.change[[2]], Drowsy.beta.change[[2]], Sleep.beta.change[[2]], Thinking.beta.change[[2]], Constipation.beta.change[[2]]),3)
    dimnames(beta.change.interval) = list(outnames,c("P025", "Median", "P975"))
    dimnames(beta.change.probs) = list(outnames, paste("Proportion",c("< 0.2", "-0.2 - 0", "0 - 0.2", "> 0.2")))
    
    #return a list like this
    list (
      interval = as.data.frame(beta.change.interval),
      probs = as.data.frame(beta.change.probs)
    )
  }
