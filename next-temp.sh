#! /bin/bash

echo "Building a Next.js template with typescript and tailwind css..."
echo "${bold}Imp:  ${normal}You must have npm installed in your machine!"
bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}Enter your app name: (Dont use spaces in the name, use '_' instead)"
read app_name
echo "App name set to $app_name ✅"

echo "${bold}Do you want Tailwind? (Y/N)"
read tailwind
echo "${bold}Do you want Material UI? (Y/N)"
read material
echo "${bold}Do you want to add Firebase? (Y/N)"
read firebase

if [ -z "$tailwind" ]; then
tailwind="y"
fi
if [ -z "$material" ]; then
material="y"
fi
if [ -z "$firebase" ]; then
firebase="y"
fi

#Installing Next.js
npx create-next-app@latest $app_name --ts
cd $app_name

# if tailwind is true
if [ "$tailwind" == "y" ] || [ "$tailwind" == "Y" ]; then
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
cat >> tailwind.config.js <<EOL
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

echo "${bold}Success:  ${normal}tailwind.config.js build and cofigured ✅"
rm -rf styles
mkdir styles
cd styles
cat >> globals.css <<EOL
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

echo "CSS files rebuilt"
cd ../
cd pages
rm -rf index.tsx
cat >> index.tsx <<EOL
import React from "react";

const Home = () => {
  return (
    <div className="flex h-screen items-center justify-center bg-slate-900 flex-col">
      <h1 className="text-5xl font-semibold text-white">
        Hello welcome to Tailwind based Next.js
      </h1>
      <a
        href="https://github.com/Rajdip019"
        target="_blank"
        className=" text-gray-200 mt-10 "
        rel="noreferrer"
      >
        - by Rajdeep Sengupta
      </a>
    </div>
  );
};

export default Home;

EOL

echo "${bold}Info:  ${normal}New home page initialized with Tailwind CSS ✅"
echo "${bold}Tailwind totally confgured! ✅"
cd ../
fi

# if Material UI is true
if [ "$material" == "y" ] || [ "$material" == "Y" ]; then
npm install @mui/material @emotion/react @emotion/styled
echo "${bold}Success:  ${normal}Material UI Installed ✅"
fi

if [ "$firebase" == "y" ] || [ "$firebase" == "Y" ]; then
echo "${bold} Configuring firebase..."
npm install firebase
mkdir lib
cd lib
cat >> firebaseConfig.ts <<EOL
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore } from "firebase/firestore"
import { getStorage } from "firebase/storage"

const firebaseConfig = {
  apiKey: process.env.NEXT_PUBLIC_FIREBASE_API_KEY,
  authDomain: process.env.NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.NEXT_PUBLIC_FIREBASE_PROJECT_ID,
  storageBucket: process.env.NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.NEXT_PUBLIC_FIREBASE_MESSEGING_SENDER_ID,
  appId: process.env.NEXT_PUBLIC_FIREBASE_APP_ID,
  measurementId: process.env.NEXT_PUBLIC_FIREBASE_MEASURMENT_ID
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);
// export const analytics = getAnalytics(app);
export const db = getFirestore(app);
export const storage = getStorage(app)

EOL

cd ../
cat >> .env.local <<EOL
NEXT_PUBLIC_FIREBASE_API_KEY = 
NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN = 
NEXT_PUBLIC_FIREBASE_PROJECT_ID = 
NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET = 
NEXT_PUBLIC_FIREBASE_MESSEGING_SENDER_ID = 
NEXT_PUBLIC_FIREBASE_APP_ID = 
NEXT_PUBLIC_FIREBASE_MEASURMENT_ID = 
EOL
echo "${bold}Success:  ${normal}Firebase configured ✅"
echo "${bold}Imp:  ${normal}Add your env for Firebase and restart the server."
fi

if [ "$tailwind" != "y" ] && [ "$tailwind" != "Y" ]; then
cd pages
rm -rf index.tsx
cat >> index.tsx <<EOL
import type { NextPage } from 'next'
import styles from '../styles/Home.module.css'

const Home: NextPage = () => {
  return (
    <div className={styles.main}>
      <h1>Welcome to Next.js build by Next instraller.</h1>
      <a href='https://github.com/Rajdip019' target="_blank">by - Rajdeep Sengupta</a>
      <div className={styles.socialmain}>
        <div className={styles.social}>
          <a href="https://github.com/Rajdip019">
            <img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="" />
          </a>
        </div>
        <div className={styles.social}>
          <a href="https://www.linkedin.com/in/rajdeep-sengupta/" target="_blank">
            <img src="https://cdn-icons-png.flaticon.com/512/174/174857.png" alt="" />
          </a>
        </div>
      </div>
    </div>
  )
}

export default Home

EOL

cd ../
cd styles
rm -rf Home.module.css
cat >> Home.module.css <<EOL
.main{
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  min-height: 100vh;
  background-color: black;
}

.main h1{
  color: white;
  font-weight: bold;
  font-size: xx-large;
}

.main a{
  text-decoration: underline;
}

.socialmain{
  display: flex;
  gap: 30px;
  margin-top: 30px;
}

.social{
  background-color: white;
  padding: .9rem;
  border-radius: 100%;
}

.social a img{
  width: 50px;
  height: 50px;
}

EOL
cd ../
fi

cd pages
cat >> _document.tsx << EOL
import { Html, Head, Main, NextScript } from 'next/document'

export default function Document() {
    return (
        <Html lang="en">
            <title>Next.js Instraller</title>
            <link rel="icon" 
href="https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/3e1f6e5c-5238-4ecc-a0d5-f2deff1e4fb4/dcge67r-261eb5af-66f8-4786-94ac-bd535876fd45.png" />
            <Head />
            <body>
                <Main />
                <NextScript />
            </body>
        </Html>
    )
}

EOL

echo "${bold}Success:  ${normal}Document configured. ✅"
cd ../
touch .babelrc
cat >> .babelrc <<EOL
{
  "presets": ["next/babel"],
  "plugins": []
}
EOL

rm -rf .eslintrc.json
cat >> .eslintrc.json << EOL
{
  "extends": "next/babel"
}
EOL
mkdir interfaces
mkdir helpers
mkdir database
echo "babel configured ✅"
echo "${bold}Finished:  ${normal}All set and ready to go! ✅"

npm run dev

