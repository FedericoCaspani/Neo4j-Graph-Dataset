# Covid Free App

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Architecture of UI

This part overviews an architecture of UI specifying how the screens are connected:

![image](https://user-images.githubusercontent.com/23494724/141697166-32d89c2a-b102-41d9-bf36-284b480bf7b1.png)

Upon loading an application we perform the cleaning of the database (you could find this query under folder deliveries, it is named C3).

**StartScreen** is an entry point and filter for the application. If the user doesn't have his/her own tax code in the system, the screen with asking for enter the tax code is presented, otherwise user will be directly pushed to the **MapScreen**

**BarAdditionalScreen** & **Registration** registers the user in our system. 

**MapScreen** shows the top places with the number of infected (on our screen you could see three infected that were in Duomo of Milan). This top is automatically sorted and the user could check every position in this places just pushes the center button with arrow (Q2).

**MainGreen** represents the three buttons: the first one **GreenPass** creates the infection or green pass depending on QR code that will be readed (C1 and C2 respectively).

The second button goes to **Analytics** screen where the following graphics are presented: BarChart that shows the count of issued green pass and the vaccines (you could see the whole name by tapping onto the bar) - Q3; LineChart that shows the most visited day of the most visited place, since we keep only 14 reliable days in our database we have cut also the X axis to represent it - Q6; two PieCharts represent the ratio of infected/healthy and daily infected/tested - Q4 and Q5 respectively. The button on this screen goes to the **TableOFPeople** that shows the people that went to a place while being infected. It is represented with the table of these people that will be shown after refreshing the page.

The last button on **MainGreen** logs out the current user
