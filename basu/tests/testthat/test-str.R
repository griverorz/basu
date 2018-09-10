context("Object structure")

test_that("Output of v.pwr.p.test is a list",
    expect_is(v.pwr.p.test(h=1, sig.level=0.05, power=0.8, deff=1), "list"))

test_that("Output of v.pwr.2p.test is a list",
    expect_is(v.pwr.2p.test(h=1, sig.level=0.05, power=0.8, deff=1), "list"))

test_that("Output of v.pwr.t.test is a list",
    expect_is(v.pwr.t.test(d=1, sig.level=0.05, power=0.8, deff=1), "list"))

test_that("Output of v.pwr.r.test is a list",
    expect_is(v.pwr.r.test(r=.8, sig.level=0.05, power=0.8, deff=1), "list"))

test_that("Vectorized output of v.pwr.p.test is a list",
          expect_is(v.pwr.p.test(h=c(.1, .2), sig.level=0.05, power=0.8, deff=1), "list"))

test_that("Vectorized output of v.pwr.2p.test is a list",
          expect_is(v.pwr.2p.test(h=c(.1, .2), sig.level=0.05, power=0.8, deff=1), "list"))

test_that("Vectorized output of v.pwr.t.test is a list",
          expect_is(v.pwr.t.test(d=c(1, 2), sig.level=0.05, power=0.8, deff=1), "list"))

test_that("Vectorized output of v.pwr.r.test is a list",
          expect_is(v.pwr.r.test(r=c(.8, .9), sig.level=0.05, power=0.8, deff=1), "list"))

h <- c(.1, .2, .3)
sig.level <- c(0.05, 0.025)
t <- v.pwr.p.test(h=h, sig.level=sig.level, power=0.8, deff=2)

test_that("Vectorizing input of v.pwr.p.test produces size of cartesian product",
    expect_equal(length(t$h), length(h)*length(sig.level)))

h <- c(.1, .2, .3)
sig.level <- c(0.05, 0.025)
t <- v.pwr.2p.test(h=h, sig.level=sig.level, power=0.8, deff=2)

test_that("Vectorizing input of v.pwr.p.test produces size of cartesian product",
    expect_equal(length(t$h), length(h)*length(sig.level)))

d <- c(.1, .2, .3)
sig.level <- c(0.05, 0.025)
t <- v.pwr.t.test(d=d, sig.level=sig.level, power=0.8, deff=2)

test_that("Vectorizing input of v.pwr.t.test produces size of cartesian product",
    expect_equal(length(t$d), length(h)*length(sig.level)))

r <- c(.1, .2, .3)
sig.level <- c(0.05, 0.025)
t <- v.pwr.r.test(r=r, sig.level=sig.level, power=0.8, deff=2)

test_that("Vectorizing input of v.pwr.r.test produces size of cartesian product",
    expect_equal(length(t$r), length(h)*length(sig.level)))

test_that("Inputing more than two vectors to v.pwr.p.test produces an error",
    expect_error(v.pwr.p.test(h=c(1, 2), sig.level=c(0.05, 0.025), n=c(10, 20), deff=2)))

test_that("Inputing more than two vectors to v.pwr.2p.test produces an error",
    expect_error(v.pwr.2p.test(h=c(1, 2), sig.level=c(0.05, 0.025), n=c(10, 20), deff=2)))

test_that("Inputing more than two vectors to v.pwr.t.test produces an error",
    expect_error(v.pwr.t.test(d=c(1, 2), sig.level=c(0.05, 0.025), n=c(10, 20), deff=2)))

test_that("Inputing more than two vectors to v.pwr.r.test produces an error",
    expect_error(v.pwr.r.test(r=c(.1, .2), sig.level=c(0.05, 0.025), n=c(10, 20), deff=2)))

