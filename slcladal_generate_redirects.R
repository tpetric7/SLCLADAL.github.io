# ============================================================
# SLCLADAL.github.io — Redirect Generator
# ============================================================
# Run this script from the root of the SLCLADAL.github.io repo.
# It writes redirect HTML files into docs/ covering all known
# old tutorial URLs, sending visitors to the correct new pages
# on ladal.edu.au.
#
# After running:
#   1. Commit and push the docs/ folder to master
#   2. GitHub Pages will deploy within 1-2 minutes
# ============================================================

# ── Helper: write a redirect HTML file ───────────────────────────────────────

write_redirect <- function(output_path, destination_url) {
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  content <- paste0(
    "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"UTF-8\">\n",
    "    <meta http-equiv=\"refresh\" content=\"0; url=", destination_url, "\">\n",
    "    <script>window.location.replace(\"", destination_url, "\");</script>\n",
    "    <title>Redirecting to LADAL...</title>\n  </head>\n  <body>\n",
    "    <p>This page has moved. ",
    "<a href=\"", destination_url, "\">Click here</a> ",
    "if you are not redirected automatically.</p>\n  </body>\n</html>\n"
  )
  cat(content, file = output_path)
}

base_new <- "https://ladal.edu.au"

# ── Section 1: Main site pages ───────────────────────────────────────────────

write_redirect("docs/index.html",    paste0(base_new))
write_redirect("docs/about.html",    paste0(base_new, "/about.html"))
write_redirect("docs/tutorials.html",paste0(base_new, "/tutorials.html"))
write_redirect("docs/tools.html",    paste0(base_new, "/tools.html"))
write_redirect("docs/events.html",   paste0(base_new, "/events.html"))
write_redirect("docs/contact.html",  paste0(base_new, "/contact.html"))
write_redirect("docs/resources.html",paste0(base_new, "/resources.html"))

# ── Section 2: Tutorial redirects (old flat → new subfolder) ─────────────────
# Format: old slug → new tutorials/[folder]/[file].html

tutorials <- list(
  # Data Science Basics
  "comp"         = "workingwithcomputers_tutorial/workingwithcomputers_tutorial",
  "repro"        = "repro/repro",
  "introquant"   = "introquant/introquant",
  "basicquant"   = "basicquant/basicquant",

  # R Basics
  "intror"       = "intror/intror",
  "load"         = "load/load",
  "string"       = "string/string",
  "regex"        = "regex/regex",
  "table"        = "table/table",
  "whyr"         = "whyr/whyr",

  # Data Visualisation
  "introviz"     = "introviz/introviz",
  "dviz"         = "dviz/dviz",
  "gviz"         = "introviz/introviz",      # retired → closest equivalent

  # Statistics
  "dstats"       = "descriptivestats_tutorial/descriptivestats_tutorial",
  "basicstatz"   = "basicstatz/basicstatz",
  "regression"   = "regression/regression",
  "tree"         = "tree/tree",
  "clust"        = "clust/clust",
  "dimred"       = "dimred/dimred",
  "lexsim"       = "lexsim/lexsim",
  "svm"          = "semanticvectors_tutorial/semanticvectors_tutorial",
  "pwr"          = "pwr/pwr",
  "laegs"        = "basicstatz/basicstatz",  # retired → closest equivalent

  # Text Analytics
  "introta"      = "introta/introta",
  "textanalysis" = "textanalysis/textanalysis",
  "kwics"        = "kwics/kwics",
  "coll"         = "collocation_tutorial/collocation_tutorial",
  "ngrams"       = "collocation_tutorial/collocation_tutorial",
  "key"          = "key/key",
  "keywords"     = "key/key",
  "net"          = "net/net",
  "topic"        = "topic/topic",
  "topicmodels"  = "topic/topic",
  "sentiment"    = "sentiment/sentiment",
  "postag"       = "postag/postag",
  "tagging"      = "postag/postag",
  "txtsum"       = "txtsum/txtsum",
  "spellcheck"   = "spellcheck/spellcheck",
  "embeddings"   = "embeddings/embeddings",

  # Case Studies
  "corplingr"    = "corpuslinguistics_showcase/corpuslinguistics_showcase",
  "llr"          = "llr/llr",
  "lex"          = "lex/lex",
  "surveys"      = "surveys/surveys",
  "vc"           = "vowelchart/vowelchart",
  "litsty"       = "litsty/litsty",
  "reinfnlp"     = "reinfnlp/reinfnlp",
  "atap_docclass"= "atap_docclass/atap_docclass",
  "phylo"        = "tutorials",              # retired → tutorials index

  # How-Tos
  "pdf2txt"      = "pdf2txt/pdf2txt",
  "gutenberg"    = "gutenberg/gutenberg",

  # Retired / no direct equivalent → tutorials index
  "webcrawling"  = "tutorials",
  "compthink"    = "introquant/introquant",
  "compthinking" = "introquant/introquant",
  "motion"       = "tutorials",
  "base"         = "tutorials"
)

for (old_slug in names(tutorials)) {
  new_path <- tutorials[[old_slug]]
  # If new_path contains a slash it's a tutorial subfolder path,
  # otherwise it's a top-level page
  if (grepl("/", new_path)) {
    dest <- paste0(base_new, "/tutorials/", new_path, ".html")
  } else {
    dest <- paste0(base_new, "/", new_path, ".html")
  }
  write_redirect(paste0("docs/", old_slug, ".html"), dest)
}

# ── Section 3: Old opening/events/news pages ─────────────────────────────────

write_redirect("docs/opening.html",  paste0(base_new, "/events.html"))
write_redirect("docs/news.html",     paste0(base_new, "/events.html"))
write_redirect("docs/people.html",   paste0(base_new, "/about.html#directors"))
write_redirect("docs/citing.html",   paste0(base_new, "/about.html#citing"))

# ── Section 4: Old data and resource file URLs ───────────────────────────────
# These can't truly redirect binary files, but HTML redirect files at these
# paths will catch any browser requests and send users to a relevant page.

write_redirect("content/bibliography.bib",    paste0(base_new, "/about.html"))
write_redirect("resources/stopwords_en.txt",  paste0(base_new, "/tutorials/topic/topic.html"))

# ── Summary ───────────────────────────────────────────────────────────────────

message(
  "Done! Redirect files written to docs/\n",
  "  Main pages:  7\n",
  "  Tutorials:   ", length(tutorials), "\n",
  "  Other pages: 4\n",
  "  Data files:  2\n",
  "Total: ", 7 + length(tutorials) + 4 + 2, " redirect files\n\n",
  "Next steps:\n",
  "  1. git add docs/\n",
  "  2. git commit -m 'Add comprehensive redirects to ladal.edu.au'\n",
  "  3. git push origin master"
)
