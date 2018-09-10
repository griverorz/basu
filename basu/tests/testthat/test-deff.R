context("Design effect")

t1 <- v.pwr.p.test(h=1, sig.level=0.05, power=0.8, deff=1)
t2 <- v.pwr.p.test(h=1, sig.level=0.05, power=0.8, deff=2)

test_that("Doubling deff in v.pwr.p.test doubles N",
    expect_equal(t1$n, t2$n/2))

t1 <- v.pwr.2p.test(h=1, sig.level=0.05, power=0.8, deff=1)
t2 <- v.pwr.2p.test(h=1, sig.level=0.05, power=0.8, deff=2)

test_that("Doubling deff in v.pwr.2p.test doubles N",
    expect_equal(t1$n, t2$n/2))

t1 <- v.pwr.t.test(d=1, sig.level=0.05, power=0.8, deff=1)
t2 <- v.pwr.t.test(d=1, sig.level=0.05, power=0.8, deff=2)

test_that("Doubling deff in v.pwr.t.test doubles N",
    expect_equal(t1$n, t2$n/2))

t1 <- v.pwr.r.test(r=.8, sig.level=0.05, power=0.8, deff=1)
t2 <- v.pwr.r.test(r=.8, sig.level=0.05, power=0.8, deff=2)

test_that("Doubling deff in v.pwr.r.test doubles N",
    expect_equal(t1$n, t2$n/2))

test_that("Vectorizing deff in v.pwr.p.test produces an error",
    expect_error(v.pwr.p.test(h=1, sig.level=0.05, n=10, deff=c(1, 2))))

test_that("Vectorizing deff in v.pwr.2p.test produces an error",
    expect_error(v.pwr.2p.test(h=1, sig.level=0.05, n=10, deff=c(1, 2))))

test_that("Vectorizing deff in v.pwr.t.test produces an error",
    expect_error(v.pwr.t.test(d=1, sig.level=0.05, n=10, deff=c(1, 2))))

test_that("Vectorizing deff in v.pwr.r.test produces an error",
    expect_error(v.pwr.p.test(r=.8, sig.level=0.05, n=10, deff=c(1, 2))))

