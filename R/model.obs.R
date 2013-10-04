model.obs <- function (nobs, covs, prior, path) 
{
    cat("\n            for (i in 1:", nobs, ") {", file = paste(path, "model.txt", sep = ""), append = T, sep = "")
    cat("\n            Y[i] ~ dnorm(mu[i],prec)\n            mu[i] <- alpha + beta*Treat[i]\n            }", file = paste(path, 
        "model.txt", sep = ""), append = T, sep = "")
    cat("\n\t    alpha ~ ", prior$Prior.alpha, "\n", "   beta ~ ", prior$Prior.beta, file = paste(path, "model.txt", sep = ""), 
        append = T, sep = "")
}
