import express from 'express';
import cors from 'cors';
import db from './db'

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(cors())

app.get('/api/v1/movies', async (req, res) => {
  try {
    // const page = parseInt(req.query.page as string);
    // const limit = parseInt(req.query.limit as string);

    // if (page && limit) {
    //   const movies = await db.movies.getMoviesByPage(page, limit);    
    //   res.json(movies);
    //   return;
    // }
    
    const movies = await db.movies.getAllMovies();
    res.json(movies);
  } catch (error) {
    console.error('Error rendering page:', error);
    res.status(500).send('Server error');
  }
});

app.use((req, res) => {
  res.json({
    message: 'Wrong request url lol, must be /api/v1/movies',
    url: req.protocol + '://' + req.get('host') + '/api/v1/movies',
  })
})

app.listen(PORT, () => {
  console.log(`Server last launched at ${new Date().toISOString()} on port ${PORT}`);
});