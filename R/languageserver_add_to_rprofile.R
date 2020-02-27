#' Add languageserver initialization to Rprofile
#'
#' @param rprofilePath `character(1)`, path to the file where
#'   to add the initialization code, or `NULL`. By default, adds the
#'   code to a `.Rprofile` file in the home directory of the current
#'   user.
#' @param confirmBeforeChanging `logical(1)`, if `TRUE`, aks for user
#'   confirmation before changing the file. For non-interactive
#'   use, `FALSE` will skip the confirmation.
#' @param code `character()`, the code to be added to the file.
#'   Defaults to the value of `append_code()`.
#'
#' @return side-effects
#' @export
languageserver_add_to_rprofile <- function(
  rprofilePath = locate_rprofile(),
  confirmBeforeChanging = TRUE,
  code = append_code()
) {

  filePath <- make_rprofile_path(rprofilePath)
  continue <- if (isTRUE(confirmBeforeChanging)) {
    try(askYesNo(
      paste0("This will append code to: ", filePath, "\n", "Do you agree?"),
      default = FALSE
    ))
  } else {
    TRUE
  }

  if (!isTRUE(continue)) {
    message(confirm_message())
    return(FALSE)
  }

  write(code, file = filePath, append = TRUE)
}
