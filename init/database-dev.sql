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

CREATE TABLE episodeQueue(
    videoId varchar(250) not null,
    url text,
    nameCfg text not null,
    timeRequest bigint not null,
    PRIMARY KEY(videoId, nameCfg, url)
);

CREATE TABLE episodeBlacklist(
    videoId varchar(250) not null,
    url text not null,
    nameCfg text not null,
    PRIMARY KEY(videoId, url)
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

CREATE TABLE chapterQueue(
    nameManga varchar(250) not null,
    url text,
    nameCfg text not null,
    timeRequest bigint not null,
    PRIMARY KEY(nameManga, nameCfg, url)
);

CREATE TABLE chapterBlacklist(
    nameManga varchar(250) not null,
    url text not null,
    nameCfg text not null,
    PRIMARY KEY(nameManga, url)
);

/* account */
CREATE TABLE account
(
    username varchar(250) primary key not null,
    password varchar(500) not null,
    role integer default 0
);

CREATE TABLE whitelist
(
    name varchar(500) not null,
    username varchar(250) REFERENCES account(username) ON DELETE CASCADE not null,
    nameCfg text not null,
    PRIMARY KEY (name, username, nameCfg)
);

CREATE TABLE progressEpisode(
    id serial primary key,
    username varchar(250) REFERENCES account(username) ON DELETE CASCADE not null,
    name varchar(500) not null,
    nameCfg text not null,
    nameEpisode varchar(500) not null,
    hours int default 0,
    minutes int default 0,
    seconds int default 0
);

CREATE TABLE progressChapter(
    id serial primary key,
    username varchar(250) REFERENCES account(username) ON DELETE CASCADE not null,
    name varchar(500) not null,
    nameCfg text not null,
    nameChapter varchar(500) not null,
    page int default 1
);