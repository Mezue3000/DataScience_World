DROP DATABASE IF EXISTS blog_post;
CREATE DATABASE IF NOT EXISTS blog_post;

USE blog_post;

DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS comments;

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users(
       user_id           INT PRIMARY KEY AUTO_INCREMENT,
       first_name        VARCHAR(25) NOT NULL,
       last_name         VARCHAR(25) NOT NULL,
       email             VARCHAR(50) NOT NULL UNIQUE,
       password_hash     VARCHAR(500) NOT NULL
       country           VARCHAR(25) NOT NULL,
       city              VARCHAR(25) NOT NULL
       created_at        DATETIME NOT NULL NOW()
);


CREATE TABLE IF NOT EXISTS posts(
        post_id     INT PRIMARY KEY AUTO_INCREMENT,
        title       VARCHAR(125) NOT NULL,
        content     VARCHAR(450) NOT NULL,
	created_at  DATETIME NOT NULL DEFAULT NOW(),
	updated_at  DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
        user_id     INT  NOT NULL,
        FOREIGN KEY(user_id)
        REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS comments(
	comment_id   INT PRIMARY KEY AUTO_INCREMENT,
        content      VARCHAR(450) NOT NULL,
	created_at   DATETIME DEFAULT NOW(),
	updated_at   DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
        post_id      INT NOT NULL,
        FOREIGN KEY(post_id)
        REFERENCES posts(post_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION   
);
