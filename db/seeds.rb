# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Movie.destroy_all
User.destroy_all

users = User.create([
  {first_name: 'Tyroil', last_name: 'Smoochie-Wallace', email: 'tyriol@kp.com', password_digest: '$2a$10$5ypjoIZSHCo.1JZBcIBoFe1AiZ8eD03Bn7Y7MIHGM.Ll6x2r/a/BC', token: 'ca63da06464f4c6f8f33c0ddf254195f', username: 'tyriol'},
  {first_name: 'D’Squarius', last_name: 'Green', email: 'dsquare@kp.com', password_digest: '$2a$10$KoWeUOUlJpeUG.5jdRfr8OZuM.PueGjbggf10KdmAmlRA7VsWjNFC', token: '47343b91822143eebeae5a8c14052c87', username: 'dsquare'}
])

tyroil = User.first

playlist = Playlist.create(name: "test", list_type: 0)
tyroil.playlists << playlist

fc = Movie.create(
      title: "Fight Club",
      genres: ["action", "adventure"],
      overview: "Men fight about stuff.",
      poster_path: "http://static-api.guidebox.com/thumbnails_movies_medium/12917-198028936-4552691518-6874446231-medium-240x342.jpg",
      runtime: 139,
      tagline: "First rule of fight club...",
      tmdb_vote_average: "8",
      guidebox_id: 12917,
      artwork: "https://image.tmdb.org/t/p/original/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg",
      rottentomatoes_id: 13153,
      imdb_id: "tt0137523",
      themoviedb_id: 550,
      trailer: "http://api-widget.guidebox.com/embed.php?video=5726",
      purchase_web_sources: [
            {
              "source": "amazon_buy",
              "display_name": "Amazon",
              "link": "http://www.amazon.com/gp/product/B009EEOM7K?tag=guidebox-20",
              "formats": [
                {
                "price": "2.99",
                "format": "SD",
                "type": "rent"
                },
                {
                "price": "9.99",
                "format": "SD",
                "type": "purchase"
                },
                {
                "price": "3.99",
                "format": "HD",
                "type": "rent"
                },
                {
                "price": "12.99",
                "format": "HD",
                "type": "purchase"
                }
              ]
            },
            {
              "source": "sony",
              "display_name": "Sony Entertainment Network",
              "link": "https://store.sonyentertainmentnetwork.com/#!/en-us/movies/cid=UV0010-NPVA06918_CN-0000000000010022",
              "formats": [
                {
                "price": "2.99",
                "format": "SD",
                "type": "rent"
                },
                {
                "price": "9.99",
                "format": "SD",
                "type": "purchase"
                },
                {
                "price": "3.99",
                "format": "HD",
                "type": "rent"
                },
                {
                "price": "14.99",
                "format": "HD",
                "type": "purchase"
                }]
            }
          ],
      subscription_web_sources: [],
      free_web_sources: [],
      other_sources: [],
      rt_ratings: [
          "critics_rating": "Certified Fresh",
          "critics_score": 80,
          "audience_rating": "Upright",
          "audience_score": 96
        ],
      rt_reviews: [
            {
            "critic": "Richard Schickel",
            "date": "2013-04-22",
            "freshness": "fresh",
            "publication": "TIME Magazine",
            "quote": "It is working American Beauty-Susan Faludi territory, that illiberal, impious, inarticulate fringe that threatens the smug American center with an anger that cannot explain itself, can act out its frustrations only in inexplicable violence."
            },
            {
            "critic": "Carrie Rickey",
            "date": "2013-04-22",
            "original_score": "3/4",
            "freshness": "fresh",
            "publication": "Philadelphia Inquirer",
            "quote": "Blistering, hallucinatory, often brilliant, the film by David Fincher is a combination punch of social satire and sociopathology."
            },
            {
            "critic": "Joe Morgenstern",
            "date": "2013-04-22",
            "freshness": "rotten",
            "publication": "Wall Street Journal",
            "quote": "Fight Club is an arresting, eventually appalling excursion into social satire by way of punishing violence."
            }
        ] )

playlist.movies << fc
