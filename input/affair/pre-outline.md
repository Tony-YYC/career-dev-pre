# Pre Outline: Affair Part

这是我大致构思的事的部分的Pre框架。这部分演讲时间在15min左右。如有需要，可以调整。

| 页码 | Slide标题                                     | 核心内容                                                                                                                                  | 视觉/图片建议                                                    | 时间      |
| -- | ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | ------- |
| 1  | Generate Biomedicines：从“发现药物”到“生成药物”        | 开场定义：这部分讲公司的“事”——它到底在做什么，技术从哪里来，做到了哪一步。                                                                                               | 用一张“AI → 蛋白设计 → 药物管线 → 临床验证”的横向流程图。                        | 40s     |
| 2  | 本部分要回答的三个问题                                 | ①科学起点是谁？②平台如何工作？③平台是否被论文、专利、临床和合作验证？                                                                                                  | 三个问题卡片式排版。                                                 | 40s     |
| 3  | 科学创始人：Gevorg Grigoryan                      | 他是Co-Founder & CTO，Generate官网也把他列为核心领导成员；他负责Generate Platform的发展。([Generate:Biomedicines][1])                                         | 使用Word中已有Gevorg头像，旁边放“计算蛋白设计 / 机器学习 / 蛋白结构-功能”关键词。         | 1min    |
| 4  | 公司主要做什么：生成式蛋白药物设计                           | Generate定位为generative biology公司，核心是用机器学习、生物工程和医学交叉来设计蛋白类药物。官网称其Generative Biology是把机器学习、实验和药物开发整合起来的反馈循环。([Generate:Biomedicines][1]) | “蛋白药物生成工厂”图：输入靶点，输出抗体、酶、细胞治疗等。                             | 1min    |
| 5  | 为什么要这样做：传统药物发现的瓶颈                           | 传统方法更像“筛选和优化”，Generate强调“按目标生成”。蛋白空间巨大，传统实验难以穷尽搜索。                                                                                    | 左右对比图：传统筛选漏斗 vs Generate生成闭环。                              | 1min    |
| 6  | Generate Platform：Design–Build–Test–Learn闭环 | 平台整合AI模型与高通量实验验证；Generate公开资料中把它描述为“living feedback loop”。([Generate:Biomedicines][1])                                                | 画一个闭环：设计→制造→测试→学习→再设计。                                     | 1min    |
| 7  | 核心模型Chroma：可编程蛋白生成                          | Chroma可以直接生成蛋白结构和序列，并可按对称性、形状、语义甚至自然语言提示进行条件化设计。([Nature][2])                                                                         | 用Word里的Chroma机制图，建议重画成更简洁版本。                               | 1min    |
| 8  | 关键文献：Nature 2023验证了什么？                      | Nature论文显示，Chroma对310个蛋白进行了实验表征；生成蛋白能表达、折叠，并具有较好的生物物理性质，两个设计蛋白晶体结构与模型约1.0 Å RMSD一致。([Nature][2])                                      | 用“论文证据链”：模型能力→310个实验蛋白→晶体结构验证。                             | 1min10s |
| 9  | 产品管线：平台不是只停留在论文                             | 管线重点放三个临床/准临床项目：GB-0895、GB-4362、GB-5267。Q1 2026更新显示GB-0895 Phase 3继续推进，GB-4362和GB-5267预计2026年进入患者给药阶段。([SEC][3])                      | 管线甘特图：Preclinical / Phase 1 / Phase 3。                     | 1min    |
| 10 | 代表项目：GB-0895 anti-TSLP抗体                    | 用于重度哮喘，目标是每6个月给药一次。官方Phase 3新闻称GB-0895是AI工程化的长效anti-TSLP抗体。([Generate:Biomedicines][4])                                               | 生成一张TSLP通路示意图：炎症信号被抗体阻断。                                   | 1min    |
| 11 | 市场与患者需求：为什么重度哮喘值得做？                         | 第三方市场研究估计，哮喘生物制剂市场2026年约100.5亿美元，2031年约179.2亿美元；便利性和长效给药正在成为竞争点。([Mordor Intelligence][5])                                            | 市场规模柱状图 + “每6个月一次”给药优势图。                                   | 1min    |
| 12 | 临床进展：SOLAIRIA-1/2如何验证GB-0895？               | Phase 3项目约1600名患者，覆盖40多个国家；每项研究比较GB-0895 300mg每6个月皮下注射 vs placebo，主要终点是52周哮喘急性加重率。([Generate:Biomedicines][4])                        | 临床试验流程图：筛选→随机→Week 0给药→Week 26给药→Week 52终点评估。              | 1min20s |
| 13 | 专利布局：平台专利 + 应用专利 + 分子专利                     | 你们资料中Chroma专利原写为申请中，但最新专利数据库显示“Diffusion model for generative protein design”已在2026年3月17日授权，专利号12,580,040。([Justia Patents][6])       | 专利时间线：临时申请→PCT→公开→授权；或“护城河三层结构”。                           | 1min    |
| 14 | 合作网络：大药企与癌症中心验证平台价值                         | Amgen合作覆盖5个临床靶点，初始付款5000万美元，潜在交易价值19亿美元；Novartis合作包括6500万美元 upfront及超过10亿美元潜在里程碑。([Amgen][7])                                         | 生态图：Generate居中，四周放Amgen、Novartis、MD Anderson、Roswell Park。 | 1min    |
| 15 | 结论：技术故事成立，但商业验证仍在路上                         | 结论分两面：正面是论文、专利、合作、临床管线形成闭环；风险是AI药物设计仍需临床成功证明，监管、生产、IP和市场竞争都还存在不确定性。                                                                   | 天平图：左边“平台证据”，右边“临床/商业风险”。                                  | 1min    |

[1]: https://generatebiomedicines.com/about-us "Generate:Biomedicines | About Us"
[2]: https://www.nature.com/articles/s41586-023-06728-8 "Illuminating protein space with a programmable generative model | Nature"
[3]: https://www.sec.gov/Archives/edgar/data/2100782/000119312526209899/ck0002100782-ex99_1.htm "EX-99.1"
[4]: https://generatebiomedicines.com/media-center/generatebiomedicines-to-initiate-global-phase-3-studies-of-gb-0895-a-long-acting-anti-tslp-antibody-for-severe-asthma-engineered-with-ai "Generate:Biomedicines | Generate:Biomedicines to Initiate Global…"
[5]: https://www.mordorintelligence.com/industry-reports/asthma-biologics-market "Asthma Biologics Market Size, Share & 2031 Growth Trends Report"
[6]: https://patents.justia.com/assignee/generate-biomedicines-inc "Patents Assigned to Generate Biomedicines, Inc. - Justia Patents Search"
[7]: https://www.amgen.com/newsroom/press-releases/2022/01/amgen-and-generate-biomedicines-announce-multitarget-multimodality-research-collaboration-agreement "Amgen and Generate Biomedicines Announce Multi-Target, Multi-Modality Research Collaboration Agreement| Amgen"
