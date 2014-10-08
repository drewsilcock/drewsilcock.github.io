require 'execjs'

module Jekyll
    class KatexConverter < Converter
        safe false
        priority :high

        def matches(ext)
            ext =~ /^\.md$/i
        end

        def output_ext(ext)
            ".html"
        end

        def convert(content)
            content = katexify(content)

            site = Jekyll::Site.new(@config)
            mkconverter = site.getConverterImpl(Jekyll::Converters::Markdown)
            mkconverter.convert(content)
        end

        @@inlinematch = /\\\((.+?)\\\)/
        @@centredmatch = /\\\[(.+?)\\\]/

        path_to_katex = "./public/js/katex.min.js"
        katexsrc = open(path_to_katex).read
        @@katex = ExecJS.compile(katexsrc)

        def katexify(content)
            content = content.gsub(@@inlinematch) { match_inline($1) }
            content = content.gsub(@@centredmatch) { match_centred($1) }

            return content
        end

        def eqn_to_html(string)
            return @@katex.call("katex.renderToString", string)
        end

        def match_inline(match)
            return eqn_to_html(match)
        end

        def match_centred(match)
            s = "\\displaystyle " + match
            div_open = "<div style='text-align: center; margin-top: 0.5em; margin-bottom: 0.5em;'>"
            div_close = "</div>"

            return div_open + eqn_to_html(s) + div_close
        end
    end
end
