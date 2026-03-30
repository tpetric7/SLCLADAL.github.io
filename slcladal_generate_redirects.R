# ============================================================
# SLCLADAL.github.io — Redirect Generator
# ============================================================
# Run this script from the root of the SLCLADAL.github.io repo.
# It writes redirect HTML files into docs/ covering all known
# old tutorial URLs, sending visitors to the correct live pages
# on ladal.edu.au.
#
# After running:
#   1. git add docs/
#   2. git commit -m "update redirects"
#   3. git push origin master
#   GitHub Pages will deploy within 1-2 minutes.
#
# Last updated: 2025-03
# Changes from previous version:
#   - kwics  → concordancing_tutorial (old kwics tutorial deleted)
#   - kwics  alias tagging also updated
#   - All other rename mappings verified correct
# ============================================================

# ── Helper: write a single redirect HTML stub ─────────────────────────────────
write_redirect <- function(output_path, destination_url) {
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  content <- paste0(
    "<!DOCTYPE html>\n<html lang=\"en\">\n <head>\n  <meta charset=\"UTF-8\">\n",
    "  <meta http-equiv=\"refresh\" content=\"0; url=", destination_url, "\">\n",
    "  <script>window.location.replace(\"", destination_url, "\");</script>\n",
    "  <title>Redirecting to LADAL...</title>\n </head>\n <body>\n",
    "  <p>This page has moved. ",
    "<a href=\"", destination_url, "\">Click here</a> ",
    "if you are not redirected automatically.</p>\n </body>\n</html>\n"
  )
  cat(content, file = output_path)
}

base_new <- "https://ladal.edu.au"

# ── Section 1: Main site pages ────────────────────────────────────────────────
write_redirect("docs/index.html",     paste0(base_new))
write_redirect("docs/about.html",     paste0(base_new, "/about.html"))
write_redirect("docs/tutorials.html", paste0(base_new, "/tutorials.html"))
write_redirect("docs/tools.html",     paste0(base_new, "/tools.html"))
write_redirect("docs/events.html",    paste0(base_new, "/events.html"))
write_redirect("docs/contact.html",   paste0(base_new, "/contact.html"))
write_redirect("docs/resources.html", paste0(base_new, "/resources.html"))

# ── Section 2: Tutorial redirects ─────────────────────────────────────────────
#
# Format: old_slug = "new/path"
#   • If value contains "/" it becomes: /tutorials/new/path.html
#   • If value has no "/" it becomes:   /value.html  (top-level page)
#
# KEY:
#   [RENAMED]  old slug → new folder name confirmed changed
#   [DELETED]  tutorial no longer exists → redirect to best equivalent
#   [ALIAS]    old alternative name for same tutorial
#   [OK]       path unchanged, just moved under /tutorials/
#
tutorials <- list(
  
  # ── Data Science Basics ──────────────────────────────────────────────────────
  "comp"          = "workingwithcomputers_tutorial/workingwithcomputers_tutorial", # [RENAMED]
  "repro"         = "repro/repro",           # [OK]
  "introquant"    = "introquant/introquant", # [OK]
  "basicquant"    = "basicquant/basicquant", # [OK]
  "compthink"     = "introquant/introquant", # [ALIAS → introquant]
  "compthinking"  = "introquant/introquant", # [ALIAS → introquant]
  
  # ── R Basics ────────────────────────────────────────────────────────────────
  "intror"        = "intror/intror",   # [OK]
  "load"          = "load/load",       # [OK]
  "string"        = "string/string",   # [OK]
  "regex"         = "regex/regex",     # [OK]
  "table"         = "table/table",     # [OK]
  "whyr"          = "whyr/whyr",       # [OK]
  
  # ── Data Visualisation ───────────────────────────────────────────────────────
  "introviz"      = "introviz/introviz", # [OK]
  "dviz"          = "dviz/dviz",         # [OK]
  "gviz"          = "introviz/introviz", # [ALIAS → introviz (retired)]
  
  # ── Statistics ───────────────────────────────────────────────────────────────
  "dstats"        = "descriptivestats_tutorial/descriptivestats_tutorial", # [RENAMED]
  "basicstatz"    = "basicstatz/basicstatz", # [OK]
  "regression"    = "regression/regression", # [OK]
  "tree"          = "tree/tree",             # [OK]
  "clust"         = "clust/clust",           # [OK]
  "dimred"        = "dimred/dimred",         # [OK]
  "lexsim"        = "lexsim/lexsim",         # [OK]
  "svm"           = "semanticvectors_tutorial/semanticvectors_tutorial", # [RENAMED]
  "pwr"           = "pwr/pwr",               # [OK]
  "laegs"         = "basicstatz/basicstatz", # [ALIAS → basicstatz (retired)]
  
  # ── Text Analytics ───────────────────────────────────────────────────────────
  "introta"       = "introta/introta",       # [OK]
  "textanalysis"  = "textanalysis/textanalysis", # [OK]
  
  # kwics tutorial was DELETED — redirect to concordancing_tutorial
  "kwics"         = "concordancing_tutorial/concordancing_tutorial", # [DELETED→RENAMED]
  "tagging"       = "concordancing_tutorial/concordancing_tutorial", # [ALIAS of kwics → same]
  
  "coll"          = "collocation_tutorial/collocation_tutorial",     # [RENAMED]
  "ngrams"        = "collocation_tutorial/collocation_tutorial",     # [ALIAS → coll renamed]
  "key"           = "key/key",               # [OK]
  "keywords"      = "key/key",               # [ALIAS → key]
  "net"           = "net/net",               # [OK]
  "topic"         = "topic/topic",           # [OK]
  "topicmodels"   = "topic/topic",           # [ALIAS → topic]
  "sentiment"     = "sentiment/sentiment",   # [OK]
  "postag"        = "postag/postag",         # [OK]
  "txtsum"        = "txtsum/txtsum",         # [OK]
  "spellcheck"    = "spellcheck/spellcheck", # [OK]
  "embeddings"    = "embeddings/embeddings", # [OK]
  
  # ── Case Studies ─────────────────────────────────────────────────────────────
  "corplingr"     = "corpuslinguistics_showcase/corpuslinguistics_showcase", # [RENAMED]
  "llr"           = "llr/llr",       # [OK]
  "lex"           = "lex/lex",       # [OK]
  "surveys"       = "surveys/surveys", # [OK]
  "vc"            = "vowelchart/vowelchart", # [OK]
  "litsty"        = "litsty/litsty", # [OK]
  "reinfnlp"      = "reinfnlp/reinfnlp", # [OK]
  "atap_docclass" = "atap_docclass/atap_docclass", # [OK]
  "phylo"         = "tutorials",     # [DELETED → tutorials index]
  
  # ── How-Tos ───────────────────────────────────────────────────────────────────
  "pdf2txt"       = "pdf2txt/pdf2txt",     # [OK]
  "gutenberg"     = "gutenberg/gutenberg", # [OK]
  
  # ── Retired / no direct equivalent ───────────────────────────────────────────
  "webcrawling"   = "tutorials", # [DELETED → tutorials index]
  "motion"        = "tutorials", # [DELETED → tutorials index]
  "base"          = "tutorials"  # [DELETED → tutorials index]
)

for (old_slug in names(tutorials)) {
  new_path <- tutorials[[old_slug]]
  if (grepl("/", new_path)) {
    dest <- paste0(base_new, "/tutorials/", new_path, ".html")
  } else {
    dest <- paste0(base_new, "/", new_path, ".html")
  }
  write_redirect(paste0("docs/", old_slug, ".html"), dest)
}

# ── Section 3: Other old pages ────────────────────────────────────────────────
write_redirect("docs/opening.html", paste0(base_new, "/events.html"))
write_redirect("docs/news.html",    paste0(base_new, "/events.html"))
write_redirect("docs/people.html",  paste0(base_new, "/about.html#directors"))
write_redirect("docs/citing.html",  paste0(base_new, "/about.html#citing"))

# ── Section 4: Old data/resource file URLs ────────────────────────────────────
write_redirect("content/bibliography.bib",
               paste0(base_new, "/about.html"))
write_redirect("resources/stopwords_en.txt",
               paste0(base_new, "/tutorials/topic/topic.html"))

# ── Summary ───────────────────────────────────────────────────────────────────
message(
  "Done! Redirect files written to docs/\n",
  "  Main pages:  7\n",
  "  Tutorials:   ", length(tutorials), "\n",
  "  Other pages: 4\n",
  "  Total:       ", 7 + length(tutorials) + 4, "\n\n",
  "Next steps:\n",
  "  git add docs/\n",
  "  git commit -m 'fix redirects: kwics->concordancing_tutorial, verified all renames'\n",
  "  git push origin master\n"
)