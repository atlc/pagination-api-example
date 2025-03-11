# Pagination API

A Node.js API with pagination support.

## Development

This project uses esbuild for fast development builds with live reloading.

### Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm run dev
   ```
   This will:
   - Watch for file changes in the `src` directory
   - Automatically rebuild when files change
   - Restart the server with the new changes
   - The server will be available at the port specified in your .env file

3. For production builds:
   ```bash
   npm run build
   ```

### Environment Variables

Make sure to copy `.env.sample` to `.env` and fill in the required variables:

```
PORT=your_port
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=your_db_host
DB_NAME=your_db_name
```
