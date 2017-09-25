import axios from 'axios';

import socket from './socket';


const topics = document.querySelectorAll('.like-container');
const channel = socket.channel('likes:*', {});

channel
  .join();

channel
  .on('like', topic => respondToLike(topic));

channel
  .on('create', topic => respondToCreate(topic));

const respondToCreate = (topicData) => {
  const { id, name, likes } = topicData;
  const newListItem = document.createElement('li');
  const newTopic = document.createElement('span');
  const newLikeBadge = document.createElement('span');
  newListItem.classList = 'dib mr2';

  newTopic.innerHTML = name;
  newTopic.classList = 'f6 f5-ns b db pa2 link dim mid-gray like-container';
  newTopic.id = id;
  newTopic.appendChild(newLikeBadge);

  newLikeBadge.dataset.topic = id;
  newLikeBadge.classList = 'like-badge';
  newLikeBadge.innerHTML = likes;

  newListItem.appendChild(newTopic);
  document.getElementById('topics').appendChild(newListItem);
}

const respondToLike = (topicData) => {
  const { id, likes } = topicData;
  document.querySelector(`[data-topic="${id}"]`).querySelector('.like-badge').innerHTML = likes;
};

const likeTopic = (id) => {
  axios.patch(`/api/topics/${id}/like`, {})
    .then()
    .catch(error =>
      console.log(error)
    );
};


Array.from(topics).forEach(topic =>
  topic.addEventListener('click', event => likeTopic(event.target.id)));
