local uf = require('snippets.utils.funcs')
local un = require('snippets.utils.nodes')
local us = require('snippets.utils.snips')
local ls = require('luasnip')
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local r = ls.restore_node

return {
  us.samWr({ trig = '(%a)(%d)' }, {
    d(1, function(_, snip)
      local symbol = snip.captures[1]
      local subscript = snip.captures[2]
      return sn(nil, {
        t(symbol),
        t('_'),
        t(subscript),
      })
    end),
  }),
  us.samWr({ trig = '(.*%))//' }, {
    d(1, function(_, snip)
      local captured = vim.trim(snip.captures[1])
      if captured == nil or not captured:match('%S') then
        return sn(nil, {
          t('\\frac{'),
          i(1),
          t('}{'),
          i(2),
          t('}'),
        })
      end
      local idx = #captured
      local depth = 0
      while idx > 0 do
        local char = captured:sub(idx, idx)
        if char == ')' then
          depth = depth + 1
        elseif char == '(' then
          depth = depth - 1
        end
        if depth == 0 then
          break
        end
        idx = idx - 1
      end
      if depth ~= 0 then
        return sn(nil, {
          t('\\frac{'),
          i(1),
          t('}{'),
          i(2),
          t('}'),
        })
      end
      local numerator = captured:sub(idx + 1, -2)
      local prefix = ''
      if idx > 0 then
        prefix = captured:sub(1, idx - 1)
      end
      return sn(nil, {
        t(prefix),
        t('\\frac{'),
        t(numerator),
        t('}{'),
        i(1),
        t('}'),
      })
    end),
  }),
  us.samWr({ trig = '(\\%w+{%S+})//' }, {
    d(1, function(_, snip)
      return sn(nil, {
        t('\\frac{'),
        t(snip.captures[1]),
        t('}{'),
        i(1),
        t('}'),
      })
    end),
  }),
  us.samWr({ trig = '(\\?%w*_*%w*)//' }, {
    d(1, function(_, snip)
      local numerator = snip.captures[1]
      if numerator == nil or not numerator:match('%S') then
        return sn(nil, {
          t('\\frac{'),
          i(1),
          t('}{'),
          i(2),
          t('}'),
        })
      end
      return sn(nil, {
        t('\\frac{'),
        t(numerator),
        t('}{'),
        i(1),
        t('}'),
      })
    end),
  }),
  -- matrix/vector bold font
  us.samWr({
    trig = ';(%a)',
    priority = 999,
    dscr = 'vector bold math font',
  }, {
    d(1, function(_, snip)
      return sn(nil, {
        t(string.format('\\mathbf{%s}', snip.captures[1])),
      })
    end),
  }),

  us.samW({ trig = '==' }, t('&= ')),
  us.samW({ trig = ':=' }, t('\\coloneqq ')),
  us.msamW({ { trig = '!=' }, { trig = 'neq' } }, t('\\neq ')),
  us.msamW({ { trig = '&= =' }, { trig = 'eq' } }, t('\\equiv ')),
  us.msamW({ { trig = '>=' }, { trig = 'ge' } }, t('\\ge ')),
  us.msamW({ { trig = '<=' }, { trig = 'le' } }, t('\\le ')),
  us.samW({ trig = '<->', priority = 999 }, t('\\leftrightarrow ')),
  us.samW({ trig = '\\le >', priority = 999 }, t('\\Leftrightarrow ')),
  us.samW({ trig = '<--', priority = 999 }, t('\\leftarrow ')),
  us.samW({ trig = '\\le =', priority = 999 }, t('\\Leftarrow ')),
  us.samW({ trig = '-->', priority = 999 }, t('\\rightarrow ')),
  us.samW({ trig = '&= >', priority = 999 }, t('\\Rightarrow ')),
  us.samW({ trig = '->', priority = 998 }, t('\\to ')),
  us.samW({ trig = '<-', priority = 998 }, t('\\gets ')),
  us.samW({ trig = '=>', priority = 998 }, t('\\implies ')),
  us.samW({ trig = '|>' }, t('\\mapsto ')),
  us.samW({ trig = '><' }, t('\\bowtie ')),
  us.samW({ trig = '**' }, t('\\cdot ')),
  us.samW({ trig = 'x<->' }, {
    t('\\xleftrightarrow['),
    i(1),
    t(']{'),
    i(2),
    t('} '),
  }),
  us.samW({ trig = 'x\\le >' }, {
    t('\\xLeftrightarrow['),
    i(1),
    t(']{'),
    i(2),
    t('} '),
    i(),
  }),
  us.samW({ trig = 'x<--' }, {
    t('\\xleftarrow['),
    i(1),
    t(']{'),
    i(2),
    t('} '),
  }),
  us.samW({ trig = 'x\\le =' }, {
    t('\\xLeftarrow['),
    i(1),
    t(']{'),
    i(2),
    t('} '),
  }),
  us.samW({ trig = 'x-->' }, {
    t('\\xrightarrow['),
    i(1),
    t(']{'),
    i(2),
    t('} '),
  }),
  us.samW({ trig = 'x&= >' }, {
    t('\\xRightarrow['),
    i(1),
    t(']{'),
    i(2),
    t('} '),
  }),

  us.samWr({ trig = '%s*_' }, {
    d(1, function()
      local char_after = uf.get_char_after()
      if char_after == '_' or char_after == '{' then
        return sn(nil, { t('_') })
      else
        return sn(nil, { t('_{'), i(1), t('}') })
      end
    end),
  }),
  us.samWr({ trig = '%s*^' }, {
    d(1, function()
      local char_after = uf.get_char_after()
      if char_after == '^' or char_after == '{' then
        return sn(nil, { t('^') })
      else
        return sn(nil, { t('^{'), i(1), t('}') })
      end
    end),
  }),
  us.msamW({ { trig = '>>' }, { trig = 'gg' } }, t('\\gg ')),
  us.msamW({ { trig = '<<' }, { trig = 'll' } }, t('\\ll ')),
  us.msamW({ { trig = '...' }, { trig = 'ldots' } }, t('\\ldots')),
  us.msamW({ { trig = '\\ldots.' }, { trig = 'cdots' } }, t('\\cdots')),
  us.msamW({ { trig = '\\..' }, { trig = 'ddots' } }, t('\\ddots')),
  us.msamW({ { trig = ':..' }, { trig = 'vdots' } }, t('\\vdots')),
  us.msamW({ { trig = '~~' }, { trig = 'sim' } }, t('\\sim ')),
  us.msamW({ { trig = '~=' }, { trig = 'approx' } }, t('\\approx ')),
  us.samW({ trig = '+-' }, t('\\pm ')),
  us.samW({ trig = '-+' }, t('\\mp ')),
  us.samWr({ trig = '%s*||' }, t(' \\mid ')),
  us.samW({ trig = '\\\\\\' }, { t('\\setminus ') }),
  us.samW({ trig = '%%' }, t('\\%')),
  us.samW({ trig = '##' }, t('\\#')),
  us.samW({ trig = ': ' }, t('\\colon ')),
  us.msamW({
    { trig = 'sqrt' },
    { trig = '^{2}rt' },
  }, {
    f(function(_, snip)
      return snip.trigger == '^{2}rt' and ' ' or ''
    end, {}, {}),
    c(1, {
      sn(nil, {
        t('\\sqrt{'),
        r(1, 'expr'),
        t('}'),
      }),
      sn(nil, {
        t('\\sqrt['),
        i(2, '3'),
        t(']{'),
        r(1, 'expr'),
        t('}'),
      }),
    }),
  }, {
    stored = {
      expr = i(1),
    },
  }),

  us.samW({ trig = 'abs' }, { t('\\left\\vert '), i(1), t(' \\right\\vert') }),
  us.samW({ trig = 'lrv' }, { t('\\left\\vert '), i(1), t(' \\right\\vert') }),
  us.samW({ trig = 'lrb' }, { t('\\left('), i(1), t('\\right)') }),
  us.samW({ trig = 'lr)' }, { t('\\left('), i(1), t('\\right)') }),
  us.samW({ trig = 'lr]' }, { t('\\left['), i(1), t('\\right]') }),
  us.samW({ trig = 'lrB' }, { t('\\left{'), i(1), t('\\right}') }),
  us.samW({ trig = 'lr}' }, { t('\\left{'), i(1), t('\\right}') }),
  us.samW({ trig = 'lr>' }, { t('\\left<'), i(1), t('\\right>') }),
  us.samW(
    { trig = 'nor' },
    { t('\\left\\lVert '), i(1), t(' \\right\\lVert') }
  ),

  us.sambWr({ trig = '%s*ks' }, t('^{*}')),
  us.sambWr({ trig = '%s*sq' }, t('^{2}')),
  us.sambWr({ trig = '%s*cb' }, t('^{3}')),
  us.sambWr({ trig = '%s*inv' }, t('^{-1}')),
  us.sambWr({ trig = '%s*cm' }, t('^{C}')),
  us.sambWr({ trig = '%s*tr' }, t('^{\\intercal}')),

  us.samWr({ trig = '(\\?%w*_*%w*)vv' }, un.sdn(1, '\\vec{', '}')),
  us.samWr({ trig = '(\\?%w*_*%w*)hat' }, un.sdn(1, '\\hat{', '}')),
  us.samWr({ trig = '(\\?%w*_*%w*)bar' }, un.sdn(1, '\\bar{', '}')),
  us.samWr({ trig = '(\\?%w*_*%w*)td' }, un.sdn(1, '\\tilde{', '}')),
  us.samWr({ trig = '(\\?%w*_*%w*)ovl' }, un.sdn(1, '\\overline{', '}')),
  us.samWr({ trig = '(\\?%w*_*%w*)ovs' }, {
    d(1, function(_, snip)
      local text = snip.captures[1]
      if text == nil or not text:match('%S') then
        return sn(nil, {
          t('\\overset{'),
          i(2),
          t('}{'),
          i(1),
          t('}'),
        })
      end
      return sn(nil, {
        t('\\overset{'),
        i(1),
        t('}{'),
        t(text),
        t('}'),
      })
    end),
  }),

  -- matrix/vector
  us.sam(
    { trig = 'rv', dscr = 'row vector', priority = 999 },
    un.fmtad(
      '\\begin{bmatrix} <el><_>{0<mod>} & <el><_>{1<mod>} & \\ldots & <el><_>{<end_idx><mod>} \\end{bmatrix}',
      {
        _ = i(3, '_'),
        el = i(1, 'a'),
        end_idx = i(2, 'N-1'),
        mod = i(4),
      }
    )
  ),
  us.sam(
    { trig = 'cv', dscr = 'column vector' },
    un.fmtad(
      '\\begin{bmatrix} <el><_>{0<mod>} \\\\ <el><_>{1,<mod>} \\\\ \\vdots \\\\ <el><_>{<end_idx><mod>} \\end{bmatrix}',
      {
        _ = i(3, '_'),
        el = i(1, 'a'),
        end_idx = i(2, 'N-1'),
        mod = i(4),
      }
    )
  ),
  us.sam(
    { trig = 'mt', dscr = 'matrix' },
    un.fmtad(
      [[
        \begin{bmatrix}
        <idnt><el><_>{<row0><comma><col0>} & <el><_>{<row0><comma><col1>} & \ldots & <el><_>{<row0><comma><width>} \\
        <idnt><el><_>{<row1><comma><col0>} & <el><_>{<row1><comma><col1>} & \ldots & <el><_>{<row1><comma><width>} \\
        <idnt>\vdots & \vdots & \ddots & \vdots \\
        <idnt><el><_>{<height><comma>0} & <el><_>{<height><comma>1} & \ldots & <el><_>{<height><comma><width>} \\
        \end{bmatrix}
      ]],
      {
        idnt = un.idnt(1),
        el = i(1, 'a'),
        _ = i(8, '_'),
        height = i(2, 'N-1'),
        width = i(3, 'M-1'),
        row0 = i(4, '0'),
        col0 = i(5, '0'),
        row1 = i(6, '1'),
        col1 = i(7, '1'),
        comma = i(9, ','),
      }
    )
  ),
  us.msam({
    { trig = 'prop' },
    { trig = 'oc' },
  }, t('\\propto ')),
  us.sam({ trig = 'deg' }, t('\\degree')),
  us.sam({ trig = 'ang' }, t('\\angle ')),
  us.sam({ trig = 'mcal' }, { t('\\mathcal{'), i(1), t('}') }),
  us.sam({ trig = 'msrc' }, { t('\\mathsrc{'), i(1), t('}') }),
  us.sam({ trig = 'mbb' }, { t('\\mathbb{'), i(1), t('}') }),
  us.sam({ trig = 'mbf' }, { t('\\mathbf{'), i(1), t('}') }),
  us.sam({ trig = 'mff' }, { t('\\mff{'), i(1), t('}') }),
  us.sam({ trig = 'mrm' }, { t('\\mathrm{'), i(1), t('}') }),
  us.sam({ trig = 'mit' }, { t('\\mathit{'), i(1), t('}') }),
  us.sam({ trig = 'xx' }, t('\\times ')),
  us.sam({ trig = 'o*' }, t('\\circledast ')),
  us.sam({ trig = 'dd' }, t('\\mathrm{d}')),
  us.sam({ trig = 'pp' }, t('\\partial ')),
  us.msam({ { trig = 'DD' }, { trig = 'Dd' } }, t('\\Delta ')),
  us.msam({ { trig = 'oo' }, { trig = '\\in f' } }, t('\\infty')),

  us.sam({ trig = 'set' }, { t('\\{'), i(1), t('\\}') }),
  us.sam({ trig = 'void' }, t('\\emptyset')),
  us.sam({ trig = 'emptyset' }, t('\\emptyset')),
  us.sam({ trig = 'tt' }, { t('\\text{'), i(1), t('}') }),
  us.sam({ trig = 'cc' }, t('\\subset ')),
  us.sam({ trig = ']c' }, t('\\sqsubset ')),
  us.samr({ trig = '\\subset%s*=' }, t('\\subseteq ')),
  us.samr({ trig = '\\subset%s*eq' }, t('\\subseteq ')),
  us.samr({ trig = '\\sqsubset%s*=' }, t('\\sqsubseteq ')),
  us.samr({ trig = '\\sqsubset%s*eq' }, t('\\sqsubseteq ')),
  us.sam({ trig = 'c=' }, t('\\subseteq ')),
  us.sam({ trig = 'notin' }, t('\\notin ')),
  us.sam({ trig = 'in', priority = 999 }, t('\\in ')),
  us.sam({ trig = 'uu' }, t('\\cup ')),
  us.sam({ trig = 'nn' }, t('\\cap ')),
  us.sam({ trig = 'land' }, t('\\land ')),
  us.sam({ trig = 'lor' }, t('\\lor ')),
  us.sam({ trig = 'neg' }, t('\\neg ')),
  us.sam({ trig = 'bigv' }, t('\\big\\rvert_{'), i(1), t('}')),
  us.sam({ trig = 'forall' }, t('\\forall ')),
  us.sam({ trig = 'any' }, t('\\forall ')),
  us.sam({ trig = 'exists' }, t('\\exists ')),

  us.sam({ trig = 'log' }, {
    t('\\mathrm{log}_{'),
    i(1, '10'),
    t('}\\left('),
    i(2),
    t('\\right)'),
  }),
  us.sam({ trig = 'lg', priority = 999 }, {
    t('\\mathrm{lg}'),
    t('\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'ln', priority = 999 }, {
    t('\\mathrm{ln}'),
    t('\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'argmin' }, {
    t('\\mathrm{argmin}_{'),
    i(1),
    t('}'),
  }),
  us.sam({ trig = 'argmax' }, {
    t('\\mathrm{argamx}_{'),
    i(1),
    t('}'),
  }),
  us.sam(
    { trig = 'min', priority = 999 },
    c(1, {
      sn(nil, {
        t('\\mathrm{min}'),
        t('\\left('),
        r(1, 'expr'),
        t('\\right)'),
      }),
      sn(nil, {
        t('\\mathrm{min}_{'),
        i(2),
        t('}'),
        t('\\left('),
        r(1, 'expr'),
        t('\\right)'),
      }),
    }),
    {
      stored = {
        expr = i(1),
      },
    }
  ),
  us.sam(
    { trig = 'max', priority = 999 },
    c(1, {
      sn(nil, {
        t('\\mathrm{max}'),
        t('\\left('),
        r(1, 'expr'),
        t('\\right)'),
      }),
      sn(nil, {
        t('\\mathrm{max}_{'),
        i(2),
        t('}'),
        t('\\left('),
        r(1, 'expr'),
        t('\\right)'),
      }),
    }),
    {
      stored = {
        expr = i(1),
      },
    }
  ),

  us.sam({ trig = 'sin', priority = 999 }, {
    t('\\mathrm{sin}\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'cos', priority = 999 }, {
    t('\\mathrm{cos}\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'tan', priority = 999 }, {
    t('\\mathrm{tan}\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'asin' }, {
    t('\\mathrm{arcsin}\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'acos' }, {
    t('\\mathrm{arccos}\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'atan' }, {
    t('\\mathrm{arctan}\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'sc' }, {
    t('\\mathrm{sinc}\\left('),
    i(1),
    t('\\right)'),
  }),
  us.sam({ trig = 'exp' }, {
    t('\\mathrm{exp}\\left('),
    i(1),
    t('\\right)'),
  }),

  us.sam({ trig = 'flr' }, {
    t('\\left\\lfloor '),
    i(1),
    t(' \\right\\rfloor'),
  }),
  us.sam({ trig = 'clg' }, {
    t('\\left\\lceil '),
    i(1),
    t(' \\right\\rceil'),
  }),
  us.sam({ trig = 'bmat' }, {
    t('\\begin{bmatrix} '),
    i(1),
    t(' \\end{bmatrix}'),
  }),
  us.sam({ trig = 'pmat' }, {
    t('\\begin{pmatrix} '),
    i(1),
    t(' \\end{pmatrix}'),
  }),
  us.sam({ trig = 'Bmat' }, {
    t({ '\\begin{bmatrix}', '' }),
    un.idnt(1),
    i(1),
    t({ '', '\\end{bmatrix}' }),
  }),
  us.sam({ trig = 'Pmat' }, {
    t({ '\\begin{pmatrix}', '' }),
    un.idnt(1),
    i(1),
    t({ '', '\\end{pmatrix}' }),
  }),
  us.sam(
    { trig = 'aln' },
    c(1, {
      un.fmtad(
        [[
        \begin{<env>}
        <idnt><text>
        \end{<env>}
        ]],
        {
          env = t('aligned'),
          idnt = un.idnt(1),
          text = r(1, 'text'),
        }
      ),
      un.fmtad(
        [[
        \begin{<env>}
        <idnt><text>
        \end{<env>}
        ]],
        {
          env = t('align*'),
          idnt = un.idnt(1),
          text = r(1, 'text'),
        }
      ),
      un.fmtad(
        [[
        \begin{<env>}
        <idnt><text>
        \end{<env>}
        ]],
        {
          env = t('align'),
          idnt = un.idnt(1),
          text = r(1, 'text'),
        }
      ),
    }),
    {
      stored = {
        text = i(1),
      },
    }
  ),
  us.sam(
    { trig = 'eqt' },
    c(1, {
      un.fmtad(
        [[
        \begin{<env>}
        <idnt><text>
        \end{<env>}
        ]],
        {
          env = t('equation'),
          idnt = un.idnt(1),
          text = r(1, 'text'),
        }
      ),
      un.fmtad(
        [[
        \begin{<env>}
        <idnt><text>
        \end{<env>}
        ]],
        {
          env = t('equation*'),
          idnt = un.idnt(1),
          text = r(1, 'text'),
        }
      ),
    }),
    {
      stored = {
        text = i(1),
      },
    }
  ),
  us.sam({ trig = 'case' }, {
    t({ '\\begin{cases}', '' }),
    un.idnt(1),
    i(0),
    t({ '', '\\end{cases}' }),
  }),
  us.sam({ trig = 'part' }, {
    t('\\frac{\\partial '),
    i(1),
    t('}{\\partial '),
    i(2),
    t('}'),
  }),
  us.sam({ trig = 'diff' }, {
    t('\\frac{\\mathrm{d}'),
    i(1),
    t('}{\\mathrm{d}'),
    i(2),
    t('} '),
  }),
  us.sam({
    trig = '\\in t',
    priority = 998,
  }, {
    t('\\int_{'),
    i(1),
    t('}^{'),
    i(2),
    t('} '),
  }),
  us.sam({
    trig = 'iint',
    priority = 999,
  }, {
    t('\\iint_{'),
    i(1),
    t('}^{'),
    i(2),
    t('} '),
  }),
  us.sam({
    trig = 'iiint',
  }, {
    t('\\iiint_{'),
    i(1),
    t('}^{'),
    i(2),
    t('} '),
  }),
  us.sam({ trig = 'prod' }, {
    c(1, {
      sn(nil, {
        t('\\prod \\limits_{'),
        i(1, 'n=0'),
        t('}^{'),
        i(2, 'N-1'),
        t('} '),
      }),
      sn(nil, {
        t('\\prod \\limits_{'),
        i(1, 'x'),
        t('} '),
      }),
    }),
  }),
  us.sam({ trig = 'sum' }, {
    c(1, {
      sn(nil, {
        t('\\sum \\limits_{'),
        i(1, 'n=0'),
        t('}^{'),
        i(2, 'N-1'),
        t('} '),
      }),
      sn(nil, {
        t('\\sum \\limits_{'),
        i(1, 'x'),
        t('} '),
      }),
    }),
  }),
  us.sam({ trig = 'lim' }, {
    t('\\lim_{'),
    i(1, 'n'),
    t('\\to '),
    i(2, '\\infty'),
    t('} '),
  }),
  us.sam(
    { trig = 'env' },
    un.fmtad(
      [[
        \begin{<env>}
        <idnt><text>
        \end{<env>}
      ]],
      {
        idnt = un.idnt(1),
        env = i(1),
        text = i(0),
      }
    )
  ),

  us.sam({ trig = 'nabla' }, t('\\nabla')),
  us.sam({ trig = 'alpha' }, t('\\alpha')),
  us.sam({ trig = 'beta' }, t('\\beta')),
  us.sam({ trig = 'gamma' }, t('\\gamma')),
  us.sam({ trig = 'delta' }, t('\\delta')),
  us.sam({ trig = 'zeta' }, t('\\zeta')),
  us.sam({ trig = 'mu' }, t('\\mu')),
  us.sam({ trig = 'rho' }, t('\\rho')),
  us.sam({ trig = 'sigma' }, t('\\sigma')),
  us.sam({ trig = 'eta', priority = 998 }, t('\\eta')),
  us.sam({ trig = 'eps', priority = 999 }, t('\\epsilon')),
  us.sam({ trig = 'veps' }, t('\\varepsilon')),
  us.sam({ trig = 'theta', priority = 999 }, t('\\theta')),
  us.sam({ trig = 'vtheta' }, t('\\vartheta')),
  us.sam({ trig = 'iota' }, t('\\iota')),
  us.sam({ trig = 'kappa' }, t('\\kappa')),
  us.sam({ trig = 'lambda' }, t('\\lambda')),
  us.sam({ trig = 'nu' }, t('\\nu')),
  us.sam({ trig = 'pi' }, t('\\pi')),
  us.sam({ trig = 'tau' }, t('\\tau')),
  us.sam({ trig = 'ups' }, t('\\upsilon')),
  us.sam({ trig = 'phi' }, t('\\phi')),
  us.sam({ trig = 'vphi' }, t('\\varphi')),
  us.sam({ trig = 'psi' }, t('\\psi')),
  us.sam({ trig = 'omg' }, t('\\omega')),

  us.sam({ trig = 'Alpha' }, t('\\Alpha')),
  us.sam({ trig = 'Beta' }, t('\\Beta')),
  us.sam({ trig = 'Gamma' }, t('\\Gamma')),
  us.sam({ trig = 'Delta' }, t('\\Delta')),
  us.sam({ trig = 'Zeta' }, t('\\Zeta')),
  us.sam({ trig = 'Mu' }, t('\\Mu')),
  us.sam({ trig = 'Rho' }, t('\\Rho')),
  us.sam({ trig = 'Sigma' }, t('\\Sigma')),
  us.sam({ trig = 'Eta' }, t('\\Eta')),
  us.sam({ trig = 'Eps' }, t('\\Epsilon')),
  us.sam({ trig = 'Theta' }, t('\\Theta')),
  us.sam({ trig = 'Iota' }, t('\\Iota')),
  us.sam({ trig = 'Kappa' }, t('\\Kappa')),
  us.sam({ trig = 'Lambda' }, t('\\Lambda')),
  us.sam({ trig = 'Nu' }, t('\\Nu')),
  us.sam({ trig = 'Pi' }, t('\\Pi')),
  us.sam({ trig = 'Tau' }, t('\\Tau')),
  us.sam({ trig = 'Ups' }, t('\\Upsilon')),
  us.sam({ trig = 'Phi' }, t('\\Phi')),
  us.sam({ trig = 'Psi' }, t('\\Psi')),
  us.sam({ trig = 'Omg' }, t('\\Omega')),

  -- special functions and other notations
  us.sam({ trig = 'Cov' }, {
    t('\\mathrm{Cov}\\left('),
    i(1, 'X'),
    t(','),
    i(2, 'Y'),
    t('\\right)'),
  }),
  us.sam({ trig = 'Var' }, {
    t('\\mathrm{Var}\\left('),
    i(1, 'X'),
    t('\\right)'),
  }),
  us.sam({ trig = 'MSE' }, { t('\\mathrm{MSE}') }),
  us.sam(
    {
      trig = 'bys',
      dscr = 'Bayes Formula',
    },
    un.fmtad(
      '\\frac{P(<cond_x> \\mid <cond_y>) P(<cond_y>)}{P(<cond_y>)}',
      { cond_x = i(2, 'X=x'), cond_y = i(1, 'Y=y') }
    )
  ),
  us.sam(
    {
      trig = 'nord',
      dscr = 'Normal Distribution',
    },
    un.fmtad(
      '\\mathcal{N} \\left(<mean>, <var>\\right)',
      { mean = i(1, '\\mu'), var = i(2, '\\sigma^2') }
    )
  ),

  -- Math env
  us.sa({
    trig = '$',
    condition = function()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      if line:sub(col + 1, col + 1) == '$' then
        vim.api.nvim_set_current_line(line:sub(1, -2))
        return true
      end
      return false
    end,
  }, {
    t({ '$', '' }),
    un.idnt(1),
    i(1),
    t({ '', '$$' }),
  }),
  us.sa({
    trig = '$$',
    priority = 999,
  }, {
    t('$'),
    i(0),
    t('$'),
  }),
}
