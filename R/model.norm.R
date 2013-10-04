model.norm <- function (nobs, covs, prior, varprior, path) 
{
    cat("model\n{", file = paste(path, "model.txt", sep = ""))
    model.obs(nobs, covs, prior, path)
    var.hom(prior, varprior, path)
    cat("\n    }", file = paste(path, "model.txt", sep = ""), append = T, sep = "")
}
