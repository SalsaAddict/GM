USE [GoodMusic]
GO

DECLARE @Import XML

SET @Import = N'
<GoodMusic>
  <Users>
    <User>
      <Id>10157068522865440</Id>
      <Forename>Pierre</Forename>
      <Surname>Henry</Surname>
      <GenderId>M</GenderId>
      <DateLogged>2016-09-02T11:51:20.0170000Z</DateLogged>
      <GenreId>2</GenreId>
    </User>
  </Users>
  <Videos>
    <Video>
      <Id>1j3QHyBOyhg</Id>
      <Title>Polo Monta�ez - Un Monton De Estrellas (HD)</Title>
      <Thumbnail>https://i.ytimg.com/vi/1j3QHyBOyhg/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:53:51Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>1nFYDsPhWMI</Id>
      <Title>Stony - Danca Kizomba</Title>
      <Thumbnail>https://i.ytimg.com/vi/1nFYDsPhWMI/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:34:23Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>2qCLwI5ZNRA</Id>
      <Title>MARIO BARO - TE QUIERO</Title>
      <Thumbnail>https://i.ytimg.com/vi/2qCLwI5ZNRA/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:10:29Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>3VmoZrxXbmg</Id>
      <Title>Marc Anthony - Flor P�lida</Title>
      <Thumbnail>https://i.ytimg.com/vi/3VmoZrxXbmg/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:52:38Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>7d2wK4C-nRk</Id>
      <Title>Rei Helder - Ela j� Quer (Oficial) (Realiza��o: Wilsoldiers)</Title>
      <Thumbnail>https://i.ytimg.com/vi/7d2wK4C-nRk/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:29:20Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>7y45S6h0DEs</Id>
      <Title>Daniel Santacruz - Lo Dice La Gente (Audio)</Title>
      <Thumbnail>https://i.ytimg.com/vi/7y45S6h0DEs/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T22:08:37Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>AQr2KMpv_gE</Id>
      <Title>Yuri da Cunha feat Suzana Lubrano - SAGACIDADE NO AMOR (Official Video HD)</Title>
      <Thumbnail>https://i.ytimg.com/vi/AQr2KMpv_gE/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:26:23Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>AtbBtFo-e_s</Id>
      <Title>El Gran Combo - Arroz Con Habichuelas [HIGH QUALITY MUSIC]</Title>
      <Thumbnail>https://i.ytimg.com/vi/AtbBtFo-e_s/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:12:19Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>bgCaUiujdXM</Id>
      <Title>EL VERDE DE TUS OJOS [KIKO RODRIGUEZ]</Title>
      <Thumbnail>https://i.ytimg.com/vi/bgCaUiujdXM/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:50:21Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>EwA9NzCkqX0</Id>
      <Title>Yuri da Cunha - Eu cheiro bem</Title>
      <Thumbnail>https://i.ytimg.com/vi/EwA9NzCkqX0/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:28:33Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>FRUBI2Lw5J4</Id>
      <Title>Tony Dize - Super Heroe [Official Audio]</Title>
      <Thumbnail>https://i.ytimg.com/vi/FRUBI2Lw5J4/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T20:49:28Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>g4e1LfmYcFA</Id>
      <Title>Mambo Gallego by Tito Puente</Title>
      <Thumbnail>https://i.ytimg.com/vi/g4e1LfmYcFA/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:16:25Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>Gsz2Na3qyew</Id>
      <Title>ABRE QUE VOY - MIGUEL ENRIQUEZ</Title>
      <Thumbnail>https://i.ytimg.com/vi/Gsz2Na3qyew/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:20:52Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>Gy2OwjHxz7U</Id>
      <Title>LA MAXIMA 79  - LAPIZ Y PAPEL ( Official Video )</Title>
      <Thumbnail>https://i.ytimg.com/vi/Gy2OwjHxz7U/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:13:40Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>HdepIOmowfU</Id>
      <Title>Joan Soriano - Vocales de Amor</Title>
      <Thumbnail>https://i.ytimg.com/vi/HdepIOmowfU/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:38:59Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>HPvpJcR6ICc</Id>
      <Title>Hoja en Blanco - Monchy y Alexandra</Title>
      <Thumbnail>https://i.ytimg.com/vi/HPvpJcR6ICc/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:33:07Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>i8dNizlNwoY</Id>
      <Title>Hector Lavoe - Abuelita.</Title>
      <Thumbnail>https://i.ytimg.com/vi/i8dNizlNwoY/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:57:30Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>iiW5mpAbubQ</Id>
      <Title>New Swing Sextet - Maybe Then</Title>
      <Thumbnail>https://i.ytimg.com/vi/iiW5mpAbubQ/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:18:00Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>KNifUszz2zA</Id>
      <Title>Tito Puente Hong Kong Mambo ( 1958 ) .</Title>
      <Thumbnail>https://i.ytimg.com/vi/KNifUszz2zA/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:15:40Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>-lDsqOsJL7k</Id>
      <Title>Prince Royce - Culpa al Coraz�n (Official Video)</Title>
      <Thumbnail>https://i.ytimg.com/vi/-lDsqOsJL7k/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:11:26Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>MOysl6rVBdM</Id>
      <Title>Adele - Hello (salsa version by MANDINGA)</Title>
      <Thumbnail>https://i.ytimg.com/vi/MOysl6rVBdM/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-09-02T12:02:01.4970000Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>muVvjONiytQ</Id>
      <Title>Mbilia Bel - Douceur</Title>
      <Thumbnail>https://i.ytimg.com/vi/muVvjONiytQ/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:27:19Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>N8ytQ6RPjic</Id>
      <Title>LA MAXIMA 79 - LA GRIPE (Official Page)</Title>
      <Thumbnail>https://i.ytimg.com/vi/N8ytQ6RPjic/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:59:53Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>NOrfzcA6jzI</Id>
      <Title>LA MAXIMA 79 - POBRECITA</Title>
      <Thumbnail>https://i.ytimg.com/vi/NOrfzcA6jzI/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:58:26Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>NPbIA--_CpY</Id>
      <Title>IT''S JEAN "YO QUIERO SABER" LYRICS VIDEO</Title>
      <Thumbnail>https://i.ytimg.com/vi/NPbIA--_CpY/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:38:11Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>NzHsV4HTKoo</Id>
      <Title>LUIS VARGAS  - LOCO DE AMOR 1994</Title>
      <Thumbnail>https://i.ytimg.com/vi/NzHsV4HTKoo/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:39:33Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>PGzizFxT6hw</Id>
      <Title>No Hay Problema - Pink Martini</Title>
      <Thumbnail>https://i.ytimg.com/vi/PGzizFxT6hw/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:13:00Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>QFs3PIZb3js</Id>
      <Title>Romeo Santos - Propuesta Indecente (Official Video)</Title>
      <Thumbnail>https://i.ytimg.com/vi/QFs3PIZb3js/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T22:07:56Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>QFyDwilOTcg</Id>
      <Title>Jr. - Amarte Sin Amarte (OFFICIAL VIDEO)</Title>
      <Thumbnail>https://i.ytimg.com/vi/QFyDwilOTcg/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:18:54Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>tLVbV2XSQuQ</Id>
      <Title>"5 Minutos Mas" - Marco Puma - Official Video</Title>
      <Thumbnail>https://i.ytimg.com/vi/tLVbV2XSQuQ/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:36:35Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>TMq5USWW4vU</Id>
      <Title>Gente de Zona - Traidora (Salsa Version)[Cover Audio] ft. Marc Anthony</Title>
      <Thumbnail>https://i.ytimg.com/vi/TMq5USWW4vU/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:52:07Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>ueyURAcJPOI</Id>
      <Title>Plan B - Fan�tica Sensual (Bachata Version) | Prod. By Lone Lez</Title>
      <Thumbnail>https://i.ytimg.com/vi/ueyURAcJPOI/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-08-12T14:55:03.9130000Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>UN1lwFrDiBE</Id>
      <Title>MONCHY &amp; ALEXANDRA "No Es Una Novela"</Title>
      <Thumbnail>https://i.ytimg.com/vi/UN1lwFrDiBE/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:33:44Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>v5QXju-l6dE</Id>
      <Title>SALSA - NO LE PEGUE A LA NEGRA</Title>
      <Thumbnail>https://i.ytimg.com/vi/v5QXju-l6dE/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T22:06:34Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>X5AxN4pv5vE</Id>
      <Title>Andy &amp; Lucas - Son De Amores (Version Salsa)</Title>
      <Thumbnail>https://i.ytimg.com/vi/X5AxN4pv5vE/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:14:25Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>XDdHgVKt-HU</Id>
      <Title>Saaphy - Side 2 Side (Official Video)</Title>
      <Thumbnail>https://i.ytimg.com/vi/XDdHgVKt-HU/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:54:50Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>yI2ftVFpFds</Id>
      <Title>Grupo Extra - Besos a Escondidas - #BACHATA 2016</Title>
      <Thumbnail>https://i.ytimg.com/vi/yI2ftVFpFds/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T23:10:45Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>yUAZxs3qY3Y</Id>
      <Title>Prince Royce - Te Robar�</Title>
      <Thumbnail>https://i.ytimg.com/vi/yUAZxs3qY3Y/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:33:45Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
    <Video>
      <Id>zM5bRA74-34</Id>
      <Title>LA MAXIMA 79  - SINGAPORE VIBES (Official Video)</Title>
      <Thumbnail>https://i.ytimg.com/vi/zM5bRA74-34/mqdefault.jpg</Thumbnail>
      <DateRecommended>2016-07-21T21:59:08Z</DateRecommended>
      <UserId>10157068522865440</UserId>
    </Video>
  </Videos>
  <Reviews>
    <Review>
      <VideoId>1j3QHyBOyhg</VideoId>
      <GenreId>1</GenreId>
      <StyleId>3</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:53:51Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>1j3QHyBOyhg</VideoId>
      <GenreId>1</GenreId>
      <StyleId>5</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:53:51Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>1nFYDsPhWMI</VideoId>
      <GenreId>3</GenreId>
      <StyleId>12</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:34:23Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>2qCLwI5ZNRA</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:09:55Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>2qCLwI5ZNRA</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:10:30Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>3VmoZrxXbmg</VideoId>
      <GenreId>1</GenreId>
      <StyleId>1</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:52:38Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>7d2wK4C-nRk</VideoId>
      <GenreId>3</GenreId>
      <StyleId>13</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:29:20Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>7y45S6h0DEs</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T22:08:37Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>7y45S6h0DEs</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T22:08:37Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>7y45S6h0DEs</VideoId>
      <GenreId>2</GenreId>
      <StyleId>10</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T22:08:37Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>AQr2KMpv_gE</VideoId>
      <GenreId>3</GenreId>
      <StyleId>11</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:26:23Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>AtbBtFo-e_s</VideoId>
      <GenreId>4</GenreId>
      <StyleId>14</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:12:19Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>bgCaUiujdXM</VideoId>
      <GenreId>2</GenreId>
      <StyleId>7</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:50:21Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>EwA9NzCkqX0</VideoId>
      <GenreId>3</GenreId>
      <StyleId>13</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:28:33Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>FRUBI2Lw5J4</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T20:49:28Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>FRUBI2Lw5J4</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T20:49:28Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>g4e1LfmYcFA</VideoId>
      <GenreId>1</GenreId>
      <StyleId>2</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:16:25Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>Gsz2Na3qyew</VideoId>
      <GenreId>1</GenreId>
      <StyleId>3</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:20:52Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>Gsz2Na3qyew</VideoId>
      <GenreId>1</GenreId>
      <StyleId>4</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:20:52Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>Gy2OwjHxz7U</VideoId>
      <GenreId>4</GenreId>
      <StyleId>14</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:13:40Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>HdepIOmowfU</VideoId>
      <GenreId>2</GenreId>
      <StyleId>7</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:38:59Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>HPvpJcR6ICc</VideoId>
      <GenreId>2</GenreId>
      <StyleId>7</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:33:07Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>HPvpJcR6ICc</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:33:07Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>i8dNizlNwoY</VideoId>
      <GenreId>1</GenreId>
      <StyleId>2</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:57:30Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>iiW5mpAbubQ</VideoId>
      <GenreId>1</GenreId>
      <StyleId>2</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:18:00Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>KNifUszz2zA</VideoId>
      <GenreId>1</GenreId>
      <StyleId>2</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:15:40Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>-lDsqOsJL7k</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:11:26Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>-lDsqOsJL7k</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:11:26Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>MOysl6rVBdM</VideoId>
      <GenreId>1</GenreId>
      <StyleId>1</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-09-02T12:02:01.5000000Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>MOysl6rVBdM</VideoId>
      <GenreId>1</GenreId>
      <StyleId>3</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-09-02T12:02:01.5000000Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>muVvjONiytQ</VideoId>
      <GenreId>3</GenreId>
      <StyleId>11</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:27:19Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>N8ytQ6RPjic</VideoId>
      <GenreId>1</GenreId>
      <StyleId>1</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:59:53Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>N8ytQ6RPjic</VideoId>
      <GenreId>1</GenreId>
      <StyleId>2</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:59:53Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>NOrfzcA6jzI</VideoId>
      <GenreId>1</GenreId>
      <StyleId>1</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:58:26Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>NOrfzcA6jzI</VideoId>
      <GenreId>1</GenreId>
      <StyleId>2</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:58:26Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>NPbIA--_CpY</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:38:11Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>NPbIA--_CpY</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:38:11Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>NzHsV4HTKoo</VideoId>
      <GenreId>2</GenreId>
      <StyleId>7</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:39:33Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>PGzizFxT6hw</VideoId>
      <GenreId>4</GenreId>
      <StyleId>14</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:13:00Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>QFs3PIZb3js</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T22:07:56Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>QFs3PIZb3js</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T22:07:56Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>QFs3PIZb3js</VideoId>
      <GenreId>2</GenreId>
      <StyleId>10</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T22:07:56Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>QFyDwilOTcg</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:18:54Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>QFyDwilOTcg</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:18:54Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>tLVbV2XSQuQ</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:36:35Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>tLVbV2XSQuQ</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:36:35Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>TMq5USWW4vU</VideoId>
      <GenreId>1</GenreId>
      <StyleId>1</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:52:07Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>TMq5USWW4vU</VideoId>
      <GenreId>1</GenreId>
      <StyleId>3</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:52:07Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>ueyURAcJPOI</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-08-12T14:55:03.9130000Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>ueyURAcJPOI</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-08-12T14:55:03.9130000Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>UN1lwFrDiBE</VideoId>
      <GenreId>2</GenreId>
      <StyleId>7</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:33:44Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>UN1lwFrDiBE</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:33:44Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>v5QXju-l6dE</VideoId>
      <GenreId>1</GenreId>
      <StyleId>6</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T22:06:34Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>X5AxN4pv5vE</VideoId>
      <GenreId>1</GenreId>
      <StyleId>1</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:14:25Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>X5AxN4pv5vE</VideoId>
      <GenreId>1</GenreId>
      <StyleId>3</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:14:25Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>XDdHgVKt-HU</VideoId>
      <GenreId>3</GenreId>
      <StyleId>12</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:54:50Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>yI2ftVFpFds</VideoId>
      <GenreId>2</GenreId>
      <StyleId>7</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-09-01T10:44:16.0400000Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>yI2ftVFpFds</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:10:45Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>yI2ftVFpFds</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T23:10:45Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>yUAZxs3qY3Y</VideoId>
      <GenreId>2</GenreId>
      <StyleId>8</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:33:45Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>yUAZxs3qY3Y</VideoId>
      <GenreId>2</GenreId>
      <StyleId>9</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:33:45Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>zM5bRA74-34</VideoId>
      <GenreId>1</GenreId>
      <StyleId>1</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:59:08Z</DateReviewed>
      <Like>1</Like>
    </Review>
    <Review>
      <VideoId>zM5bRA74-34</VideoId>
      <GenreId>1</GenreId>
      <StyleId>2</StyleId>
      <UserId>10157068522865440</UserId>
      <DateReviewed>2016-07-21T21:59:08Z</DateReviewed>
      <Like>1</Like>
    </Review>
  </Reviews>
</GoodMusic>'

EXEC [apiImport] @Import, 1
