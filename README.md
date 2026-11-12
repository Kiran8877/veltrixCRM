# VeltrixCRM - Customer Relationship Management System

## About the Project

**VeltrixCRM** is a full-stack Customer Relationship Management (CRM) web application built using the **MERN Stack** (**M**ongoDB, **E**xpress.js, **R**eact 18, **N**ode.js).

In fast-growing organizations, sales and operations teams often struggle with scattered client records, unclear task ownership, manual follow-ups, and limited visibility into pipeline health. **VeltrixCRM** solves this by providing a unified workspace with distinct **Admin** and **Staff** portals. Admins gain complete oversight over team members, lead distribution, and real-time analytics, while staff members get a focused workspace to manage their assigned clients, update task progress, message leads directly via WhatsApp, and query an integrated AI assistant—with strict role-based security ensuring staff cannot reassign their work to other personnel.

---

## Key Features

### 1. Admin Portal
* **Role-Based Access & Staff Management:** Create, view, edit, and remove staff accounts (`admin` and `staff` roles) with encrypted `bcryptjs` passwords and JWT authentication.
* **Global Customer & Lead Pipeline:** Full CRUD management across all client records (`lead`, `active`, `inactive`) with search, status filtering, and personnel filtering.
* **Task Delegation:** Assign and reassign operational tasks to specific staff members and link tasks directly to customer records with due dates.
* **Analytics & Reporting:** Interactive `Chart.js` visualizations, activity log auditing, and one-click **CSV data export** (`/api/analytics/export`).

### 2. Staff Portal
* **Scoped Client Workspace:** Staff members view and manage only the customers and tasks assigned to them.
* **Assignment Protection (Staff-Locked):** Both the frontend modals and backend controllers automatically lock newly created customers/tasks to the logged-in staff member and prevent staff from reassigning or modifying another team member's records.
* **Task Status Workflow:** Quick status transitions between `pending`, `in_progress`, and `completed`.
* **Direct WhatsApp Integration:** Launch direct WhatsApp conversations (`wa.me`) straight from customer contact rows and detail modals.

### 3. Platform Capabilities & Database
* **Veltrix AI Assistant:** Built-in AI chat widget (`AIChatWidget`) powered by `/api/ai/chat` (supports optional `GEMINI_API_KEY` integration).
* **Multilingual Interface:** Instant language switching across **English (`en`)**, **Telugu (`te`)**, **Hindi (`hi`)**, and **Punjabi (`pa`)**.
* **OTP Password Recovery:** Forgot-password workflow with OTP generation, verification, and password reset.
* **MongoDB Persistence & Seeding:** Structured Mongoose schemas across 6 collections (`users`, `customers`, `tasks`, `activitylogs`, `notifications`, `contactmessages`) with a one-command database seeder (`npm run seed`).

---

## Tech Stack

* **Frontend:** React 18, Vite 6, React Router DOM v6, Axios, Tailwind CSS, Lucide React, Chart.js (`react-chartjs-2`), GSAP, Lenis
* **Backend:** Node.js, Express.js (REST API)
* **Database:** MongoDB (Local MongoDB / MongoDB Atlas), Mongoose ODM
* **Authentication & Security:** JSON Web Tokens (JWT) & `bcryptjs` password hashing, role-based middleware (`protect`, `requireAdmin`)


---

## Project Structure

```text
VeltrixCRM-main/
├── api/                           # Vercel serverless API entry points
│   ├── index.js
│   └── [...all].js
├── server/                        # Node.js + Express Backend
│   ├── config/
│   │   └── db.js                  # MongoDB Mongoose connection logic
│   ├── controllers/               # API business logic (auth, customers, tasks, staff, analytics, AI, etc.)
│   │   ├── aiController.js
│   │   ├── analyticsController.js
│   │   ├── authController.js
│   │   ├── contactController.js
│   │   ├── customerController.js
│   │   ├── notificationController.js
│   │   ├── staffController.js
│   │   └── taskController.js
│   ├── middleware/
│   │   └── auth.js                # JWT verification (protect) & role guard (requireAdmin)
│   ├── models/                    # Mongoose schemas
│   │   ├── ActivityLog.js         # Audit trail logs
│   │   ├── ContactMessage.js      # Public contact form submissions
│   │   ├── Customer.js            # Customer/lead schema linked to User
│   │   ├── Notification.js        # Per-user alert schema
│   │   ├── Task.js                # Task schema linked to User & Customer
│   │   └── User.js                # Admin & Staff user accounts with bcrypt pre-save hook
│   ├── routes/                    # Express route definitions
│   │   ├── aiRoutes.js
│   │   ├── analyticsRoutes.js
│   │   ├── authRoutes.js
│   │   ├── contactRoutes.js
│   │   ├── customerRoutes.js
│   │   ├── notificationRoutes.js
│   │   ├── staffRoutes.js
│   │   └── taskRoutes.js
│   ├── seed/
│   │   └── seed.js                # Seeds demo admin, staff, customers, tasks, logs & notifications
│   ├── index.js                   # Express app & server entry point (Port 5050)
│   └── package.json               # Server package metadata
├── client/                        # React + Vite Frontend
│   ├── public/                    # Static assets (favicon.svg, audio, CRM gallery images)
│   ├── src/
│   │   ├── components/            # Reusable UI (Sidebar, Topbar, Modals, AIChatWidget, ProtectedRoute)
│   │   ├── context/               # AuthContext & LanguageContext
│   │   ├── pages/                 # Views (Home, Login, Register, Dashboards, Customers, Tasks, Staff, Analytics)
│   │   ├── services/
│   │   │   └── api.js             # Axios instance with JWT interceptor
│   │   ├── translations/          # Language dictionaries (en, hi, pa, te)
│   │   ├── App.jsx                # Application routes & role-protected layouts
│   │   └── main.jsx               # React entry point
│   ├── index.html
│   ├── package.json               # Frontend dependencies & scripts
│   ├── tailwind.config.js
│   └── vite.config.js             # Vite dev server (Port 3000) & /api proxy to :5050
├── .env.example                   # Example environment variables
├── package.json                   # Root scripts (dev, server, client, seed, build, start)
├── run.bat                        # 1-click Windows launcher for Backend & Frontend
├── vercel.json                    # Vercel rewrite rules
└── README.md
```

---

## How to Set Up and Run Locally

### Prerequisites
* **Node.js** (v18 or higher installed)
* **npm** (v9 or higher)
* **MongoDB** installed and running locally (`mongodb://127.0.0.1:27017`) **OR** a MongoDB Atlas connection string

### Step 1: Configure Environment Variables
1. Open a terminal in the project root (`VeltrixCRM-main`).
2. Create a `.env` file from `.env.example` (if not already present):
   * **On Windows (CMD):**
     ```cmd
     copy .env.example .env
     ```
   * **On macOS/Linux/PowerShell:**
     ```bash
     cp .env.example .env
     ```
3. Open `.env` and verify your settings:
   ```env
   PORT=5050
   MONGO_URI=mongodb://127.0.0.1:27017/veltrixcrm
   JWT_SECRET=veltrix_crm_super_secure_jwt_secret_key_2026
   GEMINI_API_KEY=your_gemini_api_key_optional
   ```
   *(If using MongoDB Atlas, replace `MONGO_URI` with your Atlas connection string).*

### Step 2: Install Dependencies
Install both root (backend) and client (frontend) dependencies:
```bash
npm install
npm --prefix client install
```

### Step 3: Seed the Database
Populate MongoDB with sample Admin, Staff, Customers, Tasks, Activity Logs, and Notifications:
```bash
npm run seed
```

### Step 4: Start the Application

#### Option A: Single Command (Recommended)
Run both the Express backend and Vite frontend concurrently from the **project root**:
```bash
npm run dev
```

#### Option B: Separate Terminals
* **Terminal 1 (Backend API on Port `5050`):**
  ```bash
  npm run server
  ```
* **Terminal 2 (Frontend UI on Port `3000`):**
  ```bash
  npm run client
  ```

#### Option C: Windows 1-Click Launcher
Double-click [`run.bat`](run.bat) in the project root to launch both servers in separate Command Prompt windows automatically.

* **Frontend URL:** `http://localhost:3000`
* **Backend API URL:** `http://localhost:5050`

---

## Test Login Credentials

You can test both **Admin** and **Staff** portals using the pre-seeded accounts created by `npm run seed` *(Password for all demo accounts: `password123`)*:

| Role | Name | Email (Username) | Password | Specialty / Business Type |
|---|---|---|---|---|
| **Admin** | Kiran | `admin@veltrix.com` | `password123` | Enterprise SaaS |
| **Staff** | Marcus Vance | `staff@veltrix.com` | `password123` | Operational Pipeline |
| **Staff** | Sarah Jenkins | `sarah@veltrix.com` | `password123` | Client Success |
| **Staff** | David Chen | `david@veltrix.com` | `password123` | Enterprise Solutions |

*(Tip: On the login page at `http://localhost:3000/login`, you can also click the **"Quick Demo Login"** buttons to sign in immediately).*

---

## API Endpoints Summary

### Authentication (`/api/auth`)
* `POST /api/auth/register` — Register a new user account
* `POST /api/auth/login` — Authenticate with email & password (returns JWT token)
* `GET /api/auth/me` — Fetch profile of currently logged-in user *(Protected)*
* `POST /api/auth/logout` — Log out and record activity log *(Protected)*
* `POST /api/auth/forgot-password/send-otp` — Generate and send password reset OTP
* `POST /api/auth/forgot-password/verify-otp` — Verify reset OTP
* `POST /api/auth/forgot-password/reset` — Reset account password

### Customers (`/api/customers`) *(Protected)*
* `GET /api/customers` — List customers (supports `?search=`, `?status=`, `?staff_id=`; staff automatically scoped to own records)
* `GET /api/customers/:id` — Get details for a specific customer
* `POST /api/customers` — Create a new customer (automatically assigned to creator if staff)
* `PUT /api/customers/:id` — Update customer details (reassignment restricted to Admin)
* `DELETE /api/customers/:id` — Delete a customer record

### Tasks (`/api/tasks`) *(Protected)*
* `GET /api/tasks` — List tasks (supports `?search=`, `?status=`, `?staff_id=`; staff scoped to own tasks)
* `GET /api/tasks/:id` — Get details for a specific task
* `POST /api/tasks` — Create a task (automatically assigned to creator if staff)
* `PUT /api/tasks/:id` — Update task details (reassignment restricted to Admin)
* `PATCH /api/tasks/:id/status` — Update task status (`pending`, `in_progress`, `completed`)
* `DELETE /api/tasks/:id` — Delete a task

### Staff & Dashboard (`/api/staff`) *(Protected)*
* `GET /api/staff/stats` — Fetch dashboard KPI summary counts
* `GET /api/staff/all-users` — Fetch all registered users
* `GET /api/staff` — List staff members
* `GET /api/staff/:id` — Get a specific staff member's details
* `POST /api/staff` — Create a new staff user *(Admin only)*
* `PUT /api/staff/:id` — Update staff user *(Admin only)*
* `DELETE /api/staff/:id` — Delete staff user *(Admin only)*

### Analytics & Logs (`/api/analytics`) *(Protected)*
* `GET /api/analytics/data` — Retrieve aggregated chart data and activity logs
* `GET /api/analytics/export` — Download CRM records as CSV
* `DELETE /api/analytics/logs` — Clear activity logs *(Admin only)*

### Notifications, AI & Contact
* `GET /api/notifications` — Fetch notifications for the logged-in user *(Protected)*
* `POST /api/notifications/:id/read` — Mark a notification as read *(Protected)*
* `POST /api/notifications/read-all` — Mark all notifications as read *(Protected)*
* `DELETE /api/notifications/clear` — Clear all notifications *(Protected)*
* `POST /api/ai/chat` — Send prompt to the Veltrix AI Assistant *(Protected)*
* `POST /api/contact` — Submit a public contact inquiry message

---

## MongoDB Shell (`mongosh`) Demonstration

To inspect collections or demonstrate direct database queries in MongoDB Shell:

1. Connect to `mongosh` and switch to the database:
   ```javascript
   mongosh
   use veltrixcrm
   ```
2. View all users (Admin & Staff):
   ```javascript
   db.users.find({}, { password: 0 }).pretty()
   ```
3. View all customers:
   ```javascript
   db.customers.find().pretty()
   ```
4. Filter customers by status:
   ```javascript
   db.customers.find({ status: "active" })
   ```
5. Count total tasks:
   ```javascript
   db.tasks.countDocuments()
   ```
6. Group customers by status using an aggregation pipeline:
   ```javascript
   db.customers.aggregate([
     { $group: { _id: "$status", total: { $sum: 1 } } }
   ])
   ```
7. Group tasks by status using an aggregation pipeline:
   ```javascript
   db.tasks.aggregate([
     { $group: { _id: "$status", total: { $sum: 1 } } }
   ])
   ```

---

## Available NPM Scripts

| Script | Command | Description |
|---|---|---|
| `npm run dev` | `concurrently ...` | Runs both Backend (`:5050`) and Frontend (`:3000`) simultaneously |
| `npm run server` | `node server/index.js` | Runs Express backend API only |
| `npm run client` | `npm --prefix client run dev` | Runs Vite React frontend only |
| `npm run seed` | `node server/seed/seed.js` | Seeds MongoDB with initial Admin, Staff, Customers, Tasks & Logs |
| `npm run build` | `npm --prefix client install && ...` | Builds optimized production React bundle into `dist/` |
| `npm start` | `node server/index.js` | Serves Express API and production React build |

---

## Deploy to Vercel

1. Push your code to GitHub (`git push -u origin main`).
2. Import the repository in [Vercel](https://vercel.com/).
3. Configure Environment Variables in Vercel Project Settings:
   * `MONGO_URI` — Your MongoDB Atlas connection string
   * `JWT_SECRET` — A secure random secret string
   * `GEMINI_API_KEY` — *(Optional)* For AI assistant responses
4. Deploy — Vercel uses `vercel.json` and `api/[...all].js` to serve both the React SPA and Express API routes automatically.
