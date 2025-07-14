import { Hono } from 'hono'
import { cors } from 'hono/cors'
// @ts-ignore
import dotenv from 'dotenv'

dotenv.config()


const app = new Hono();

app.use('*', cors({
  origin: '*', // Or restrict it to a specific origin like 'https://yourdomain.com'
  allowMethods: ['GET', 'POST', 'PATCH', 'PUT', 'DELETE', 'OPTIONS'],
  // allowHeaders: ['Content-Type', 'Authorization'],
  // credentials: true // only if using cookies
}))

const BASE_PATH: string = '/api/v1'



app.get(`${BASE_PATH}`, (c) => {
return c.text(`Welcome to Hono Boilerplate.`)
})

export default app;

   