import mysql from "mysql2/promise";
import config from "../config";

const pool = mysql.createPool(config.mysql);

export const Query = async <T = any>(sql: string, params: any[] = []) => {
    const [rows] = await pool.execute(sql, params);
    return rows as T[];
}

const slowResponse = <T>(ms: number, delayedFunction: () => Promise<T>) => new Promise((resolve) => setTimeout(resolve, ms)).then(delayedFunction);

const getAllMovies = () => Query<Movie>("SELECT * FROM Movies");
const getMoviesByPage = (page: number, limit: number) => Query<Movie>("SELECT * FROM Movies LIMIT ? OFFSET ?", [limit, (page - 1) * limit]);

export default {
    movies: {
        getAllMovies: () => slowResponse<Movie[]>(5000, getAllMovies),
        getMoviesByPage: (page: number, limit: number) => slowResponse<Movie[]>(5000, () => getMoviesByPage(page, limit))
    }
}

