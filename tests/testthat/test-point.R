context("point")



# spaces
stt <- '{ "type": "Point", "coordinates": [100.0, 0.0] }'
aa <- point(stt)

# minified
stt <- '{"type":"Point","coordinates":[1,2]}'
bb <- point(stt)

test_that("point object structure is correct", {
  expect_is(aa, "geopoint")
  expect_is(aa[[1]], "character")
  expect_match(aa[[1]], "type")
  expect_match(aa[[1]], "Point")
  expect_match(aa[[1]], "coordinates")

  expect_is(bb, "geopoint")
  expect_is(bb[[1]], "character")
  expect_match(bb[[1]], "type")
  expect_match(bb[[1]], "Point")
  expect_match(bb[[1]], "coordinates")
})

test_that("methods on points work", {
  expect_is(geo_bbox(aa), "numeric")
  expect_equal(geo_bbox(aa), c(100, 0, 100, 0))
  expect_equal(geo_type(aa), "Point")

  f <- file(tempfile())
  geo_write(aa, f)
  expect_is(f, "file")
})

test_that("print method for point", {
  expect_output(print(aa), "<Point>")
  expect_output(print(aa), "coordinates:")
})

test_that("point fails well", {
  expect_error(point('{"type": "FooBar"}'), "type can not be 'FooBar'")

  expect_error(point('{"type": "Point"}'), "keys not correct")

  expect_error(point('{"type": "Point", "coordinates"}'),
               "object key and value must be separated by a colon")

  expect_error(point('{"type": "Point", "coordinates": [}'),
               "unallowed token at this point in JSON text")

  expect_error(point('{"type": "Point", "coordinates": [1,]}'),
               "unallowed token at this point in JSON text")

  expect_error(point('{"type": "Point", "coordinates": [1,s]}'),
               "invalid char in json text")

  expect_error(point(5), "no method for numeric")
})
