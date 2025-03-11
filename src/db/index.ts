import { Pool } from "pg";
import config from "../config";

const pool = new Pool(config.postgres);

export const Query = async <T = any>(sql: string, params: any[] = []) => {
    const result = await pool.query(sql, params);
    return result.rows as T[];
}

const slowResponse = <T>(ms: number, delayedFunction: () => Promise<T>) => new Promise((resolve) => setTimeout(resolve, ms)).then(delayedFunction);

const getAllMovies = () => Query<Movie>("SELECT * FROM \"Movies\"");
const getMoviesByPage = (page: number, limit: number) => Query<Movie>("SELECT * FROM \"Movies\" LIMIT $1 OFFSET $2", [limit, (page - 1) * limit]);


export default {
    movies: {
        getAllMovies: () => slowResponse<Movie[]>(5000, getAllMovies),
        // getMoviesByPage
    }
}

