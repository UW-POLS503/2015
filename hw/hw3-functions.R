## ----sdcor2cov-----------------------------------------------------------
sdcor2cov <- function(s, r = diag(length(s))) {
  s <- diag(s, nrow = length(s), ncol = length(s))
  s %*% r %*% s
}

## ----sim_lin_norm--------------------------------------------------------
sim_lin_norm <- function(iter, n, mu_X, s_X, R_X, beta, sigma) {
  # Error checking so that bugs are caught quicker :-)
  assert_that(length(s_X) == length(mu_X),
              ncol(R_X) == nrow(R_X),
              ncol(R_X) == length(mu_X),
              length(beta) == (length(mu_X) + 1))
  # Generate an X
  X <- MASS::mvrnorm(n, mu = mu_X, Sigma = sdcor2cov(s_X, R_X),
                     empirical = TRUE)
  # Create a list to stor the results
  iterations <- list()
  # Create a progress bar because we're impatient
  p <- progress_estimated(iter, min_time = 2)
  # Loop over the simulation runs
  for (j in 1:iter) {
    # Draw y
    mu <- cbind(1, X) %*% beta
    epsilon <- rnorm(n, mean = 0, sd = sigma)
    y <- mu + epsilon
    # Run a regression
    mod <- lm(y ~ X)
    # Save the coefficients in a data frame
    mod_df <- tidy(mod) %>%
      # Add a column indicating the simulation number
      mutate(.iter = j)
    # Add hetroskedasticity consistent se to the data
    mod_df[["std.error.robust"]] <- sqrt(diag(car::hccm(mod)))
    # Save these results as the next element in the storage list
    iterations[[j]] <- mod_df
    # Update the progress bar
    p$tick()$print()
  }
  # Combine the list of data frames into a single data frame
  bind_rows(iterations)
}


## ----summarize_sim-------------------------------------------------------
summarize_sim <- function(.data, beta) {
  ret <- .data %>%
    group_by(term) %>%
    summarize(estimate_mean = mean(estimate),
              estimate_sd = sd(estimate),
              se_mean = sqrt(mean(std.error) ^ 2),
              se_robust_mean = sqrt(mean(std.error.robust) ^ 2),
              iter = length(estimate))
  ret[["beta_true"]] <- beta
  ret
}

## ----sim_lin_norm_omitted------------------------------------------------
sim_lin_norm_omitted <- function(iter, n, mu_X, s_X, R_X, beta, sigma,
                                 omit = integer(0)) {
  assert_that(length(s_X) == length(mu_X),
              ncol(R_X) == nrow(R_X),
              ncol(R_X) == length(mu_X),
              length(beta) == (length(mu_X) + 1))
  # Generate an X
  k <- length(mu_X)
  X <- MASS::mvrnorm(n, mu_X, sdcor2cov(s_X, R_X), empirical = TRUE)
  # ------
  # NEW: ensure colnames of X are consistent despite omitting some in lm
  colnames(X) <- paste("X", 1:k, sep = "")
  # ------
  iterations <- list()
  p <- progress_estimated(iter, min_time = 2)
  for (j in 1:iter) {
    mu <- cbind(1, X) %*% beta
    epsilon <- rnorm(n, mean = 0, sd = sigma)
    y <- mu + epsilon
    # ---------
    # NEW: omit columns of X
    # Look up paste and setdiff function to see what they does
    Xomit <- as.data.frame(X)[ , setdiff(1:k, omit)]
    # ~ . means use all variables from `data` on the RHS of the formula
    mod <- lm(y ~ . , data = Xomit)
    # ---------
    mod_df <- tidy(mod) %>%
      mutate(.iter = j)
    mod_df[["std.error.robust"]] <- sqrt(diag(car::hccm(mod)))
    iterations[[j]] <- mod_df
    p$tick()$print()
  }
  # Combine the list of data frames into a single data frame
  bind_rows(iterations)
}

## ----sim_lin_norm_heterosked-----------
sim_lin_norm_heterosked <- function(iter, n, mu_X, s_X, R_X, beta, gamma) {
  assert_that(length(s_X) == length(mu_X),
              ncol(R_X) == nrow(R_X),
              ncol(R_X) == length(mu_X),
              length(beta) == (length(mu_X) + 1),
              length(gamma) == (length(mu_X) + 1))
  X <- MASS::mvrnorm(n, mu_X, sdcor2cov(s_X, R_X), empirical = TRUE)
  iterations <- list()
  p <- progress_estimated(iter, min_time = 2)
  for (j in 1:iter) {
    mu <- cbind(1, X) %*% beta
    # ------------
    # NEW: variance varies by each observation
    sigma <- sqrt(exp(cbind(1, X) %*% gamma))
    # ------------
    epsilon <- rnorm(n, mean = 0, sd = sigma)
    y <- mu + epsilon
    # Run a regression
    mod <- lm(y ~ X)
    # Save the coefficients in a data frame
    # and Add a column indicating the simulation number
    mod_df <- tidy(mod) %>%
      mutate(.iter = j)
    mod_df[["std.error.robust"]] <- sqrt(diag(car::hccm(mod)))
    iterations[[j]] <- mod_df
    p$tick()$print()
  }
  bind_rows(iterations)
}

## ----sample_lin_norm_heterosked-----------
sample_lin_norm_heterosked <- function(iter, n, mu_X, s_X, R_X, beta, gamma) {
  assert_that(length(s_X) == length(mu_X),
              ncol(R_X) == nrow(R_X),
              ncol(R_X) == length(mu_X),
              length(beta) == (length(mu_X) + 1),
              length(gamma) == (length(mu_X) + 1))
  X <- MASS::mvrnorm(n, mu_X, sdcor2cov(s_X, R_X), empirical = TRUE)
  iterations <- list()
  p <- progress_estimated(iter, min_time = 2)
  for (j in 1:iter) {
    mu <- cbind(1, X) %*% beta
    # ------------
    # NEW: variance varies by each observation
    sigma <- sqrt(exp(cbind(1, X) %*% gamma))
    # ------------
    epsilon <- rnorm(n, mean = 0, sd = sigma)
    y <- as.numeric(mu + epsilon)
    iterations[[j]] <-
      data_frame(y = y) %>%
      bind_cols(as.data.frame(X)) %>%
      mutate(.iter = j)
    p$tick()$print()
  }
  bind_rows(iterations)
}

## ----sim_lin_norm_truncated----------------------------------------------
sim_lin_norm_truncated <- function(iter, n, mu_X, s_X, R_X, beta, sigma,
                                   truncation = 0.5) {
  X <- MASS::mvrnorm(n, mu_X, sdcor2cov(s_X, R_X), empirical = TRUE)
  iterations <- list()
  p <- progress_estimated(iter, min_time = 2)
  for (j in 1:iter) {
    mu <- cbind(1, X) %*% beta
    epsilon <- rnorm(n, mean = 0, sd = sigma)
    y <- mu + epsilon
    # -------
    # NEW: drop cases in which y > mean(y)
    is_obs <- (y > quantile(y, prob = truncation))
    yobs <- y[is_obs, ]
    Xobs <- X[is_obs, ]
    # give consistent colnames
    colnames(Xobs) <- paste("X", 1:k, sep = "")
    colnames(yobs) <- "y"
    # ------
    # -------
    # Run a regression
    mod <- lm(yobs ~ Xobs)
    # Save the coefficients in a data frame
    # and Add a column indicating the simulation number
    mod_df <- tidy(mod) %>%
      mutate(.iter = j)
    mod_df[["std.error.robust"]] <- sqrt(diag(car::hccm(mod)))
    iterations[[j]] <- mod_df
    p$tick()$print()
  }
  bind_rows(iterations)
}
