context("Testing database connection")

test_that("RPostgreSQL can be loaded", {
  expect_true(is.numeric(match("RPostgreSQL", library(RPostgreSQL))))
})

test_that("yaml can be loaded", {
  expect_true(is.numeric(match("yaml", library(yaml))))
})

test_that("Configuration file can be loaded", {
  config <- LoadConfiguration("../db-config.yaml")
})

test_that("Configuration file contains connection information", {
  config <- LoadConfiguration("../db-config.yaml")
  
  expect_equal(length(config$db), 5)
  expect_equal(config$db$host, "localhost")
  expect_equal(config$db$port, 5432)
  expect_equal(config$db$name, "travis_ci_test")
  expect_equal(config$db$user, "postgres")
  expect_equal(config$db$pass, "")
})

test_that("Configuration file contains logging information", {
  config <- LoadConfiguration("../db-config.yaml")
  
  expect_equal(length(config$logging), 3)
  expect_equal(config$logging$level, "DEBUG")
  expect_equal(config$logging$time.stamp.format, "[%Y-%m-%d %H:%M:%S]")
  expect_null(config$logging$file)
  
})

test_that("Connection can be made to database", {
  config <- LoadConfiguration("../db-config.yaml")
  conn <- StartDBConnection(config = config)
  StopDBConnection(conn = conn, config = config)
})

test_that("TestDBConnection works", {
  config <- LoadConfiguration("../db-config.yaml")
  TestDBConnection(config = config)
})




