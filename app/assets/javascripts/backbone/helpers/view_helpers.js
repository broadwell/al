function setTimer(name) {
  var i, output;
  i = void 0;
  output = '';
  console.time(name);
  i = 1;
  while (i <= 1e6) {
    output += i;
    i++;
  }
}

// returns value between 0 and 1;
// r = [min,max] of dataset
function scale(value,r) {
  return value * ( 1/(r[1] - r[0]) );
}

// returns value in ems suitable for font size
function scaleFont(value,range) {
  s = d3.scale.linear()
    .domain(range)
    .range([0.9,1.4]) // em
  return s(value);
}

// returns value in pixels suitable for circle markers
function scaleMarker(value,range) {
  s = d3.scale.linear()
    .domain(range)
    .range([4,12]) // em
  return s(value);
}

function colorizeFont(value,range) {
  // var ramp=d3.scale.linear().domain([0,100]).range(["red","blue"]);
  s = d3.scale.linear()
    .domain(range)
    .range(["#666","#a63603"]) // em
  return s(value);
}
function poetize(string) {
  return string.replace(/\/(?!span)/g,'<br/>');
}

function hardSpace(string){
  return string.replace(/ /g,'&nbsp;')
}

function swap(point) {
  point = [point[1], point[0]]
  return point
}

function createPolygonFromBounds(latLngBounds) {
  // var center = latLngBounds.getCenter()
    lnglats = [];

  lnglats.push([latLngBounds.getSouthWest().lng, latLngBounds.getSouthWest().lat]);//bottom left
  lnglats.push([latLngBounds.getNorthWest().lng, latLngBounds.getNorthWest().lat]);//top left
  lnglats.push([latLngBounds.getNorthEast().lng, latLngBounds.getNorthEast().lat]);//top right
  lnglats.push([latLngBounds.getSouthEast().lng, latLngBounds.getSouthEast().lat]);//bottom right
  lnglats.push([latLngBounds.getSouthWest().lng, latLngBounds.getSouthWest().lat]);//bottom left
  //
  // latlngs.push({ lat: latLngBounds.getSouth(), lng: center.lng });//bottom center
  // latlngs.push({ lat: center.lat, lng: latLngBounds.getEast() });// center right
  // latlngs.push({ lat: latLngBounds.getNorth(), lng: map.getCenter().lng });//top center
  // latlngs.push({ lat: map.getCenter().lat, lng: latLngBounds.getWest() });//center left

  return lnglats;
  // return new L.polygon(latlngs);
}


// $(function() {
//
//   var toponyms = new Bloodhound({
//     datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
//     queryTokenizer: Bloodhound.tokenizers.whitespace,
//     prefetch: 'places.json',
//     // remote: {
//     //   url: '../data/films/queries/%QUERY.json',
//     //   wildcard: '%QUERY'
//     // }
//   });
//
//   $('#search_places .typeahead').typeahead(null, {
//     name: 'toponyms',
//     source: toponyms
//   });
//
//   $('#search_passages .typeahead').typeahead(null, {
//     name: 'toponyms',
//     source: toponyms
//   });
//   // $('#search_place').typeahead([
//   // {
//   // name: 'areas',
//   // prefetch: '/areas.json',
//   // }
//   // ]);
// })
