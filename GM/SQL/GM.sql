--USE [master]; DROP DATABASE [GoodMusic]; CREATE DATABASE [GoodMusic];
USE [GoodMusic]
GO

SET NOCOUNT ON
GO

IF OBJECT_ID(N'apiImport', N'P') IS NOT NULL DROP PROCEDURE [apiImport]
IF OBJECT_ID(N'apiExport', N'P') IS NOT NULL DROP PROCEDURE [apiExport]
IF OBJECT_ID(N'apiRecommend', N'P') IS NOT NULL DROP PROCEDURE [apiRecommend]
IF OBJECT_ID(N'apiReview', N'P') IS NOT NULL DROP PROCEDURE [apiReview]
IF OBJECT_ID(N'apiReviews', N'P') IS NOT NULL DROP PROCEDURE [apiReviews]
IF OBJECT_ID(N'apiVideo', N'P') IS NOT NULL DROP PROCEDURE [apiVideo]
IF OBJECT_ID(N'apiVideos', N'P') IS NOT NULL DROP PROCEDURE [apiVideos]
IF OBJECT_ID(N'apiStyles', N'P') IS NOT NULL DROP PROCEDURE [apiStyles]
IF OBJECT_ID(N'apiGenres', N'P') IS NOT NULL DROP PROCEDURE [apiGenres]
IF OBJECT_ID(N'apiUserSettingsSave', N'P') IS NOT NULL DROP PROCEDURE [apiUserSettingsSave]
IF OBJECT_ID(N'apiUserSettings', N'P') IS NOT NULL DROP PROCEDURE [apiUserSettings]
IF OBJECT_ID(N'apiLogin', N'P') IS NOT NULL DROP PROCEDURE [apiLogin]
IF OBJECT_ID(N'Review', N'U') IS NOT NULL DROP TABLE [Review]
IF OBJECT_ID(N'Video', N'U') IS NOT NULL DROP TABLE [Video]
IF OBJECT_ID(N'User', N'U') IS NOT NULL DROP TABLE [User]
IF OBJECT_ID(N'Gender', N'U') IS NOT NULL DROP TABLE [Gender]
IF OBJECT_ID(N'Country', N'U') IS NOT NULL DROP TABLE [Country]
IF OBJECT_ID(N'Style', N'U') IS NOT NULL DROP TABLE [Style]
IF OBJECT_ID(N'Genre', N'U') IS NOT NULL DROP TABLE [Genre]
GO

CREATE TABLE [Genre] (
	[Id] INT NOT NULL IDENTITY (1, 1),
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_Genre] PRIMARY KEY NONCLUSTERED ([Id]),
	CONSTRAINT [UQ_Genre_Name] UNIQUE CLUSTERED ([Name])
)
GO

CREATE TABLE [Style] (
	[GenreId] INT NOT NULL,
	[Id] INT NOT NULL IDENTITY (1, 1),
	[Name] NVARCHAR(255) NOT NULL,
	[Sort] INT NOT NULL,
	CONSTRAINT [PK_Style] PRIMARY KEY NONCLUSTERED ([GenreId], [Id]),
	CONSTRAINT [UQ_Style_Id] UNIQUE ([Id]),
	CONSTRAINT [UQ_Style_Name] UNIQUE ([GenreId], [Name]),
	CONSTRAINT [UQ_Style_Sort] UNIQUE CLUSTERED ([GenreId], [Sort]),
	CONSTRAINT [FK_Style_Genre] FOREIGN KEY ([GenreId]) REFERENCES [Genre] ([Id])
)
GO

SET IDENTITY_INSERT [Genre] ON
INSERT INTO [Genre] ([Id], [Name])
VALUES
	(1, N'Salsa'),
	(2, N'Bachata'),
	(3, N'Kizomba'),
	(4, N'Cha Cha Chá')
SET IDENTITY_INSERT [Genre] OFF
GO

INSERT INTO [Style] ([GenreId], [Name], [Sort])
VALUES
	(1, N'Cross-Body On1', 1),
	(1, N'Cross-Body On2', 2),
	(1, N'Cuban Casino', 3),
	(1, N'La Rueda de Casino', 4),
	(1, N'Son/Contratiempo', 5),
	(1, N'Colombian/Cali', 6),
	(2, N'Dominican Bachata', 1),
	(2, N'Bachata Moderna', 2),
	(2, N'Sensual Bachata', 3),
	(2, N'BachaTango', 4),
	(3, N'Kizomba', 1),
	(3, N'Urban Kiz', 2),
	(3, N'Semba', 3),
	(4, N'Cha Cha Chá', 1)
GO

CREATE TABLE [Country] (
	[Id] NCHAR(2) NOT NULL,
	[Name] NVARCHAR(255) NOT NULL,
	CONSTRAINT [PK_Country] PRIMARY KEY NONCLUSTERED ([Id]),
	CONSTRAINT [UQ_Country_Name] UNIQUE CLUSTERED ([Name])
)
GO

INSERT INTO [Country] ([Id], [Name])
VALUES
	(N'AD', N'Andorra'),
	(N'AE', N'United Arab Emirates'),
	(N'AF', N'Afghanistan'),
	(N'AG', N'Antigua and Barbuda'),
	(N'AI', N'Anguilla'),
	(N'AL', N'Albania'),
	(N'AM', N'Armenia'),
	(N'AO', N'Angola'),
	(N'AQ', N'Antarctica'),
	(N'AR', N'Argentina'),
	(N'AS', N'American Samoa'),
	(N'AT', N'Austria'),
	(N'AU', N'Australia'),
	(N'AW', N'Aruba'),
	(N'AX', N'Åland Islands'),
	(N'AZ', N'Azerbaijan'),
	(N'BA', N'Bosnia and Herzegovina'),
	(N'BB', N'Barbados'),
	(N'BD', N'Bangladesh'),
	(N'BE', N'Belgium'),
	(N'BF', N'Burkina Faso'),
	(N'BG', N'Bulgaria'),
	(N'BH', N'Bahrain'),
	(N'BI', N'Burundi'),
	(N'BJ', N'Benin'),
	(N'BL', N'Saint Barthélemy'),
	(N'BM', N'Bermuda'),
	(N'BN', N'Brunei Darussalam'),
	(N'BO', N'Bolivia, Plurinational State of'),
	(N'BQ', N'Bonaire, Sint Eustatius and Saba'),
	(N'BR', N'Brazil'),
	(N'BS', N'Bahamas'),
	(N'BT', N'Bhutan'),
	(N'BV', N'Bouvet Island'),
	(N'BW', N'Botswana'),
	(N'BY', N'Belarus'),
	(N'BZ', N'Belize'),
	(N'CA', N'Canada'),
	(N'CC', N'Cocos (Keeling) Islands'),
	(N'CD', N'Congo, the Democratic Republic of the'),
	(N'CF', N'Central African Republic'),
	(N'CG', N'Congo'),
	(N'CH', N'Switzerland'),
	(N'CI', N'Côte d''Ivoire'),
	(N'CK', N'Cook Islands'),
	(N'CL', N'Chile'),
	(N'CM', N'Cameroon'),
	(N'CN', N'China'),
	(N'CO', N'Colombia'),
	(N'CR', N'Costa Rica'),
	(N'CU', N'Cuba'),
	(N'CV', N'Cabo Verde'),
	(N'CW', N'Curaçao'),
	(N'CX', N'Christmas Island'),
	(N'CY', N'Cyprus'),
	(N'CZ', N'Czech Republic'),
	(N'DE', N'Germany'),
	(N'DJ', N'Djibouti'),
	(N'DK', N'Denmark'),
	(N'DM', N'Dominica'),
	(N'DO', N'Dominican Republic'),
	(N'DZ', N'Algeria'),
	(N'EC', N'Ecuador'),
	(N'EE', N'Estonia'),
	(N'EG', N'Egypt'),
	(N'EH', N'Western Sahara'),
	(N'ER', N'Eritrea'),
	(N'ES', N'Spain'),
	(N'ET', N'Ethiopia'),
	(N'FI', N'Finland'),
	(N'FJ', N'Fiji'),
	(N'FK', N'Falkland Islands (Malvinas)'),
	(N'FM', N'Micronesia, Federated States of'),
	(N'FO', N'Faroe Islands'),
	(N'FR', N'France'),
	(N'GA', N'Gabon'),
	(N'GB', N'United Kingdom of Great Britain and Northern Ireland'),
	(N'GD', N'Grenada'),
	(N'GE', N'Georgia'),
	(N'GF', N'French Guiana'),
	(N'GG', N'Guernsey'),
	(N'GH', N'Ghana'),
	(N'GI', N'Gibraltar'),
	(N'GL', N'Greenland'),
	(N'GM', N'Gambia'),
	(N'GN', N'Guinea'),
	(N'GP', N'Guadeloupe'),
	(N'GQ', N'Equatorial Guinea'),
	(N'GR', N'Greece'),
	(N'GS', N'South Georgia and the South Sandwich Islands'),
	(N'GT', N'Guatemala'),
	(N'GU', N'Guam'),
	(N'GW', N'Guinea-Bissau'),
	(N'GY', N'Guyana'),
	(N'HK', N'Hong Kong'),
	(N'HM', N'Heard Island and McDonald Islands'),
	(N'HN', N'Honduras'),
	(N'HR', N'Croatia'),
	(N'HT', N'Haiti'),
	(N'HU', N'Hungary'),
	(N'ID', N'Indonesia'),
	(N'IE', N'Ireland'),
	(N'IL', N'Israel'),
	(N'IM', N'Isle of Man'),
	(N'IN', N'India'),
	(N'IO', N'British Indian Ocean Territory'),
	(N'IQ', N'Iraq'),
	(N'IR', N'Iran, Islamic Republic of'),
	(N'IS', N'Iceland'),
	(N'IT', N'Italy'),
	(N'JE', N'Jersey'),
	(N'JM', N'Jamaica'),
	(N'JO', N'Jordan'),
	(N'JP', N'Japan'),
	(N'KE', N'Kenya'),
	(N'KG', N'Kyrgyzstan'),
	(N'KH', N'Cambodia'),
	(N'KI', N'Kiribati'),
	(N'KM', N'Comoros'),
	(N'KN', N'Saint Kitts and Nevis'),
	(N'KP', N'Korea, Democratic People''s Republic of'),
	(N'KR', N'Korea, Republic of'),
	(N'KW', N'Kuwait'),
	(N'KY', N'Cayman Islands'),
	(N'KZ', N'Kazakhstan'),
	(N'LA', N'Lao People''s Democratic Republic'),
	(N'LB', N'Lebanon'),
	(N'LC', N'Saint Lucia'),
	(N'LI', N'Liechtenstein'),
	(N'LK', N'Sri Lanka'),
	(N'LR', N'Liberia'),
	(N'LS', N'Lesotho'),
	(N'LT', N'Lithuania'),
	(N'LU', N'Luxembourg'),
	(N'LV', N'Latvia'),
	(N'LY', N'Libya'),
	(N'MA', N'Morocco'),
	(N'MC', N'Monaco'),
	(N'MD', N'Moldova, Republic of'),
	(N'ME', N'Montenegro'),
	(N'MF', N'Saint Martin (French part)'),
	(N'MG', N'Madagascar'),
	(N'MH', N'Marshall Islands'),
	(N'MK', N'Macedonia, the former Yugoslav Republic of'),
	(N'ML', N'Mali'),
	(N'MM', N'Myanmar'),
	(N'MN', N'Mongolia'),
	(N'MO', N'Macao'),
	(N'MP', N'Northern Mariana Islands'),
	(N'MQ', N'Martinique'),
	(N'MR', N'Mauritania'),
	(N'MS', N'Montserrat'),
	(N'MT', N'Malta'),
	(N'MU', N'Mauritius'),
	(N'MV', N'Maldives'),
	(N'MW', N'Malawi'),
	(N'MX', N'Mexico'),
	(N'MY', N'Malaysia'),
	(N'MZ', N'Mozambique'),
	(N'NA', N'Namibia'),
	(N'NC', N'New Caledonia'),
	(N'NE', N'Niger'),
	(N'NF', N'Norfolk Island'),
	(N'NG', N'Nigeria'),
	(N'NI', N'Nicaragua'),
	(N'NL', N'Netherlands'),
	(N'NO', N'Norway'),
	(N'NP', N'Nepal'),
	(N'NR', N'Nauru'),
	(N'NU', N'Niue'),
	(N'NZ', N'New Zealand'),
	(N'OM', N'Oman'),
	(N'PA', N'Panama'),
	(N'PE', N'Peru'),
	(N'PF', N'French Polynesia'),
	(N'PG', N'Papua New Guinea'),
	(N'PH', N'Philippines'),
	(N'PK', N'Pakistan'),
	(N'PL', N'Poland'),
	(N'PM', N'Saint Pierre and Miquelon'),
	(N'PN', N'Pitcairn'),
	(N'PR', N'Puerto Rico'),
	(N'PS', N'Palestine, State of'),
	(N'PT', N'Portugal'),
	(N'PW', N'Palau'),
	(N'PY', N'Paraguay'),
	(N'QA', N'Qatar'),
	(N'RE', N'Réunion'),
	(N'RO', N'Romania'),
	(N'RS', N'Serbia'),
	(N'RU', N'Russian Federation'),
	(N'RW', N'Rwanda'),
	(N'SA', N'Saudi Arabia'),
	(N'SB', N'Solomon Islands'),
	(N'SC', N'Seychelles'),
	(N'SD', N'Sudan'),
	(N'SE', N'Sweden'),
	(N'SG', N'Singapore'),
	(N'SH', N'Saint Helena, Ascension and Tristan da Cunha'),
	(N'SI', N'Slovenia'),
	(N'SJ', N'Svalbard and Jan Mayen'),
	(N'SK', N'Slovakia'),
	(N'SL', N'Sierra Leone'),
	(N'SM', N'San Marino'),
	(N'SN', N'Senegal'),
	(N'SO', N'Somalia'),
	(N'SR', N'Suriname'),
	(N'SS', N'South Sudan'),
	(N'ST', N'Sao Tome and Principe'),
	(N'SV', N'El Salvador'),
	(N'SX', N'Sint Maarten (Dutch part)'),
	(N'SY', N'Syrian Arab Republic'),
	(N'SZ', N'Swaziland'),
	(N'TC', N'Turks and Caicos Islands'),
	(N'TD', N'Chad'),
	(N'TF', N'French Southern Territories'),
	(N'TG', N'Togo'),
	(N'TH', N'Thailand'),
	(N'TJ', N'Tajikistan'),
	(N'TK', N'Tokelau'),
	(N'TL', N'Timor-Leste'),
	(N'TM', N'Turkmenistan'),
	(N'TN', N'Tunisia'),
	(N'TO', N'Tonga'),
	(N'TR', N'Turkey'),
	(N'TT', N'Trinidad and Tobago'),
	(N'TV', N'Tuvalu'),
	(N'TW', N'Taiwan, Province of China'),
	(N'TZ', N'Tanzania, United Republic of'),
	(N'UA', N'Ukraine'),
	(N'UG', N'Uganda'),
	(N'UM', N'United States Minor Outlying Islands'),
	(N'US', N'United States of America'),
	(N'UY', N'Uruguay'),
	(N'UZ', N'Uzbekistan'),
	(N'VA', N'Holy See'),
	(N'VC', N'Saint Vincent and the Grenadines'),
	(N'VE', N'Venezuela, Bolivarian Republic of'),
	(N'VG', N'Virgin Islands, British'),
	(N'VI', N'Virgin Islands, U.S.'),
	(N'VN', N'Viet Nam'),
	(N'VU', N'Vanuatu'),
	(N'WF', N'Wallis and Futuna'),
	(N'WS', N'Samoa'),
	(N'YE', N'Yemen'),
	(N'YT', N'Mayotte'),
	(N'ZA', N'South Africa'),
	(N'ZM', N'Zambia'),
	(N'ZW', N'Zimbabwe')
GO

CREATE TABLE [Gender] (
	[Id] NCHAR(1) NOT NULL,
	[Name] NVARCHAR(6) NOT NULL,
	CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [UQ_Gender_Name] UNIQUE ([Name])
)
GO

INSERT INTO [Gender] ([Id], [Name])
VALUES
	(N'M', N'Male'),
	(N'F', N'Female')
GO

CREATE TABLE [User] (
	[Id] NVARCHAR(25) NOT NULL,
	[Forename] NVARCHAR(127) NOT NULL,
	[Surname] NVARCHAR(127) NOT NULL,
	[Name] AS [Forename] + N' ' + [Surname] PERSISTED,
	[GenderId] NCHAR(1) NULL,
	[CountryId] NCHAR(2) NULL,
	[DateLogged] DATETIMEOFFSET NOT NULL,
	[GenreId] INT NULL,
	[StyleId] INT NULL,
	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_User_Gender] FOREIGN KEY ([GenderId]) REFERENCES [Gender] ([Id]),
	CONSTRAINT [FK_User_Country] FOREIGN KEY ([CountryId]) REFERENCES [Country] ([Id]),
	CONSTRAINT [FK_User_Genre] FOREIGN KEY ([GenreId]) REFERENCES [Genre] ([Id]),
	CONSTRAINT [FK_User_Style] FOREIGN KEY ([StyleId]) REFERENCES [Style] ([Id]),
)
GO

CREATE INDEX [IX_User_Name] ON [User] ([Name])
GO

CREATE TABLE [Video] (
	[Id] NVARCHAR(25) NOT NULL,
	[Title] NVARCHAR(255) NOT NULL,
	[Thumbnail] NVARCHAR(max) NULL,
	[DateRecommended] DATETIMEOFFSET NOT NULL,
	[UserId] NVARCHAR(25) NOT NULL,
	CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED ([Id]),
	CONSTRAINT [FK_Video_User] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
)
GO

CREATE TABLE [Review] (
	[VideoId] NVARCHAR(25) NOT NULL,
	[GenreId] INT NOT NULL,
	[StyleId] INT NOT NULL,
	[UserId] NVARCHAR(25) NOT NULL,
	[DateReviewed] DATETIMEOFFSET NOT NULL,
	[Like] BIT NOT NULL,
	CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED ([VideoId], [GenreId], [StyleId], [UserId]),
	CONSTRAINT [FK_Review_Video] FOREIGN KEY ([VideoId]) REFERENCES [Video] ([Id]),
	CONSTRAINT [FK_Review_Style] FOREIGN KEY ([GenreId], [StyleId]) REFERENCES [Style] ([GenreId], [Id]),
	CONSTRAINT [FK_Review_User] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
)
GO

CREATE INDEX [IX_Review_Video] ON [Review] ([VideoId], [GenreId]) INCLUDE ([StyleId], [UserId], [Like])
GO

CREATE PROCEDURE [apiLogin](
	@UserId NVARCHAR(25),
	@Forename NVARCHAR(127),
	@Surname NVARCHAR(127),
	@Gender NVARCHAR(6) = NULL,
	@CountryId NCHAR(2) = NULL
)
AS
BEGIN
	MERGE [User] t
	USING (
			SELECT
				[UserId] = @UserId,
				[Forename] = @Forename,
				[Surname] = @Surname,
				[GenderId] = (SELECT [Id] FROM [Gender] WHERE [Name] = @Gender),
				[CountryId] = (SELECT [Id] FROM [Country] WHERE [Id] = @CountryId),
				[DateLogged] = GETUTCDATE()
		) s
	ON t.[Id] = s.[UserId]
	WHEN MATCHED THEN
		UPDATE
		SET
			[Forename] = s.[Forename],
			[Surname] = s.[Surname],
			[GenderId] = s.[GenderId],
			[CountryId] = s.[CountryId],
			[DateLogged] = s.[DateLogged]
	WHEN NOT MATCHED THEN
		INSERT ([Id], [Forename], [Surname], [GenderId], [CountryId], [DateLogged])
		VALUES (s.[UserId], s.[Forename], s.[Surname], s.[GenderId], s.[CountryId], s.[DateLogged]);
	SELECT @UserId FOR XML PATH (N'UserId'), ROOT (N'Data')
END
GO

CREATE PROCEDURE [apiUserSettings](@UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SELECT 
		(SELECT (
				SELECT
					[Id] = g.[Id],
					[Name] = g.[Name]
				FROM [User] u
					JOIN [Genre] g ON u.[GenreId] = g.[Id]
				WHERE u.[Id] = @UserId
				FOR XML PATH (N''), TYPE
			) FOR XML PATH (N'Genre'), TYPE),
		(SELECT (
				SELECT
					[Id] = s.[Id],
					[Name] = s.[Name]
				FROM [User] u
					JOIN [Style] s ON u.[GenreId] = s.[GenreId] AND u.[StyleId] = s.[Id]
				WHERE u.[Id] = @UserId
				FOR XML PATH (N''), TYPE
			) FOR XML PATH (N'Style'), TYPE)
	FOR XML PATH (N'Data')
	RETURN
END
GO

CREATE PROCEDURE [apiGenres](@UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	;WITH XMLNAMESPACES (N'http://james.newtonking.com/projects/json' AS [json])
	SELECT
		[@json:Array] = N'true',
		[Id],
		[Name]
	FROM [Genre] WITH (NOLOCK)
	ORDER BY [Name]
	FOR XML PATH (N'Genres'), ROOT (N'Data')
	RETURN
END
GO

CREATE PROCEDURE [apiStyles](@GenreId INT, @UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	;WITH XMLNAMESPACES (N'http://james.newtonking.com/projects/json' AS [json])
	SELECT
		[@json:Array] = N'true',
		[Id],
		[Name]
	FROM [Style] WITH (NOLOCK)
	WHERE [GenreId] = @GenreId
	ORDER BY [GenreId], [Sort]
	FOR XML PATH (N'Styles'), ROOT (N'Data')
	RETURN
END
GO

CREATE PROCEDURE [apiVideos](@GenreId INT = NULL, @StyleId INT = NULL, @UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	IF @UserId IS NOT NULL BEGIN
		UPDATE [User]
		SET
			[GenreId] = @GenreId,
			[StyleId] = @StyleId
		WHERE [Id] = @UserId
	END

	;WITH XMLNAMESPACES (N'http://james.newtonking.com/projects/json' AS [json]),
	[Videos] AS (
			SELECT
				[VideoId] = v.[Id],
				[Title] = v.[Title],
				[Thumbnail] = v.[Thumbnail],
				[GenreId] = r.[GenreId],
				[Genre] = g.[Name],
				[Likes] = COUNT(NULLIF(r.[Like], 0)),
				[Dislikes] = COUNT(NULLIF(r.[Like], 1)),
				[Reviews] = COUNT(*)
			FROM [Video] v WITH (NOLOCK)
				JOIN [Review] r WITH (NOLOCK) ON v.[Id] = r.[VideoId]
					AND r.[GenreId] = ISNULL(@GenreId, r.[GenreId])
					AND r.[StyleId] = ISNULL(@StyleId, r.[StyleId])
				JOIN [Genre] g ON r.[GenreId] = g.[Id]
			GROUP BY v.[Id], v.[Title], v.[Thumbnail], r.[GenreId], g.[Name]
		)
	SELECT (
			SELECT
				[@json:Array] = N'true',
				[VideoId],
				[Title],
				[Thumbnail],
				[GenreId],
				[Genre],
				[Likes],
				[Dislikes],
				[Reviews],
				[Rating] = CONVERT(DECIMAL(3, 2), ROUND(CONVERT(FLOAT, [Likes]) / CONVERT(FLOAT, [Reviews]), 2))
			FROM [Videos] WITH (NOLOCK)
			ORDER BY [Rating] DESC, [Reviews] DESC, [Likes] DESC, [Dislikes]
			FOR XML PATH (N'Videos'), TYPE
		)
	FOR XML PATH (N'Data')
	RETURN
END
GO

CREATE PROCEDURE [apiVideo](@VideoId NVARCHAR(25), @GenreId INT, @UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	;WITH XMLNAMESPACES (N'http://james.newtonking.com/projects/json' AS [json])
	SELECT
		[VideoId] = v.[Id],
		[Title] = v.[Title],
		[Thumbnail] = v.[Thumbnail],
		[Genre] = g.[Name],
		[DateRecommended] = v.[DateRecommended],
		[RecommendedBy] = u.[Name]
	FROM [Video] v
		JOIN [User] u ON v.[UserId] = u.[Id]
		JOIN [Genre] g ON g.[Id] = @GenreId
	WHERE v.[Id] = @VideoId
	FOR XML PATH (N'Video'), ROOT (N'Data')
	RETURN
END
GO

CREATE PROCEDURE [apiReviews](@VideoId NVARCHAR(25), @GenreId INT, @UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	;WITH XMLNAMESPACES (N'http://james.newtonking.com/projects/json' AS [json])
	SELECT
		[@json:Array] = N'true',
		[StyleId] = s.[Id],
		[Style] = s.[Name],
		[Like] = CONVERT(BIT, MAX(CASE WHEN r.[UserId] = @UserId AND r.[Like] = 1 THEN 1 ELSE 0 END)),
		[Likes] = COUNT(NULLIF(r.[Like], 0)),
		[Dislike] = CONVERT(BIT, MAX(CASE WHEN r.[UserId] = @UserId AND r.[Like] = 0 THEN 1 ELSE 0 END)),
		[Dislikes] = COUNT(NULLIF(r.[Like], 1)),
		[Rating] = CONVERT(DECIMAL(3,2), ISNULL(ROUND(CONVERT(FLOAT, ISNULL(COUNT(NULLIF(r.[Like], 0)), 0)) / CONVERT(FLOAT, NULLIF(COUNT(r.[Like]), 0)), 2), 0)),
		[Reviews] = COUNT(r.[Like])
	FROM [Style] s WITH (NOLOCK)
		LEFT JOIN [Review] r WITH (NOLOCK) ON @VideoId = r.[VideoId] AND s.[GenreId] = r.[GenreId] AND s.[Id] = r.[StyleId]
	WHERE s.[GenreId] = @GenreId
	GROUP BY s.[Id], s.[Name], s.[Sort]
	ORDER BY s.[Sort]
	FOR XML PATH (N'Reviews'), ROOT (N'Data')
	RETURN
END
GO

CREATE PROCEDURE [apiReview](
	@VideoId NVARCHAR(25),
	@GenreId INT,
	@StyleId INT,
	@UserId NVARCHAR(25),
	@Like BIT
)
AS
BEGIN

	MERGE [Review] t
	USING (
			SELECT
				[VideoId] = @VideoId,
				[GenreId] = @GenreId,
				[StyleId] = @StyleId,
				[UserId] = @UserId,
				[DateReviewed] = GETUTCDATE(),
				[Like] = @Like
		) s
	ON t.[VideoId] = s.[VideoId] AND t.[GenreId] = s.[GenreId] AND t.[StyleId] = s.[StyleId] AND t.[UserId] = s.[UserId]
	WHEN MATCHED AND s.[Like] != t.[Like] THEN
		UPDATE
		SET
			[DateReviewed] = s.[DateReviewed],
			[Like] = s.[Like]
	WHEN MATCHED AND s.[Like] = t.[Like] THEN DELETE
	WHEN NOT MATCHED THEN
		INSERT ([VideoId], [GenreId], [StyleId], [UserId], [DateReviewed], [Like])
		VALUES (s.[VideoId], s.[GenreId], s.[StyleId], s.[UserId], s.[DateReviewed], s.[Like]);
	
	EXEC [apiReviews] @VideoId, @GenreId, @UserId

END
GO

CREATE PROCEDURE [apiRecommend](
	@VideoId NVARCHAR(255),
	@Title NVARCHAR(255),
	@Thumbnail NVARCHAR(max) = NULL,
	@Styles XML,
	@UserId NVARCHAR(25)
)
AS
BEGIN
	
	MERGE [Video] t
	USING (
			SELECT
				[Id] = @VideoId,
				[Title] = @Title,
				[Thumbnail] = @Thumbnail,
				[DateRecommended] = GETUTCDATE(),
				[UserId] = @UserId
		) s
	ON t.[Id] = s.[Id]
	WHEN MATCHED THEN
		UPDATE
		SET
			[Title] = s.[Title],
			[Thumbnail] = s.[Thumbnail]
	WHEN NOT MATCHED THEN
		INSERT ([Id], [Title], [Thumbnail], [DateRecommended], [UserId])
		VALUES (s.[Id], s.[Title], s.[Thumbnail], s.[DateRecommended], s.[UserId]);

	MERGE [Review] t
	USING (
			SELECT
				[VideoId] = @VideoId,
				[GenreId] = ds.[GenreId],
				[StyleId] = ds.[Id],
				[UserId] = @UserId,
				[DateReviewed] = GETUTCDATE(),
				[Like] = CONVERT(BIT, 1)
			FROM @Styles.nodes(N'//data[Checked="true"]') x ([Style])
				JOIN [Style] ds ON [Style].value(N'Id[1]', N'INT') = ds.[Id]
		) s
	ON t.[VideoId] = s.[VideoId] AND t.[GenreId] = s.[GenreId] AND t.[StyleId] = s.[StyleId] AND t.[UserId] = s.[UserId]
	WHEN MATCHED THEN
		UPDATE
		SET
			[DateReviewed] = s.[DateReviewed],
			[Like] = s.[Like]
	WHEN NOT MATCHED THEN
		INSERT ([VideoId], [GenreId], [StyleId], [UserId], [DateReviewed], [Like])
		VALUES (s.[VideoId], s.[GenreId], s.[StyleId], s.[UserId], s.[DateReviewed], s.[Like]);

	SELECT * FROM [Video] FOR XML PATH (N'Video'), ROOT (N'Recommend')
	RETURN
END
GO

CREATE PROCEDURE [apiExport](@UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	SELECT
		( -- Users
				SELECT
					[Id],
					[Forename],
					[Surname],
					[GenderId],
					[CountryId],
					[DateLogged],
					[GenreId],
					[StyleId]
				FROM [User]
				FOR XML PATH (N'User'), ROOT (N'Users'), TYPE
			),
		( -- Videos
				SELECT
					[Id],
					[Title],
					[Thumbnail],
					[DateRecommended],
					[UserId]
				FROM [Video]
				FOR XML PATH (N'Video'), ROOT (N'Videos'), TYPE
			),
		( -- Reviews
				SELECT
					[VideoId],
					[GenreId],
					[StyleId],
					[UserId],
					[DateReviewed],
					[Like]
				FROM [Review]
				FOR XML PATH (N'Review'), ROOT (N'Reviews'), TYPE
			)
	FOR XML PATH (N'GoodMusic')
	RETURN
END
GO

CREATE PROCEDURE [apiImport](@Import XML, @Commit BIT = 0, @UserId NVARCHAR(25) = NULL)
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRANSACTION
	BEGIN TRY

		;WITH [Import] AS (
				SELECT
					[Id] = n.value(N'Id[1]', N'NVARCHAR(25)'),
					[Forename] = n.value(N'Forename[1]', N'NVARCHAR(127)'),
					[Surname] = n.value(N'Surname[1]', N'NVARCHAR(127)'),
					[GenderId] = n.value(N'GenderId[1]', N'NCHAR(1)'),
					[CountryId] = n.value(N'CountryId[1]', N'NCHAR(2)'),
					[DateLogged] = n.value(N'DateLogged[1]', N'DATETIMEOFFSET'),
					[GenreId] = n.value(N'GenreId[1]', N'INT'),
					[StyleId] = n.value(N'StyleId[1]', N'INT')
				FROM @Import.nodes(N'/GoodMusic[1]/Users[1]/User') x (n)
			)
		INSERT INTO [User] (
				[Id],
				[Forename],
				[Surname],
				[GenderId],
				[CountryId],
				[DateLogged],
				[GenreId],
				[StyleId]
			)
		SELECT
			i.[Id],
			i.[Forename],
			i.[Surname],
			i.[GenderId],
			i.[CountryId],
			i.[DateLogged],
			i.[GenreId],
			i.[StyleId]
		FROM [Import] i
			LEFT JOIN [User] u ON i.[Id] = u.[Id]
		WHERE u.[Id] IS NULL
		PRINT N'Imported ' + CONVERT(NVARCHAR(10), @@ROWCOUNT) + N' user(s)'

		;WITH [Import] AS (
				SELECT
					[Id] = n.value(N'Id[1]', N'NVARCHAR(25)'),
					[Title] = n.value(N'Title[1]', N'NVARCHAR(255)'),
					[Thumbnail] = n.value(N'Thumbnail[1]', N'NVARCHAR(max)'),
					[DateRecommended] = n.value(N'DateRecommended[1]', N'DATETIMEOFFSET'),
					[UserId] = n.value(N'UserId[1]', N'NVARCHAR(25)')
				FROM @Import.nodes(N'/GoodMusic[1]/Videos[1]/Video') x (n)
			)
		INSERT INTO [Video] (
				[Id],
				[Title],
				[Thumbnail],
				[DateRecommended],
				[UserId]
			)
		SELECT
			i.[Id],
			i.[Title],
			i.[Thumbnail],
			i.[DateRecommended],
			i.[UserId]
		FROM [Import] i
			LEFT JOIN [Video] v ON i.[Id] = v.[Id]
		WHERE v.[Id] IS NULL
		PRINT N'Imported ' + CONVERT(NVARCHAR(10), @@ROWCOUNT) + N' video(s)'

		;WITH [Import] AS (
				SELECT
					[VideoId] = n.value(N'VideoId[1]', N'NVARCHAR(25)'),
					[GenreId] = n.value(N'GenreId[1]', N'INT'),
					[StyleId] = n.value(N'StyleId[1]', N'INT'),
					[UserId] = n.value(N'UserId[1]', N'NVARCHAR(25)'),
					[DateReviewed] = n.value(N'DateReviewed[1]', N'DATETIMEOFFSET'),
					[Like] = n.value(N'Like[1]', N'BIT')
				FROM @Import.nodes(N'/GoodMusic[1]/Reviews[1]/Review') x (n)
			)
		INSERT INTO [Review] (
				[VideoId],
				[GenreId],
				[StyleId],
				[UserId],
				[DateReviewed],
				[Like]
			)
		SELECT
			i.[VideoId],
			i.[GenreId],
			i.[StyleId],
			i.[UserId],
			i.[DateReviewed],
			i.[Like]
		FROM [Import] i
			LEFT JOIN [Review] r ON i.[VideoId] = r.[VideoId]
				AND i.[GenreId] = r.[GenreId]
				AND i.[StyleId] = r.[StyleId]
				AND i.[UserId] = i.[UserId]
		WHERE r.[Like] IS NULL
		PRINT N'Imported ' + CONVERT(NVARCHAR(10), @@ROWCOUNT) + N' review(s)'

		IF ISNULL(@Commit, 0) = 1 BEGIN
			COMMIT TRANSACTION
			PRINT 'Commit'
		END ELSE BEGIN
			ROLLBACK TRANSACTION
			PRINT 'Rollback'
		END

	END TRY
	BEGIN CATCH
		DECLARE @Message NVARCHAR(2048), @Severity INT, @State INT
		SELECT @Message = ERROR_MESSAGE(), @Severity = ERROR_SEVERITY(), @State = ERROR_STATE()
		ROLLBACK TRANSACTION
		RAISERROR(@Message, @Severity, @State)
	END CATCH
	RETURN
END
GO
