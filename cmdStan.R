while (!require("cmdstanr")) {
    install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
}
some sort of install something
check_cmdstan_toolchain(fix = TRUE, quiet = TRUE)
