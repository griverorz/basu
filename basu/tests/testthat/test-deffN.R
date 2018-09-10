context("Warning with deff")

test_that("v.pwr.p.test warning non-N calculations",
    expect_warning(v.pwr.p.test(h=1, sig.level=0.05, n=10, deff=2)))

test_that("v.pwr.2p.test warning non-N calculations",
    expect_warning(v.pwr.2p.test(h=1, sig.level=0.05, n=10, deff=2)))

test_that("v.pwr.t.test warning non-N calculations",
    expect_warning(v.pwr.t.test(d=1, sig.level=0.05, n=10, deff=2)))

test_that("v.pwr.r.test warning non-N calculations",
    expect_warning(v.pwr.r.test(r=.8, sig.level=0.05, n=10, deff=2)))

test_that("Omitting deff in v.pwr.p.test takes default value",
    expect_equal(v.pwr.p.test(h=1, sig.level=0.05, n=10)$deff, 1))

test_that("Omitting deff in v.pwr.2p.test takes default value",
    expect_equal(v.pwr.2p.test(h=1, sig.level=0.05, n=10)$deff, 1))

test_that("Omitting deff in v.pwr.t.test takes default value",
    expect_equal(v.pwr.t.test(d=1, sig.level=0.05, n=10)$deff, 1))

test_that("Omitting deff in r.pwr.p.test takes default value",
    expect_equal(v.pwr.r.test(r=.8, sig.level=0.05, n=10)$deff, 1))
