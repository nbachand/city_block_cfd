from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.pagesizes import landscape, letter
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import inch
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle


OUTPUT = "output/pdf/monte_carlo_distribution_table.pdf"


styles = getSampleStyleSheet()
cell = ParagraphStyle(
    "cell",
    parent=styles["BodyText"],
    fontName="Helvetica",
    fontSize=9,
    leading=12,
    textColor=colors.HexColor("#202124"),
    spaceAfter=0,
)
header = ParagraphStyle(
    "header",
    parent=cell,
    fontName="Helvetica-Bold",
    alignment=TA_CENTER,
    textColor=colors.white,
)
caption = ParagraphStyle(
    "caption",
    parent=cell,
    fontSize=8.5,
    leading=11,
    alignment=TA_CENTER,
    textColor=colors.HexColor("#333333"),
)


def p(text, style=cell):
    return Paragraph(text, style)


data = [
    [
        p("Monte Carlo case", header),
        p("Randomly sampled quantity", header),
        p("Means tested", header),
        p("Standard deviation", header),
    ],
    [
        p("Flow-based"),
        p("Flow rate"),
        p("40 log-spaced values from 0.01 to 3.0"),
        p("1.0"),
    ],
    [
        p("Pressure-based"),
        p("Pressure difference"),
        p("40 log-spaced values corresponding to flow rates from 0.1 to 3.0"),
        p("Twice the pressure corresponding to a flow rate of 1.0"),
    ],
]


doc = SimpleDocTemplate(
    OUTPUT,
    pagesize=landscape(letter),
    rightMargin=0.55 * inch,
    leftMargin=0.55 * inch,
    topMargin=0.55 * inch,
    bottomMargin=0.55 * inch,
    title="Monte Carlo distribution table",
)

table = Table(
    data,
    colWidths=[1.45 * inch, 2.05 * inch, 3.15 * inch, 3.05 * inch],
    repeatRows=1,
    hAlign="CENTER",
)
table.setStyle(
    TableStyle(
        [
            ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#34495E")),
            ("ALIGN", (0, 0), (-1, 0), "CENTER"),
            ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
            ("BACKGROUND", (0, 1), (-1, 1), colors.HexColor("#F3F6F8")),
            ("BACKGROUND", (0, 2), (-1, 2), colors.white),
            ("GRID", (0, 0), (-1, -1), 0.5, colors.HexColor("#8A949C")),
            ("BOX", (0, 0), (-1, -1), 0.8, colors.HexColor("#58636B")),
            ("LEFTPADDING", (0, 0), (-1, -1), 8),
            ("RIGHTPADDING", (0, 0), (-1, -1), 8),
            ("TOPPADDING", (0, 0), (-1, -1), 9),
            ("BOTTOMPADDING", (0, 0), (-1, -1), 9),
        ]
    )
)

caption_text = (
    "<b>Table 1.</b> Monte Carlo sampling parameters. Samples were drawn from "
    "untruncated normal distributions using 10<super>6</super> independent samples "
    "for each mean. Negative samples represented instantaneous flow reversal. Flow "
    "samples were converted to pressure using the quadratic pressure-flow relation, "
    "whereas pressure samples were converted to flow using the signed square-root relation."
)

doc.build([table, Spacer(1, 0.18 * inch), p(caption_text, caption)])
