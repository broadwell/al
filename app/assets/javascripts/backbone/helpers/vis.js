var histYears = function (years) {

  var formatCount = d3.format("4d");

  var margin = {top: 10, right: 30, bottom: 20, left: 10},
      width = 340 - margin.left - margin.right,
      height = 100 - margin.top - margin.bottom;

  var x = d3.scale.linear()
      .domain(d3.extent(years))
      .range([0, width]);
  // Generate a histogram using twenty uniformly-spaced bins.
  var data = d3.layout.histogram()
      .bins(x.ticks(20))
      (years);

  var numbins = data.length;
  var barWidth = width/numbins - 1;

  var y = d3.scale.linear()
      .domain([0, d3.max(data, function(d) { return d.y; })])
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom")
      .ticks(10, "4d");

  var svg = d3.select("#place_content_region").append("svg")
      .attr("id", "histYears")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  var bar = svg.selectAll(".bar")
      .data(data)
    .enter().append("g")
      .attr("class", "bar")
      .attr("transform", function(d) { return "translate(" + x(d.x) + "," + y(d.y) + ")"; });

  bar.append("rect")
      .attr("x", 1)
      //.attr("width", x(data[0].dx) - 1)
      .attr("width", barWidth)
      .attr("height", function(d) { return height - y(d.y); });

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);
}

var packAuths = function (auths) {
  // console.log(JSON.stringify(auths))
  // TODO: variable bleed depending on # hoods?
  var bleed = 100,
      width = 340,
      height = 400;

  var pack = d3.layout.pack()
      .sort(null)
      .size([width, height + bleed * 2])
      .padding(2);

  var svg = d3.select("#place_content_region").append("svg")
      .attr("width", width)
      .attr("height", height)
    .append("g")
      .attr("transform", "translate(0," + -bleed + ")");

  // d3.json(auths, function(error, json) {
    // if (error) throw error;

  var node = svg.selectAll(".node")
      .data(pack.nodes(auths)
        .filter(function(d) { return !d.children; }))
    .enter().append("g")
      .attr("class", "node")
      .attr("transform", function(d) {
        return "translate(" + d.x + "," + d.y + ")"; })
      .on("click", function(d){
        // console.log('clicked '+ d.key)
        AL.PlacesApp.Show.Controller.listPlacePassages(d.key)
      });

  node.append("circle")
      .attr("r", function(d) { return d.r; });

  node.append("text")
      .text(function(d) { return authLabel[d.key]; })
      .style("font-size", function(d) {
        return Math.min(2 * d.r, (2 * d.r - 8) / this.getComputedTextLength() * 24) + "px";
      })
      .attr("dy", ".35em");
  // });

  d3.select(self.frameElement).style("height", height + "px");
}