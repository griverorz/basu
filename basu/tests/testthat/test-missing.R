context("Captures missing variable")

test_that("Captures missing h in v.pwr.p.test",
    expect_that(v.pwr.p.test(n=100, sig.level=0.05, power=0.8, deff=1)$calculated_covar, "h"))

test_that("Captures missing n in v.pwr.p.test",
    expect_that(v.pwr.p.test(h=1, sig.level=0.05, power=0.8, deff=1)$calculated_covar, "n"))

test_that("Captures missing sig.level in v.pwr.p.test",
    expect_that(v.pwr.p.test(h=1, n=50, power=0.8, deff=1)$calculated_covar, "sig.level"))

test_that("Captures missing power in v.pwr.p.test",
    expect_that(v.pwr.p.test(h=1, n=50, sig.level=0.05, deff=1)$calculated_covar, "power"))
