Artist.create({
  id: "TWljaGFlbCBKYWNrc29u",
  name: "Michael Jackson",
  age: 21,
  albums: "https://tarea-2-taller-integracion.herokuapp.com/artists/TWljaGFlbCBKYWNrc29u/albums",
  tracks: "https://tarea-2-taller-integracion.herokuapp.com/artists/TWljaGFlbCBKYWNrc29u/tracks",
  self: "https://tarea-2-taller-integracion.herokuapp.com/artists/TWljaGFlbCBKYWNrc29u"
}
)

Album.create(
    {
        id: "T2ZmIHRoZSBXYWxsOlRXbG",
        artist_id: "TWljaGFlbCBKYWNrc29u",
        name: "Off the Wall",
        genre: "Pop",
        artist: "https://tarea-2-taller-integracion.herokuapp.com/artists/TWljaGFlbCBKYWNrc29u",
        tracks: "https://tarea-2-taller-integracion.herokuapp.com/albums/T2ZmIHRoZSBXYWxsOlRXbG/tracks",
        self: "https://tarea-2-taller-integracion.herokuapp.com/albums/T2ZmIHRoZSBXYWxsOlRXbG"
      }
)

Track.create(
    {
        id: "RG9uJ3QgU3RvcCAnVGlsIF",
        album_id: "T2ZmIHRoZSBXYWxsOlRXbG",
        name: "Don't Stop 'Til You Get Enough",
        duration: 4.1,
        times_played: 0,
        artist: "https://tarea-2-taller-integracion.herokuapp.com/artists/TWljaGFlbCBKYWNrc29u",
        album: "https://tarea-2-taller-integracion.herokuapp.com/albums/T2ZmIHRoZSBXYWxsOlRXbG",
        self: "https://tarea-2-taller-integracion.herokuapp.com/tracks/RG9uJ3QgU3RvcCAnVGlsIF"
      }

)

Track.create(
    {
        id: "prueba",
        album_id: "T2ZmIHRoZSBXYWxsOlRXbG",
        name: "Don't Stop 'Til You Get Enough",
        duration: 4.1,
        times_played: 0,
        artist: "https://tarea-2-taller-integracion.herokuapp.com/artists/TWljaGFlbCBKYWNrc29u",
        album: "https://tarea-2-taller-integracion.herokuapp.com/albums/T2ZmIHRoZSBXYWxsOlRXbG",
        self: "https://tarea-2-taller-integracion.herokuapp.com/tracks/RG9uJ3QgU3RvcCAnVGlsIF"
      }

)

Track.create(
    {
        id: "prueba_uno",
        album_id: "T2ZmIHRoZSBXYWxsOlRXbG",
        name: "Don't Stop 'Til You Get Enough",
        duration: 4.1,
        times_played: 0,
        artist: "https://tarea-2-taller-integracion.herokuapp.com/artists/TWljaGFlbCBKYWNrc29u",
        album: "https://tarea-2-taller-integracion.herokuapp.com/albums/T2ZmIHRoZSBXYWxsOlRXbG",
        self: "https://tarea-2-taller-integracion.herokuapp.com/tracks/RG9uJ3QgU3RvcCAnVGlsIF"
      }

)