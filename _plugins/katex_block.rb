require 'execjs'
require 'cgi'

module Jekyll
    module Tags
        class KatexBlock < Liquid::Block

            def initialize(tag, markup, tokens)
                super
                @tag = tag
                @tokens = tokens
                @markup = markup

                @centred = markup.include? 'centred'

                path_to_katex = "./public/js/katex.min.js"
                katexsrc = open(path_to_katex).read
                @katex = ExecJS.compile(katexsrc)
            end

            def render(context)
                if @centred
                    return katexify_centred(super)
                end
                katexify_inline(super)
            end

            def katexify_inline(content)
                eqn_to_html(content)
            end

            def katexify_centred(content)
                style = "text-align: center;"
                div_open = "<span class='centredequation'>"
                div_close = "</span>"

                s = "\\displaystyle " + content

                return div_open + eqn_to_html(s) + div_close
            end

            def eqn_to_html(string)
                return @katex.call("katex.renderToString", string)
            end
        end
    end
end

Liquid::Template.register_tag('latex', Jekyll::Tags::KatexBlock)
