beta.change <- function (beta, score.range) 
{
    beta.change = beta/score.range
    beta.change.1 = as.vector(c(quantile(beta.change, 0.025), median(beta.change), quantile(beta.change, 0.975)))
    beta.change.2 = as.numeric(table(cut(beta.change, breaks = c(-1, -0.2, 0, 0.2, 1))))/length(beta.change)
    return(list(beta.change.1, beta.change.2))
}
