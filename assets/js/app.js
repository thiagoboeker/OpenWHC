console.log("v1")

var map = L.map('map').setView([51.505, -0.09], 13);

L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
  maxZoom: 19,
  attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(map);

axios.get('/api/v1/whc_sites')
  .then((response) => {
    console.log(response.data['data'].length)
    for(let i = 0; i < response.data['data'].length; i++) {
      let lat = response.data['data'][i]['latitude']
      let long = response.data['data'][i]['longitude']
      let desc = response.data['data'][i]['short_description_en']
      L.marker([lat, long]).addTo(map).bindPopup(desc)
    }
  })