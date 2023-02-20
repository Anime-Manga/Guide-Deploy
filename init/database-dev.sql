CREATE DATABASE animemanga OWNER root;
\connect animemanga;

/*video*/
CREATE TABLE episode
(
    id varchar(500) primary key not null,
    VideoId  varchar(250) not null,
    numberEpisodeCurrent int not null,
    numberSeasonCurrent int default 1,
    stateDownload varchar(100),
    percentualDownload int default 0,

    urlVideo text default null,

    baseUrl varchar(250) default null,
    playlist varchar(250),
    resolution varchar(250),
    playlistSources varchar(250),
    startNumberFrame int,
    endNumberFrame int,
    nameCfg text not null
);

CREATE TABLE episodeRegister
(
    episodeId varchar(500) primary key REFERENCES episode(id) ON DELETE CASCADE not null,
    episodePath varchar(500),
    episodeHash varchar(64)
);

/*book*/
CREATE TABLE chapter
(
    id varchar(500) primary key not null,
    nameManga varchar(250) not null,
    currentVolume decimal not null,
    currentChapter decimal not null,
    numberMaxImage integer not null,
    urlPage text not null,
    stateDownload varchar(100),
    percentualDownload int default 0,
    nameCfg text not null
);

CREATE TABLE chapterRegister
(
    chapterId varchar(500) primary key REFERENCES chapter(id) ON DELETE CASCADE not null,
    chapterPath varchar[],
    chapterHash varchar[]
);