CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (username) VALUES
('BlueTheCat'),
('CharlieBrown'),
('ColtSteele');

CREATE TABLE photos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE comments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id)
);

-- doesnt't need an id because we aren't referencing the like anywhere
CREATE TABLE likes (
    user_id INTEGER NOT NULL,
    photo_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(photo_id) REFERENCES photos(id),
    -- allows use not to insert two like that have the same user and photo ids
    PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followee_id) REFERENCES users(id),
    PRIMARY KEY(follower_id, followee_id)
);

 CREATE TABLE tags (
     id INTEGER AUTO_INCREMENT PRIMARY KEY,
     tag_name VARCHAR(255) UNIQUE,
     created_at TIMESTAMP DEFAULT NOW()
 );

 CREATE TABLE photo_tags (
     photo_id INTEGER NOT NULL,
     tag_id INTEGER NOT NULL,
     FOREIGN KEY(photo_id) REFERENCES photos(id),
     FOREIGN KEY(tag_id) REFERENCES tags(id),
     PRIMARY KEY(photo_id, tag_id)
 );

