##============================================================================##
# _preparar_canciones_s12.R  —  la base real de canciones urbanas de la clase 12
#------------------------------------------------------------------------------#
# Solo para el profesor. Descarga la base pública de canciones de Spotify del
# proyecto TidyTuesday (2020-01-21, construida con spotifyr), se queda con el
# género urbano (reggaeton y latin hip hop, sin duplicados) y deja las columnas
# de la clase en español. La popularidad de Spotify (0-100) resume las
# reproducciones recientes de cada canción. Escribe
# ../script/canciones_urbanas.csv (grano: canción), que la clase lee desde la
# URL de la página del curso.
# Correr desde lectures/week-12/input/:  Rscript _preparar_canciones_s12.R
##============================================================================##
rm(list = ls())
options(warn = 2)
suppressMessages(library(dplyr))

url_fuente <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv"
spotify <- read.csv(url_fuente)

canciones <- spotify %>%
             filter(playlist_genre == "latin",
                    playlist_subgenre %in% c("reggaeton", "latin hip hop"),
                    !is.na(track_artist), !is.na(track_popularity)) %>%
             distinct(track_id, .keep_all = TRUE) %>%
             transmute(cancion      = track_name,
                       artista      = track_artist,
                       subgenero    = playlist_subgenre,
                       popularidad  = track_popularity,
                       anio         = as.integer(substr(track_album_release_date, 1, 4)),
                       bailabilidad = round(100 * danceability),
                       energia      = round(100 * energy),
                       tempo        = round(tempo),
                       duracion_seg = round(duration_ms / 1000),
                       colaboracion = as.integer(grepl("feat|ft\\.| x ", tolower(track_name))))

## la trayectoria del artista: el promedio de popularidad de sus otras
## canciones en el catalogo; si solo tiene una, el promedio general
prom_catalogo <- round(mean(canciones$popularidad), 1)
canciones <- canciones %>%
             group_by(artista) %>%
             mutate(pop_artista = ifelse(n() > 1,
                      round((sum(popularidad) - popularidad) / (n() - 1), 1),
                      prom_catalogo)) %>%
             ungroup()

## export data
write.csv(canciones, "../script/canciones_urbanas.csv", row.names = F)
cat("canciones_urbanas.csv:", nrow(canciones), "filas x", ncol(canciones), "columnas\n")
