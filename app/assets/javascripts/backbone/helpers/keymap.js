 // d3 keymap for places

var makeKeymap = function(initarea){
  var width = 310,
      height = 170;
  keymap = d3.select("#keymap").insert("svg:svg")
    .attr("width", width)
    .attr("height", height);

  boroughs = keymap.append("svg:g")
    .attr("id", "boroughs");
  hoods = keymap.append("svg:g")
    .attr("id", "hoods");

  d3.json("assets/data/london-boroughs14.json", function(json) {
    // console.log(json)
    // vanilla projection
    var projection = d3.geo.mercator()
        .scale(1)
        .translate([0, 0]);
    var path = d3.geo.path().projection(projection);
    // compute projection variables from data
    var b = path.bounds(json),
        s = .95 / Math.max((b[1][0] - b[0][0]) / width, (b[1][1] - b[0][1]) / height),
        t = [(width - s * (b[1][0] + b[0][0])) / 2, (height - s * (b[1][1] + b[0][1])) / 2];
    // new corrected projection
    projection
      .scale(s)
      .translate(t);
    // place boroughs
    boroughs.selectAll("path")
        .data(json.features)
      .enter().append("svg:path")
        .attr("d", path)
        .style("fill", "#eee")
        .style("stroke-width", "0.5")
        .style("stroke", "#333")
  });
}
