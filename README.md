
# My Salon Appointment Scheduler

This project is a salon appointment scheduling system built using Bash scripting and a PostgreSQL database. It allows customers to book services at a salon by interacting with a simple command-line interface. The project satisfies all requirements outlined in the FreeCodeCamp Relational Databases project.

## Features

- Manage salon services.
- Add new customers dynamically when they book a service.
- Record customer appointments, associating them with specific services.
- A fully interactive terminal-based menu.

## Table of Contents

- [Setup](#setup)
- [Usage](#usage)
- [Database Schema](#database-schema)
- [How It Works](#how-it-works)
- [Examples](#examples)
- [License](#license)

## Setup

### Clone the Repository

Clone this repository to your local machine:

```bash
git clone <repository_url>
cd <repository_name>
```

### Import the Database

Use the provided SQL dump file (`salon.sql`) to recreate the database schema and data:

```
psql --username=<your_postgres_username> --dbname=postgres < salon.sql
```

### Make the Script Executable

Ensure the `salon.sh` script has executable permissions:

```bash
chmod +x salon.sh
```

### Run the Script

Launch the salon scheduling program:

```bash
./salon.sh
```

## Usage

The script displays the list of services available at the salon. Customers can:

- Select a service.
- Enter their phone number to check if they are already registered.
- Add their name if they are a new customer.
- Specify a time for their appointment.

The system confirms the booking and displays the appointment details.

## Database Schema

The project uses a PostgreSQL database with the following tables:

### `services` Table

| Column      | Type           | Description              |
|-------------|----------------|--------------------------|
| `service_id`| `SERIAL (PK)`  | Unique service ID.       |
| `name`      | `VARCHAR`      | Name of the service.     |

### `customers` Table

| Column       | Type           | Description                      |
|--------------|----------------|----------------------------------|
| `customer_id`| `SERIAL (PK)`  | Unique customer ID.             |
| `name`       | `VARCHAR`      | Name of the customer.           |
| `phone`      | `VARCHAR (Unique)` | Customer phone number.       |

### `appointments` Table

| Column        | Type           | Description                        |
|---------------|----------------|------------------------------------|
| `appointment_id` | `SERIAL (PK)` | Unique appointment ID.            |
| `customer_id`    | `INT (FK)`    | References `customers.customer_id` |
| `service_id`     | `INT (FK)`    | References `services.service_id`   |
| `time`           | `VARCHAR`      | Time of the appointment.          |

## How It Works

### Services Listing

The `services` table stores all the available salon services. The script queries and displays these to the user.

### Customer Identification

The `customers` table tracks customer information. Customers are identified by their unique phone numbers. If a phone number is not found, the script prompts for their name and adds them to the database.

### Booking Appointments

The `appointments` table links customers to services and appointment times. The script validates input and ensures proper associations between customers, services, and times.

## Examples

### Booking a New Appointment

```bash
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?
1) cut
2) color
3) perm
4) style
5) trim

2
You have selected color service.

What's your phone number?
555-123-4567

I don't have a record for that phone number, what's your name?
John Doe

What time would you like your color, John Doe?
3:00 PM

I have put you down for a color at 3:00 PM, John Doe.
```

### Returning Customer

```bash
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?
1) cut
2) color
3) perm
4) style
5) trim

1
You have selected cut service.

What's your phone number?
555-123-4567

What time would you like your cut, John Doe?
10:00 AM

I have put you down for a cut at 10:00 AM, John Doe.
```
