# Create posts automatically
# Author: Shixiang Wang
# License: MIT
new_post <- function(post_name = NULL, dir = file.path(getwd(), "content/cn/post"),
                     type = c("rmd", "md"),
                     template_path = getwd(), add_prefix = TRUE, edit_file = TRUE,
                     force = FALSE) {
  if (is.null(post_name)) {
    stop("A post name must be given!")
  }

  type <- match.arg(type)
  if (type == "rmd") {
    template_name <- "template_post.Rmd"
  } else if (type == "md") {
    template_name <- "template_post.md"
  } else {
    stop("Not supported!")
  }

  input_file <- file.path(template_path, template_name)
  if (add_prefix) {
    current_time <- Sys.Date()
    if (type == "rmd") {
      out_file <- file.path(dir, paste0(current_time, "-", post_name, ".Rmd"))
    } else {
      out_file <- file.path(dir, paste0(current_time, "-", post_name, ".md"))
    }
  } else {
    if (type == "rmd") {
      out_file <- file.path(dir, paste0(post_name, ".Rmd"))
    } else {
      out_file <- file.path(dir, paste0(post_name, ".md"))
    }
  }

  if (file.exists(out_file)) {
    if (!force) stop("File exists, use force=TRUE if you make sure rewrite it.")
  }
  message("Copying contents of ", input_file, " to ", out_file)
  fl_content <- readLines(input_file)
  # Modify contents in template
  fl_content <- ifelse(grepl("date:", fl_content), paste0("date:", " \"", Sys.Date(), "\""), fl_content)
  if (type == "md") {
    fl_content <- ifelse(grepl("lastmod:", fl_content), paste0("lastmod:", " \"", Sys.Date(), "\""), fl_content)
  }
  writeLines(fl_content, out_file)
  if (edit_file) {
    file.edit(out_file)
  }
  if (type == "rmd") {
    message("Create new Rmarkdown post successfully!")
  } else {
    message("Create new markdown post successfully!")
  }
}
