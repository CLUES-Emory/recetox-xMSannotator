patrick::with_parameters_test_that(
  "multilevelannotation step 3 works",
  {
    if (exists("skip_function") && is.function(skip_function)) {
      skip_function()
    }
    
    testthat_wd <- getwd()
    testdata_dir <- file.path(testthat_wd, "test-data", subfolder)

    outloc <- file.path(
      tempdir(),
      "multilevelannotationstep3",
      subfolder
    )
    dir.create(outloc, recursive = TRUE)

    # load expected results
    expected <- read.csv(file.path(testdata_dir, "Stage3.csv"))

    # load and set arguments
    chemscoremat <- readRDS(file.path(testdata_dir, "chemscoremat.Rds"))
    load(file.path(testdata_dir, "chemCompMZ.Rda"))
    adduct_weights <- create_adduct_weights(NA, 5)
    pathwaycheckmode <- "pm"
    
    setwd(outloc)

    # compute annotation step 3
    actual <- multilevelannotationstep3(
      chemCompMZ = chemCompMZ,
      chemscoremat = chemscoremat,
      adduct_weights = adduct_weights,
      db_name = db_name,
      max_diff_rt = max_diff_rt,
      pathwaycheckmode = pathwaycheckmode
    )

    actual <- read.csv(file.path(outloc, "Stage3.csv"))

    setwd(testthat_wd)

    actual <- dplyr::arrange_all(actual)
    expected <- dplyr::arrange_all(expected)

    comparison <- dataCompareR::rCompare(
      actual,
      expected,
      keys = names(actual)
    )

    dataCompareR::saveReport(
      comparison,
      reportName = subfolder,
      reportLocation = outloc,
      showInViewer = FALSE,
      mismatchCount = 1000
    )

    expect_equal(actual, expected)
  },
  patrick::cases(
    qc_solvent = list(subfolder = "qc_solvent", db_name = "HMDB", num_sets = 205, max_diff_rt = 0.5),
    batch1_neg = list(subfolder = "batch1_neg", db_name = "HMDB", num_sets = 708, max_diff_rt = 0.5, skip_function = skip_on_ci),
    sourceforge = list(subfolder = "sourceforge", db_name = "HMDB", num_sets = 756, max_diff_rt = 2, skip_function = skip_on_ci)
  )
)