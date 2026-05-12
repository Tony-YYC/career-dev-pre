#import "@preview/touying:0.6.1": *
#import "@preview/cetz:0.4.2"
#import "@preview/fletcher:0.5.8" as fletcher: edge, node
#import "../lib.typ": *

#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#set text(lang: "zh")
#set par(leading: 0.8em, justify: true)
#show: sjtu-theme.with(
  aspect-ratio: "16-9",
  navigation: "mini-slides",
  footer: self => self.info.institution,
  config-info(
    title: [Generate 的"事"],
    subtitle: [从发现药物到生成药物],
    author: [职业发展课 · 案例分析 Pre],
    date: datetime.today(),
    institution: [Generate Biomedicines（NASDAQ: GENB）案例分析],
  ),
  config-common(slide-level: 2),
)

// ============================================================
// 颜色与小工具
// ============================================================
#let c-primary = rgb("#C9141E")
#let c-accent = rgb("#0C4842")
#let c-amber = rgb("#E8A33D")
#let c-blue = rgb("#315C9D")
#let c-gray = rgb("#666666")
#let c-light = rgb("#F4F4F4")

#let card(title, body, color: c-primary, fill-light: 92%) = block(
  width: 100%,
  inset: 0.72em,
  radius: 6pt,
  fill: color.lighten(fill-light),
  stroke: (left: 3pt + color),
  {
    set par(justify: false, leading: 0.65em)
    text(size: 1.0em, weight: "bold", fill: color, title)
    v(0.35em)
    text(size: 0.9em, fill: rgb("#222222"), body)
  },
)

#let stat(label, value, sub: none, color: c-primary) = block(
  width: 100%,
  inset: 0.8em,
  radius: 6pt,
  fill: color.lighten(90%),
  stroke: (left: 4pt + color),
  {
    set par(justify: false, leading: 0.55em)
    text(size: 0.9em, fill: c-gray, label)
    v(0.35em)
    text(size: 1.5em, weight: "bold", fill: color, value)
    if sub != none {
      v(0.25em)
      text(size: 0.9em, fill: c-gray, sub)
    }
  },
)

#let pill(body, color: c-primary) = box(
  inset: (x: 0.7em, y: 0.24em),
  radius: 99pt,
  fill: color.lighten(88%),
  stroke: 0.5pt + color,
  text(size: 0.78em, weight: "bold", fill: color, body),
)

#let mini-arrow(label, color: c-primary) = block(
  inset: 0.55em,
  radius: 4pt,
  fill: color.lighten(88%),
  stroke: 0.6pt + color,
  text(size: 0.82em, weight: "bold", fill: color, label),
)

#let source-note(body) = text(size: 0.8em, fill: c-gray, body)

// ============================================================
// 标题页
// ============================================================
#title-slide-red()

= 事

== Generate Biomedicines：从"发现药物"到"生成药物"

#v(0.2em)

#align(center, fletcher-diagram(
  node-stroke: 0.6pt,
  node-corner-radius: 5pt,
  node-inset: 0.58em,
  spacing: (2.05em, 0.8em),
  node((0, 0), text(1em)[*科学创始人* \ Grigoryan], fill: c-accent.lighten(88%), stroke: c-accent),
  node((1, 0), text(1em)[*平台闭环* \ DBTL], fill: c-primary.lighten(90%), stroke: c-primary),
  node((2, 0), text(1em)[*Chroma* \ 蛋白生成], fill: c-amber.lighten(86%), stroke: c-amber),
  node((3, 0), text(1em)[*管线验证* \ anti-TSLP抗体], fill: c-blue.lighten(86%), stroke: c-blue),
  node((4, 0), text(1em)[*外部验证* \ 论文 · 专利 · 合作], fill: c-light, stroke: c-gray),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((3, 0), (4, 0), "->"),
))

#v(0.8em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  stat([公司定位], [Generative Biology], sub: [用机器学习 + 生物工程生成蛋白药物], color: c-accent),
  stat([核心竞争力], [Generate平台], sub: [Generate 卖的是通过平台持续产生候选药物的能力], color: c-primary),
  stat([验证路径], [模型生成→临床试验], sub: [从 Chroma 到 GB-0895 Phase 3], color: c-amber),
)

== 本部分要回答的三个问题

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 1em,
  card(
    [① 科学起点是谁？],
    [为什么 Generate 有资格讲"AI 蛋白设计"？
    \ 科学创始人的背景如何连接到公司平台？],
    color: c-accent,
  ),
  move(
    dy: 6em,
    card(
      [② 平台如何工作？],
      [Generate Platform 与传统筛选式药物发现有什么不同？
      \ Chroma 能生成什么？],
      color: c-primary,
    )
  ),
  move(
    dy: 10em,
    card(
      [③ 是否被验证？],
      [论文、专利、临床管线和大药企合作，
      \ 能否共同形成一条证据链？],
      color: c-amber,
    )
  ),
)

== 科学创始人：Gevorg Grigoryan

#grid(
  columns: (0.72fr, 1.28fr),
  column-gutter: 1.2em,
  align(center, image("../input/affair/assets/image1.png", height: 10.0cm)),
  block({
    text(size: 1.05em, weight: "bold", [Co-Founder & Chief Technology Officer])
    v(0.35em)
    text(size: 0.88em)[
      Gevorg Grigoryan 是 Generate 的核心科学源头，负责 Generate Platform 的发展；他的研究长期围绕*计算蛋白设计、机器学习、蛋白结构-功能关系*展开。
    ]
    v(0.6em)
    grid(
      columns: (1fr, 1fr),
      column-gutter: 0.7em,
      row-gutter: 0.55em,
      mini-arrow([计算蛋白设计], color: c-accent),
      mini-arrow([蛋白互作网络], color: c-primary),
      mini-arrow([结构-功能编码], color: c-amber),
      mini-arrow([机器学习建模], color: c-blue),
    )
    v(0.7em)
    block(
      inset: 0.7em,
      radius: 5pt,
      fill: c-light,
      stroke: (left: 3pt + c-gray),
      text(size: 0.85em)[
        Grigoryan在计算生物学方向上的工作奠定了Generate平台的基础：\
        #text(fill: c-gray)[
          AI模型负责学习蛋白结构与功能间的关系，再由人类湿实验验证
        ]
      ],
    )
  }),
)

== 公司主要做什么：生成式蛋白药物设计

#grid(
  columns: (0.65fr, 1fr),
  column-gutter: 1.2em,
  block({
    text(size: 1.0em, weight: "bold", [Generate 的主营业务不是"找到一个药"，而是搭建一个生成平台])
    v(0.4em)
    text(size: 0.9em)[
      平台把 AI 模型、高通量实验、生物工程和临床转化串联起来，用于设计不同形式的蛋白药物。
    ]
    v(0.45em)
    text(size: 0.86em)[
      - *输入*：疾病靶点、目标结构、功能约束、药物属性
      - *生成*：抗体、酶、蛋白复合物、细胞治疗相关蛋白
      - *验证*：表达、折叠、亲和力、稳定性、体内外功能
      - *应用*：免疫炎症、肿瘤等治疗方向
    ]
  }),
  cetz-canvas(length: 1.4cm, {
    import cetz.draw: *
    let box-node(pos, label, color) = {
      rect((pos.at(0) - 1.75, pos.at(1) - 0.48), (pos.at(0) + 1.75, pos.at(1) + 0.48), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
      content(pos, text(0.72em, weight: "bold", fill: color, label))
    }
    box-node((0, 3), [治疗目标], c-accent)
    box-node((4, 3), [AI 生成], c-primary)
    box-node((8, 3), [蛋白候选物], c-amber)
    box-node((4, 0.8), [实验反馈], c-blue)
    line((1.75, 3), (2.25, 3), mark: (end: ">"), stroke: 1pt + c-gray)
    line((5.75, 3), (6.25, 3), mark: (end: ">"), stroke: 1pt + c-gray)
    line((7.6, 2.55), (5.6, 1.2), mark: (end: ">"), stroke: 0.8pt + c-blue)
    line((2.4, 1.2), (0.6, 2.55), mark: (end: ">"), stroke: 0.8pt + c-blue)
    content((4, 4.45), text(0.8em, fill: c-primary, weight: "bold")[蛋白药物生成工厂])
  }),
)

== 为什么要这样做：传统药物发现的瓶颈

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.1em,
  block({
    text(weight: "bold", fill: c-gray, [传统发现：筛选和优化])
    v(0.4em)
    fletcher-diagram(
      node-stroke: 0.6pt,
      node-corner-radius: 4pt,
      node-inset: 0.72em,
      spacing: (2.0em, 0.8em),
      node((0, 0), text(0.72em)[已有分子库\ 抗体库], fill: c-light),
      node((1, 0), text(0.72em)[筛选], fill: c-light),
      node((2, 0), text(0.72em)[多轮优化], fill: c-light),
      node((3, 0), text(0.72em)[候选药物], fill: c-light),
      edge((0, 0), (1, 0), "->"),
      edge((1, 0), (2, 0), "->"),
      edge((2, 0), (3, 0), "->"),
    )
    v(0.6em)
    text(size: 0.84em)[
      - 有效，但受限于已有分子库
      - 面对复杂靶点时，搜索空间不够大
      - 周期长，反复试错成本高。
    ]
  }),
  block({
    text(weight: "bold", fill: c-primary, [Generate：按目标生成])
    v(0.4em)
    fletcher-diagram(
      node-stroke: 0.6pt,
      node-corner-radius: 4pt,
      node-inset: 0.72em,
      spacing: (2.0em, 0.8em),
      node((0, 0), text(0.72em)[目标条件\ 药物属性], fill: c-accent.lighten(88%), stroke: c-accent),
      node((1, 0), text(0.72em)[AI 生成], fill: c-primary.lighten(90%), stroke: c-primary),
      node((2, 0), text(0.72em)[高通量验证], fill: c-amber.lighten(86%), stroke: c-amber),
      node((3, 0), text(0.72em)[模型学习], fill: c-blue.lighten(88%), stroke: c-blue),
      edge((0, 0), (1, 0), "->"),
      edge((1, 0), (2, 0), "->"),
      edge((2, 0), (3, 0), "->"),
    )
    v(0.6em)
    text(size: 0.84em)[
      - 从目标功能出发生成蛋白
      - 理论上能探索更大的蛋白空间
      - 可以缩短从设计到候选分子的迭代路径。
    ]
  }),
)

== Generate Platform：Design–Build–Test–Learn 闭环

#grid(
  columns: (1.15fr, 0.85fr),
  column-gutter: 1.2em,
  cetz-canvas(length: 1.6cm, {
    import cetz.draw: *
    let center = (4, 3)
    let node(pos, label, sub, color) = {
      circle(pos, radius: 0.9, fill: color.lighten(88%), stroke: 0.8pt + color)
      content(pos, text(0.72em, weight: "bold", fill: color, label + [\ ] + text(0.62em, weight: "regular", fill: c-gray, sub)))
    }
    node((4, 5.4), [Design], [AI 模型], c-primary)
    node((7.2, 3), [Build], [DNA / 表达], c-amber)
    node((4, 0.6), [Test], [高通量实验], c-blue)
    node((0.8, 3), [Learn], [数据回流], c-accent)
    circle(center, radius: 1.15, fill: c-primary, stroke: none)
    content(center, text(0.82em, fill: white, weight: "bold")[Living\ Feedback\ Loop])
    line((4.65, 4.85), (6.55, 3.65), mark: (end: ">"), stroke: 1pt + c-gray)
    line((6.55, 2.35), (4.65, 1.15), mark: (end: ">"), stroke: 1pt + c-gray)
    line((3.35, 1.15), (1.45, 2.35), mark: (end: ">"), stroke: 1pt + c-gray)
    line((1.45, 3.65), (3.35, 4.85), mark: (end: ">"), stroke: 1pt + c-gray)
  }),
  block({
    text(weight: "bold", [技术核心是 AI设计 + 湿实验验证])
    v(0.45em)
    text(size: 0.88em)[
      - 模型先提出设计方案
      - 实验系统把设计做出来
      - 高通量检测给出真实数据
      - 数据再反哺下一轮模型
    ]
    v(0.7em)
    block(
      inset: 0.7em,
      radius: 5pt,
      fill: c-primary.lighten(93%),
      stroke: (left: 3pt + c-primary),
      text(size: 0.86em, fill: c-primary)[
        招股书中声称，Generate平台通过整合DBTL循环
        搭建起了数据和技术的双重壁垒
      ],
    )
  }),
)

== 核心模型 Chroma：可编程蛋白生成

#grid(
  columns: (1.2fr, 0.6fr),
  column-gutter: 1em,
  block({
    align(center, image("../input/affair/assets/image3.png", width: 100%))
    v(0.25em)
    source-note([Chroma 论文机制图：扩散生成蛋白骨架，再由设计网络输出全原子结构。])
  }),
  block({
    text(weight: "bold", [Chroma 的关键词：programmable])
    v(0.45em)
    text(size: 0.86em)[
      Chroma 基于扩散模型与图神经网络，能够生成蛋白结构和序列，并接受条件约束。
    ]
    v(5em)
    block(
      inset: 0.7em,
      radius: 5pt,
      fill: c-primary.lighten(90%),
      stroke: (left: 3pt + c-primary),
      text(size: 0.82em)[
        "Chroma可以在对称性、形状、结构/基序的条件约束下生成蛋白，甚至可以接受自然语言Prompt。"
      ],
    )
  }),
)

== 产品管线：平台不是只停留在论文，正在向临床进展

#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
  stroke: 0.5pt + c-gray,
  align: (left, center, center, center, center),
  inset: 0.42em,
  table.header(
    text(0.8em, weight: "bold")[项目],
    text(0.8em, weight: "bold")[方向],
    text(0.8em, weight: "bold")[Preclinical],
    text(0.8em, weight: "bold")[Phase 1],
    text(0.8em, weight: "bold")[Phase 3],
  ),
  text(0.8em, weight: "bold")[GB-0895], text(0.78em)[重度哮喘\ anti-TSLP],
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-primary.lighten(84%), radius: 2pt, inset: 0.25em, text(fill: c-primary, weight: "bold")[Phase 3]),
  text(0.8em, weight: "bold")[GB-4362], text(0.78em)[MMAE payload\ neutralizer],
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-amber.lighten(82%), radius: 2pt, inset: 0.25em, text(fill: c-amber, weight: "bold")[2026]),
  [],
  text(0.8em, weight: "bold")[GB-5267], text(0.78em)[MUC16 armored\ CAR-T],
  block(fill: c-accent.lighten(86%), radius: 2pt, inset: 0.25em, [✓]),
  block(fill: c-amber.lighten(82%), radius: 2pt, inset: 0.25em, text(fill: c-amber, weight: "bold")[2026]),
  [],
)

#v(0.75em)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.85em,
  card([GB-0895], [长效 anti-TSLP 抗体，是最接近商业验证的核心资产。], color: c-primary),
  card([GB-4362], [用于降低 MMAE ADC 相关毒性，体现平台能做功能型蛋白。], color: c-amber),
  card([GB-5267], [MUC16 靶向 armored CAR-T，说明平台进入肿瘤细胞治疗场景。], color: c-blue),
)

== 代表项目：GB-0895 anti-TSLP 抗体

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.2em,
  cetz-canvas(length: 1.5cm, {
    import cetz.draw: *
    let label(pos, body, color) = {
      rect((pos.at(0) - 1.55, pos.at(1) - 0.42), (pos.at(0) + 1.55, pos.at(1) + 0.42), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
      content(pos, text(0.7em, weight: "bold", fill: color, body))
    }
    label((1.2, 4.8), [气道上皮细胞], c-accent)
    label((4.2, 3.5), [TSLP 信号], c-amber)
    label((7.2, 4.8), [炎症通路激活], c-primary)
    label((4.2, 1.25), [GB-0895 阻断], c-blue)
    line((2.75, 4.55), (3.3, 3.8), mark: (end: ">"), stroke: 1pt + c-gray)
    line((5.1, 3.8), (6.0, 4.55), mark: (end: ">"), stroke: 1pt + c-gray)
    line((4.2, 2.9), (4.2, 1.75), mark: (end: ">"), stroke: 1pt + c-blue)
    line((5.35, 1.6), (6.2, 4.25), stroke: (paint: c-primary, thickness: 1.2pt, dash: "dashed"))
    content((6.9, 2.55), text(0.68em, fill: c-primary)[减少下游炎症])
  }),
  block({
    text(weight: "bold", [为什么选择 GB-0895 作为代表？])
    v(0.45em)
    text(size: 0.88em)[
      - 靶点 TSLP 已被临床验证，是气道炎症上游因子
      - Generate 的目标不是重新证明 TSLP，而是优化药物属性
      - 核心卖点是*长效、高亲和力、每 6 个月仅需给药一次*
    ]
    v(0.7em)
    block(
      inset: 0.72em,
      radius: 5pt,
      fill: c-primary.lighten(93%),
      stroke: (left: 3pt + c-primary),
      text(size: 0.86em, fill: c-primary)[
        如果长效给药优势成立，它会直接影响患者便利性和依从性。
      ],
    )
  }),
)

== 市场与患者需求：为什么重度哮喘值得做？

#grid(
  columns: (1.15fr, 0.85fr),
  column-gutter: 1.2em,
  cetz-canvas(length: 1.35cm, {
    import cetz.draw: *
    let base = 0.4
    let scale = 4.7 / 180
    let bar(x, val, label, color) = {
      let h = val * scale
      rect((x - 0.65, base), (x + 0.65, base + h), fill: color, stroke: none, radius: 2pt)
      content((x, base + h + 0.35), text(0.78em, weight: "bold", fill: color)[\$#val B])
      content((x, base - 0.45), text(0.72em, label))
    }
    line((0.6, base), (7.2, base), stroke: 0.6pt + c-gray)
    bar(2.2, 100.5, [2026E], c-amber)
    bar(5.4, 179.2, [2031E], c-primary)
    content((4, 6), text(0.82em, fill: c-gray)[Asthma biologics market size])
  }),
  block({
    text(weight: "bold", [直接切入一个已成规模、仍在增长的市场])
    v(0.4em)
    text(size: 0.88em)[
      - 重度哮喘患者需要长期治疗
      - 现有生物制剂虽有效，但给药频率和依从性仍是重大痛点。
    ]
    v(0.5em)
    grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      mini-arrow([已验证靶点], color: c-accent),
      mini-arrow([明确患者需求], color: c-primary),
      mini-arrow([长效给药优势], color: c-amber),
      mini-arrow([商业规模可观], color: c-blue),
    )
    v(0.55em)
    source-note([第三方市场研究估算：2026 年约 100.5 亿美元，2031 年约 179.2 亿美元。])
  }),
)

== 临床进展：SOLAIRIA-1/2 如何验证 GB-0895？

#grid(
  columns: (1.6fr, 0.8fr),
  column-gutter: 1.1em,
  block({
    cetz-canvas(length: 2.0cm, {
      import cetz.draw: *
      let y = 2.4
      let step(x, label, color) = {
        circle((x, y), radius: 0.45, fill: color.lighten(85%), stroke: 0.8pt + color)
        content((x, y), text(0.72em, weight: "bold", fill: color, label.at(0)))
        content((x, y - 0.9), text(0.68em, label.at(1)))
      }
      step(0.8, ([1], [筛选\ 入组]), c-accent)
      step(2.6, ([2], [随机\ 分组]), c-primary)
      step(4.4, ([3], [Week 0\ 给药]), c-amber)
      step(6.2, ([4], [Week 26\ 给药]), c-blue)
      step(8.0, ([5], [Week 52\ 终点]), c-primary)
      for x in (1.25, 3.05, 4.85, 6.65) {
        line((x, y), (x + 0.9, y), mark: (end: ">"), stroke: 0.8pt + c-gray)
      }
      content((4.4, 3.55), text(0.78em, fill: c-primary, weight: "bold")[300mg SC · 每 6 个月一次])
      content((8.0, 3.25), text(0.65em, fill: c-gray)[主要终点：52 周急性加重率])
    })
  }),
  block({
    text(weight: "bold", [Phase 3 是平台故事的关键压力测试])
    v(0.4em)
    text(size: 0.86em)[
      - 两项全球 Phase 3：SOLAIRIA-1 / SOLAIRIA-2
      - 计划纳入约 1600 名重度哮喘患者
      - 覆盖 40 多个国家
      - 比较 GB-0895 300mg Q26W 与 placebo
    ]
    v(0.55em)
    text(size: 0.86em, fill: c-primary)[
      GB-0895 的 Phase 3 结果，会成为判断 Generate 平台价值的核心节点。
    ]
  }),
)

== 专利布局：平台专利 + 应用专利 + 分子专利

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0.9em,
  card(
    [平台层],
    [ US 20250218530 A1 \
      基于扩散模型的生成式蛋白设计 \ \
      保护的是Generate平台中用于生成蛋白的的Chroma模型],
    color: c-primary,
  ),
  card(
    [应用层],
    [US 20240161864 A1 \
     机器学习引导交叉反应性抗体生成 \ \
     保护的是Generate平台在抗体设计上的具体应用],
    color: c-amber,
  ),
  card(
    [产品层],
    [ 自2025年起陆续进入国家阶段申请\ \
      保护的是围绕 GB-0895 等候选分子的抗体序列、用途和给药方案],
    color: c-accent,
  ),
)

#v(0.8em)

#align(center, cetz-canvas(length: 1.2cm, {
  import cetz.draw: *
  rect((0, 0), (8.8, 1.0), fill: c-primary.lighten(88%), stroke: 0.6pt + c-primary, radius: 4pt)
  rect((0.65, 1.0), (8.15, 2.0), fill: c-amber.lighten(85%), stroke: 0.6pt + c-amber, radius: 4pt)
  rect((1.3, 2.0), (7.5, 3.0), fill: c-accent.lighten(88%), stroke: 0.6pt + c-accent, radius: 4pt)
  content((4.4, 0.5), text(0.78em, weight: "bold", fill: c-primary)[平台方法：可复用的生成能力])
  content((4.4, 1.5), text(0.78em, weight: "bold", fill: c-amber)[应用场景：特定任务和功能优化])
  content((4.4, 2.5), text(0.78em, weight: "bold", fill: c-accent)[候选分子：具体产品权利])
}))

#v(0.55em)

== 专利实例：US20250218530A1 用于生成式蛋白设计的扩散模型

#grid(
  columns: (0.3fr, 0.3fr,0.3fr),
  column-gutter: 1em,
  block({
    align(center, image("../input/affair/assets/image5.png", width: 75%))
    v(0.25em)
    source-note([Chroma基于形状约束生成全新设计的蛋白分子])
  }),
    block({
    align(center, image("../input/affair/assets/image6.png", width: 100%))
  }),
  block({
    text(weight: "bold", [权利要求1：])
    v(0.45em)
    text(size: 0.86em)[
      一个基于扩散模型框架，接受特定设计要求，包含可编程能量函数和约束空间采样两步，用于de novo蛋白设计的系统。
    ]
    v(0.5em)
    text(weight: "bold", [实施例：不同约束条件下生成蛋白])
    v(0.45em)
    text(size: 0.86em)[
      输入： \
      形状条件：代表字母‘A’的三维点云文件; \
      输出： \
      一个氨基酸骨架整体走向为‘A’形状的全新蛋白质。
    ]
  }),
)

== 合作网络：大药企与癌症中心验证平台价值

#grid(
  columns: (1.1fr, 0.9fr),
  column-gutter: 1.15em,
  cetz-canvas(length: 1.22cm, {
    import cetz.draw: *
    let center = (4, 3)

    let partner(pos, label, sub, color) = {
      // 先画线
      line(center, pos, stroke: (paint: color, thickness: 0.8pt, dash: "dashed"))
      // 再画矩形和文字
      rect((pos.at(0) - 1.55, pos.at(1) - 0.55), (pos.at(0) + 1.55, pos.at(1) + 0.55), fill: color.lighten(88%), stroke: 0.6pt + color, radius: 4pt)
      content(pos, text(0.68em, weight: "bold", fill: color, label + [\ ] + text(0.58em, fill: c-gray, weight: "regular", sub)))
    }

    // 先调用所有 partner（线在最底层）
    partner((0.9, 5.5), [Amgen], [5 个靶点], c-amber)
    partner((7.1, 5.5), [Novartis], [多靶点合作], c-accent)
    partner((0.9, 0.5), [MD Anderson], [肿瘤转化], c-blue)
    partner((7.1, 0.5), [Roswell Park], [细胞治疗], c-gray)

    // 中心圆和文字最后画，压住所有线头
    circle(center, radius: 1.12, fill: c-primary, stroke: none)
    content(center, text(0.8em, fill: white, weight: "bold")[Generate\ Platform])
  }),
  block({
    text(weight: "bold", [大药企的合作体现了Generate平台的技术前景])
    v(0.45em)
    text(size: 0.86em)[
      Amgen 与 Novartis 付费合作，说明大药企愿意为平台能力下注；癌症中心合作则为肿瘤管线提供临床转化资源。
    ]
    v(0.55em)
    text(size: 0.86em)[
      - Amgen：upfront 5000 万美元，潜在交易价值约 19 亿美元
      - Novartis：6500 万美元 upfront / 股权，潜在里程碑超过 10 亿美元
      - 学术医疗机构：补足肿瘤和细胞治疗场景
    ]
  }),
)

== 小结：技术故事成立，但商业验证仍在路上

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.2em,
  block(
    inset: 0.75em,
    radius: 6pt,
    fill: c-accent.lighten(92%),
    stroke: (left: 4pt + c-accent),
    {
      text(weight: "bold", fill: c-accent, [平台证据])
      v(0.4em)
      text(size: 0.9em)[
        - 科学创始人与平台逻辑连续
        - Chroma 有 Nature 论文与实验验证
        - 专利布局覆盖平台、应用和分子
        - GB-0895 已进入全球 Phase 3
        - Amgen / Novartis 等合作形成外部背书
      ]
    },
  ),
  block(
    inset: 0.75em,
    radius: 6pt,
    fill: c-primary.lighten(92%),
    stroke: (left: 4pt + c-primary),
    {
      text(weight: "bold", fill: c-primary, [未验证风险])
      v(0.4em)
      text(size: 0.9em)[
        - AI 生成药物还缺少最终临床成功样本
        - Phase 3 结果决定 GB-0895 的真实价值
        - 生产放大、监管接受度仍有不确定性
        - IP 稳定性和竞品压力会影响商业化空间
      ]
    },
  ),
)

#v(0.85em)

#align(center, block(
  width: 92%,
  inset: 0.75em,
  radius: 6pt,
  fill: c-primary.lighten(93%),
  stroke: (left: 4pt + c-primary),
  text(size: 1.02em, fill: c-primary, weight: "bold")[
    Generate 在"技术和平台叙事"上已经形成较强证据链；\
    但商业公司需要的不是技术故事，而是临床证据。
  ],
))
