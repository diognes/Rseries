# Simple examples

# palette_netflyx
serie_palette("Lupin", palette_netflyx, n=4, type="discrete")

serie_palette("Lupin", palette_netflyx, 9)

serie_palette("Lupin", palette_netflyx, 20)

serie_palette("Lupin", palette_netflyx, 50, type="continuous")

# palette_anime
serie_palette("poke", palette_anime, n=4, type="discrete")

serie_palette("poke", palette_anime, 9)

serie_palette("poke", palette_anime, 20)

serie_palette("poke", palette_anime, 50, type="continuous")

# all palette_anime in display
names_anime = names(palette_anime)
for (i in 1:length(names_anime)) {
  names_anime[i]
  serie_palette(names_anime[i], palette_anime, 9, type="continuous")
}

serie_palette(names_anime[10], palette_anime, 9, type="continuous")
