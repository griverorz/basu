context("Calculates p1 if appropriate")

test_that("Errors if missing p1 in v.pwr.p.test",
          expect_error(basu:::v.pwr.p.test(n=100,
                                           sig.level=0.05,
                                           p2=.1,
                                           power=.8,
                                           alternative="greater")))

test_that("Errors if with p2 and other parameter missing in v.pwr.2p.test",
          expect_error(basu:::v.pwr.2p.test(n=100,
                                            p2=.1,
                                            power=.8,
                                            alternative="greater")))

test_that("Estimates missing p1 in v.pwr.2p.test",
          expect_equal(basu:::v.pwr.2p.test(n=100,
                                            sig.level=0.05,
                                            p2=.1,
                                            power=.8,
                                            alternative="greater")$calculated_covar,
                       "p1"))
