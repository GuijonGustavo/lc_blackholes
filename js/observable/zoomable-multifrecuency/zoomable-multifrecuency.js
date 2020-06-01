// https://observablehq.com/@likecarter/u-s-treasury-general-account-comparison-with-the-s-p500@638
import define1 from "./a33468b95d0b15b0@692.js";

export default function define(runtime, observer) {
  const main = runtime.module();
  const fileAttachments = new Map([["optical.csv",new URL("./files-m/optical",import.meta.url)],["radio.csv",new URL("./files-m/radio",import.meta.url)],["xrays.csv",new URL("./files-m/xrays",import.meta.url)],["gamma.csv",new URL("./files-m/gamma",import.meta.url)]]);
  main.builtin("FileAttachment", runtime.fileAttachments(name => fileAttachments.get(name)));
  main.variable(observer()).define(["md"], function(md){return(
md`# Multi-Frecuency Chart Mrk421

Student: Gustavo Magallanes-Guijón.

Advisor: Dr. Sergio Mendoza Ramos`

  )});
  main.variable(observer()).define(["legend","d3","scheme"], function(legend,d3,scheme){return(
legend({
  color: d3.scaleOrdinal(["Radio","Optical","X-Rays", "Gamma"], scheme)
})
)});
  main.variable(observer("chart")).define("chart", ["d3","width","height","DOM","margin","radio","xrays","gamma","scheme","data","xAxis","yAxis","yAxisSp","yAxisX","yAxisG","area","areaSp","areaX","areaG"], function(d3,width,height,DOM,margin,radio,xrays,gamma,scheme,data,xAxis,yAxis,yAxisSp,yAxisX,yAxisG,area,areaSp,areaX,areaG)
{
  const svg = d3
    .create("svg")
    .attr("viewBox", [0, 0, width, height])
    .style("display", "block");

  const clipId = DOM.uid("clip");

  svg
    .append("clipPath")
    .attr("id", clipId.id)
    .append("rect")
    .attr("x", margin.left)
    .attr("y", 0)
    .attr("height", height)
    .attr("width", width - margin.left - margin.right);

  const gx = svg.append("g");

  const gy = svg.append("g");

  const gySp = svg.append("g");

  const gyX = svg.append("g");

  const gyG = svg.append("g");

	const pathRadio = svg
    .append("path")
    .datum(radio)
    .attr("clip-path", clipId)
    .attr("opacity", 0.9)
    .attr("fill", scheme[0]);

  const pathOptical = svg
    .append("path")
    .datum(data)
    .attr("clip-path", clipId)
    .attr("opacity", 0.9)
    .attr("fill", scheme[1]);


	const pathX = svg
    .append("path")
    .datum(xrays)
    .attr("clip-path", clipId)
    .attr("opacity", 0.9)
    .attr("fill", scheme[2]);

	const pathG = svg
    .append("path")
    .datum(xrays)
    .attr("clip-path", clipId)
    .attr("opacity", 0.9)
    .attr("fill", scheme[3]);


  return Object.assign(
    svg.node(),
    {
      update(focusX, focusY) {
        gx.call(xAxis, focusX, height);
        gy.call(yAxis, focusY, data.y);
        pathOptical.attr("d", area(focusX, focusY));
      }
    },
    {
      updateSp(focusX, focusY) {
        gx.call(xAxis, focusX, height);
        gySp.call(yAxisSp, focusY, radio.y);
        pathRadio.attr("d", areaSp(focusX, focusY));
      }
    },
    {
      updateX(focusX, focusY) {
        gx.call(xAxis, focusX, height);
        gyX.call(yAxisX, focusY, xrays.y);
        pathX.attr("d", areaX(focusX, focusY));
      }
    },
    {
      updateG(focusX, focusY) {
        gx.call(xAxis, focusX, height);
        gyG.call(yAxisG, focusY, gamma.y);
        pathG.attr("d", areaG(focusX, focusY));
      }
    }
  );
}
);
  main.variable(observer("viewof focus")).define("viewof focus", ["d3","width","focusHeight","margin","x","xAxis","data","scheme","radio","xrays","gamma","area","areaSp","areaX","areaG","y","ySp","yX","yG"], function(d3,width,focusHeight,margin,x,xAxis,data,scheme,radio,xrays,gamma,areaSp,area,areaX,areaG,y,ySp,yX,yG)
{
  const svg = d3
    .create("svg")
    .attr("viewBox", [0, 0, width, focusHeight])
    .style("display", "block");

  const brush = d3
    .brushX()
    .extent([
      [margin.left, 0.5],
      [width - margin.right, focusHeight - margin.bottom + 0.5]
    ])
    .on("brush", brushed)
    .on("end", brushended);

  const defaultSelection = [
    x(d3.utcYear.offset(x.domain()[1], -1)),
    x.range()[1]
  ];

  svg.append("g").call(xAxis, x, focusHeight);

  svg
    .append("path")
    .datum(radio)
    .attr("opacity", 0.9)
    .attr("fill", scheme[0])
    .attr("d", areaSp(x, ySp.copy().range([focusHeight - margin.bottom, 4])));

  svg
    .append("path")
    .datum(data)
    .attr("opacity", 0.9)
    .attr("fill", scheme[1])
    .attr("d", area(x, y.copy().range([focusHeight - margin.bottom, 4])));
  svg
    .append("path")
    .datum(xrays)
    .attr("opacity", 0.9)
    .attr("fill", scheme[2])
    .attr("d", areaX(x, yX.copy().range([focusHeight - margin.bottom, 4])));

  svg
    .append("path")
    .datum(gamma)
    .attr("opacity", 0.9)
    .attr("fill", scheme[3])
    .attr("d", areaG(x, yG.copy().range([focusHeight - margin.bottom, 4])));

  const gb = svg
    .append("g")
    .call(brush)
    .call(brush.move, defaultSelection);

  function brushed() {
    if (d3.event.selection) {
      svg.property(
        "value",
        d3.event.selection.map(x.invert, x).map(d3.utcDay.round)
      );
      svg.dispatch("input");
    }
  }

  function brushended() {
    if (!d3.event.selection) {
      gb.call(brush.move, defaultSelection);
    }
  }

  return svg.node();
}
);
  main.variable(observer("focus")).define("focus", ["Generators", "viewof focus"], (G, _) => G.input(_));

  main.variable(observer()).define(["focus","d3","data","chart","x","y"], function(focus,d3,data,chart,x,y)
{
  const [minX, maxX] = focus;
  const maxY = d3.max(data, d =>
    minX <= d.date && d.date <= maxX ? d.value : NaN
  );
  chart.update(x.copy().domain(focus), y.copy().domain([0, maxY]));
}
);
  main.variable(observer()).define(["focus","d3","radio","chart","x","ySp"], function(focus,d3,radio,chart,x,ySp)
{
  const [minX, maxX] = focus;
  const maxY = d3.max(radio, d =>
    minX <= d.date && d.date <= maxX ? d.value : NaN
  );
  chart.updateSp(x.copy().domain(focus), ySp.copy().domain([0, maxY]));
}
);

  main.variable(observer()).define(["focus","d3","xrays","chart","x","yX"], function(focus,d3,xrays,chart,x,yX)
{
  const [minX, maxX] = focus;
  const maxY = d3.max(xrays, d =>
    minX <= d.date && d.date <= maxX ? d.value : NaN
  );
  chart.updateX(x.copy().domain(focus), yX.copy().domain([0, maxY]));
}
);

  main.variable(observer()).define(["focus","d3","gamma","chart","x","yG"], function(focus,d3,gamma,chart,x,yG)
{
  const [minX, maxX] = focus;
  const maxY = d3.max(gamma, d =>
    minX <= d.date && d.date <= maxX ? d.value : NaN
  );
  chart.updateG(x.copy().domain(focus), yG.copy().domain([0, maxY]));
}
);

  main.variable(observer("data")).define("data", ["d3","FileAttachment"], async function(d3,FileAttachment){return(
Object.assign(
  d3
    .csvParse(await FileAttachment("optical.csv").text(), d3.autoType)
    .map(({ DATE, fluxOptical }) => ({ date: DATE, value: fluxOptical })),
  { y: "Flux" }
)
)});
  main.variable(observer("radio")).define("radio", ["d3","FileAttachment"], async function(d3,FileAttachment){return(
Object.assign(
  d3
    .csvParse(await FileAttachment("radio.csv").text(), d3.autoType)
    .map(({ fecha, fluxRadio }) => ({ date:fecha, value: fluxRadio }))
//	,{ y: "Jy" }
)
)});

  main.variable(observer("xrays")).define("xrays", ["d3","FileAttachment"], async function(d3,FileAttachment){return(
Object.assign(
  d3
    .csvParse(await FileAttachment("xrays.csv").text(), d3.autoType)
    .map(({ dia, fluX }) => ({ date:dia, value: fluX }))
//	,{ y: "Ph^2" }
)
)});

  main.variable(observer("gamma")).define("gamma", ["d3","FileAttachment"], async function(d3,FileAttachment){return(
Object.assign(
  d3
    .csvParse(await FileAttachment("gamma.csv").text(), d3.autoType)
    .map(({ DIA, fluxGamma }) => ({ date:DIA, value: fluxGamma }))
	//,{ y: "Count^2" }
)
)});


  main.variable(observer("area")).define("area", ["d3"], function(d3){return(
(x, y) => d3.area()
    .defined(d => !isNaN(d.value))
    .x(d => x(d.date))
    .y0(y(0))
    .y1(d => y(d.value))
)});
  main.variable(observer("areaSp")).define("areaSp", ["d3"], function(d3){return(
(x, y) =>
  d3
    .area()
    .defined(d => !isNaN(d.value))
    .x(d => x(d.date))
    .y0(y(0))
    .y1(d => y(d.value))
)});
  main.variable(observer("areaX")).define("areaX", ["d3"], function(d3){return(
(x, y) =>
  d3
    .area()
    .defined(d => !isNaN(d.value))
    .x(d => x(d.date))
    .y0(y(0))
    .y1(d => y(d.value))
)});

  main.variable(observer("areaG")).define("areaG", ["d3"], function(d3){return(
(x, y) =>
  d3
    .area()
    .defined(d => !isNaN(d.value))
    .x(d => x(d.date))
    .y0(y(0))
    .y1(d => y(d.value))
)});


  main.variable(observer("x")).define("x", ["d3","data","margin","width"], function(d3,data,margin,width){return(
d3.scaleUtc()
    .domain(d3.extent(data, d => d.date))
    .range([margin.left, width - margin.right])
)});



  main.variable(observer("y")).define("y", ["d3","data","height","margin"], function(d3,data,height,margin){return(
d3.scaleLinear()
    .domain([0, d3.max(data, d => d.value)])
    .range([height - margin.bottom, margin.top])
)});
  main.variable(observer("ySp")).define("ySp", ["d3","radio","height","margin"], function(d3,radio,height,margin){return(
d3
  .scaleLinear()
  .domain([0, d3.max(radio, d => d.value)])
  .range([height - margin.bottom, margin.top])
)});

  main.variable(observer("yX")).define("yX", ["d3","xrays","height","margin"], function(d3,xrays,height,margin){return(
d3
  .scaleLinear()
  .domain([0, d3.max(xrays, d => d.value)])
  .range([height - margin.bottom, margin.top])
)});


  main.variable(observer("yG")).define("yG", ["d3","gamma","height","margin"], function(d3,gamma,height,margin){return(
d3
  .scaleLinear()
  .domain([0, d3.max(gamma, d => d.value)])
  .range([height - margin.bottom, margin.top])
)});


  main.variable(observer("xAxis")).define("xAxis", ["margin","d3","width"], function(margin,d3,width){return(
(g, x, height) => g
    .attr("transform", `translate(0,${height - margin.bottom})`)
    .call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))
)});
  main.variable(observer("yAxis")).define("yAxis", ["margin","d3"], function(margin,d3){return(
(g, y, title) =>
  g
    .attr("transform", `translate(${margin.left},0)`)
    .call(d3.axisLeft(y))
    .call(g => g.select(".domain").remove())
    .call(g =>
      g
        .selectAll(".title")
        .data([title])
        .join("text")
        .attr("class", "title")
        .attr("x", -margin.left)
        .attr("y", 10)
        .attr("fill", "currentColor")
        .attr("text-anchor", "start")
        .text(title)
    )
)});
  main.variable(observer("yAxisSp")).define("yAxisSp", ["width","margin","d3"], function(width,margin,d3){return(
(g, y, title) =>
  g
    .attr("transform", `translate(${width - margin.right},0)`)
  //  .call(d3.axisRight(y))
    .call(g => g.select(".domain").remove())
    .call(g =>
      g
        .selectAll(".title")
        .data([title])
        .join("text")
        .attr("class", "title")
        .attr("x", 0)
        .attr("y", 10)
        .attr("fill", "currentColor")
        .attr("text-anchor", "start")
        .text(title)
    )
)});

  main.variable(observer("yAxisX")).define("yAxisX", ["width","margin","d3"], function(width,margin,d3){return(
(g, y, title) =>
  g
    .attr("transform", `translate(${width - margin.right},0)`)
   // .call(d3.axisRight(y))
    .call(g => g.select(".domain").remove())
    .call(g =>
      g
        .selectAll(".title")
        .data([title])
        .join("text")
        .attr("class", "title")
        .attr("x", 0)
        .attr("y", 10)
        .attr("fill", "currentColor")
        .attr("text-anchor", "start")
        .text(title)
    )
)});

  main.variable(observer("yAxisG")).define("yAxisG", ["width","margin","d3"], function(width,margin,d3){return(
(g, y, title) =>
  g
    .attr("transform", `translate(${width - margin.right},0)`)
    //.call(d3.axisRight(y))
    .call(g => g.select(".domain").remove())
    .call(g =>
      g
        .selectAll(".title")
        .data([title])
        .join("text")
        .attr("class", "title")
        .attr("x", 0)
        .attr("y", 10)
        .attr("fill", "currentColor")
        .attr("text-anchor", "start")
        .text(title)
    )
)});

  main.variable(observer("margin")).define("margin", function(){return(
{ top: 20, right: 40, bottom: 30, left: 40 }
)});
  main.variable(observer("height")).define("height", function(){return(
440
)});
  main.variable(observer("focusHeight")).define("focusHeight", function(){return(
100
)});
  main.variable(observer("scheme")).define("scheme", function(){return(
["red", "orange","violet","steelblue" ]
)});
  const child1 = runtime.module(define1);
  main.import("legend", child1);
  main.variable(observer("d3")).define("d3", ["require"], function(require){return(
require("d3@5")
)});
  return main;
}
