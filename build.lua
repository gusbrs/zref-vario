-- Build script for "zref-vario" package

-- Identify the bundle and module
bundle = ""
module = "zref-vario"

-- Typeset only the .tex files
typesetfiles = {"*.tex"}

-- Three runs
checkruns = 3

-- Don't wrap/truncate lines in test logs
-- See https://tex.stackexchange.com/q/674844#comment1676566_674846
maxprintline = 1000

-- Use dev formats for regression tests
-- See https://tex.stackexchange.com/q/611424
-- But only for pdftexdev and luatexdev, because it is possible to ensure
-- equal .tlgs for luatex and pdftex by using the same font for all engines,
-- but any xetex test with a hyperlink will result in different logs.  So, we
-- can have most tests with two .tlgs and, besides, five engines is probably
-- already overkill.
checkengines = {"pdftex","luatex","xetex","pdftexdev","luatexdev"}
specialformats = specialformats or {}
specialformats.latex = specialformats.latex or { }
specialformats.latex.pdftexdev = { binary = "pdflatex-dev" , format = "" }
specialformats.latex.luatexdev = { binary = "lualatex-dev" , format = "" }
specialformats.latex.xetexdev  = { binary = "xelatex-dev"  , format = "" }

-- Use UTF-8 logs for all engines
asciiengines = {}

-- CTAN upload settings
uploadconfig = {
  version = "0.1.8", -- first line for tagging
  pkg = "zref-vario",
  author = "Gustavo Barros",
  uploader = "Gustavo Barros",
  summary = "Extended LaTeX page cross-references with varioref and zref-clever",
  license = "lppl1.3c",
  ctanPath = "/macros/latex/contrib/zref-vario",
  repository = "https://github.com/gusbrs/zref-vario",
  bugtracker = "https://github.com/gusbrs/zref-vario/issues",
  update = true,
  announcement_file = "ctan-announcement.text",
  note_file = "ctan-note.text",
}

-- Use a dedicated readme for CTAN to meet upload requirements
ctanreadme = "readme-ctan.md"

-- Set version, release date and copyright automatically
tagfiles = {
  "zref-vario.dtx",
  "CHANGELOG.md",
  "build.lua",
  "zref-vario.ins",
  "zref-vario.tex",
  "zref-vario-code.tex"
}

function update_tag(file, content, tagname, tagdate)
  -- Handle release version tag and date.
  local tagname_safe = string.gsub(tagname, "^v", "")
  if string.match(file, "^zref%-vario%.dtx$") then
    content = string.gsub(
      content,
      "\n\\ProvidesExplPackage %{zref%-vario%} %{[^}]+%} %{[^}]+%}\n",
      "\n\\ProvidesExplPackage {zref-vario} {"
      .. tagdate .. "} {" .. tagname_safe .. "}\n"
    )
  elseif string.match(file, "^CHANGELOG%.md$") then
    local url = "https://github.com/gusbrs/zref-vario/compare/"
    content = string.gsub(
      content,
      "(## %[Unreleased%]%(.-)%.%.%.HEAD%)",
      "%1...v" .. tagname_safe .. ") (" .. tagdate .. ")"
    )
    content = string.gsub(
      content,
      "## %[Unreleased%]",
      "## [Unreleased](" .. url .. "v" .. tagname_safe .. "...HEAD)\n\n"
      .. "## [v" .. tagname_safe .. "]"
    )
    -- Handle CTAN release announcement.
    -- The `or ""` is meant to cover the case of the *first* release, for
    -- which there will be no match for that pattern.  It must be done
    -- manually.
    local tagname_safe_escaped = string.gsub(tagname_safe, "%p", "%%%1")
    local announcement = string.match(
      content, "\n(## %[v" .. tagname_safe_escaped .. "%].-\n)## %[v"
    ) or ""
    announcement = string.gsub(
      announcement,
      "## %[v" .. tagname_safe_escaped .. "%]%(https.-%)",
      "## v" .. tagname_safe
    )
    -- File operations based on 'update_file_tag' function of
    -- 'l3build-tagging.lua'.
    local annfile = uploadconfig.announcement_file
    local annfilename = basename(annfile)
    local annpath = dirname(annfile)
    ren(annpath,annfilename,annfilename .. ".bak")
    local af = assert(io.open(annfile,"w"))
    af:write((string.gsub(announcement,"\n",os_newline)))
    af:close()
    rm(annpath,annfilename .. ".bak")
  elseif string.match(file, "^build%.lua$") then
    content = string.gsub(
      content,
      "(\nuploadconfig%s*=%s*%{%s*version%s*=%s*\")[^\"]*(\")",
      "%1" .. tagname_safe .. "%2"
    )
  end
  -- Handle copyright notice.
  if string.match(file, "^zref%-vario%.dtx$") or
     string.match(file, "^zref%-vario%.ins$") or
     string.match(file, "^zref%-vario%.tex$") or
     string.match(file, "^zref%-vario%-code%.tex$") then
    local tagyear = string.match(tagdate, "%d%d%d%d")
    if string.match(content, "Copyright%D-%d%d%d%d%-%d%d%d%d") then
      if not string.find(content, "Copyright%D-%d%d%d%d*%-" .. tagyear) then
        content = string.gsub(
          content,
          "Copyright(%D-)(%d%d%d%d%-)%d%d%d%d",
          "Copyright%1%2" .. tagyear
        )
      end
    else
      if not string.find(content, "Copyright%D-" .. tagyear) then
        content = string.gsub(
          content,
          "Copyright(%D-)(%d%d%d%d)",
          "Copyright%1%2-" .. tagyear
        )
      end
    end
  end
  return content
end

function tag_hook(tagname)
  local tagname_safe = string.gsub(tagname, "^v", "")
  os.execute('git commit -a -m "Step release tag"')
  os.execute('git tag -a -m "" v' .. tagname_safe)
end
