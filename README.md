## Inspiration
Chegg is a very famous website that students use to get answers to questions that they need help with. They can also book tutorials and various other features. However, the students that make use of this website are very often not African based. This is because most of the textbooks used by African Universities are not available on chegg. Because of that, we have created an equivalent platform that enables african based tutors and students to help each other while being rewarded for it in the form of a native token called LRN.

## What it does
LearnEarn is a web and mobile app that enables users to ask questions, refer other users and answer questions asked by students. The users are rewarded with our token which incentivises them to use the platform more. Students can simply post a question and attach a price to it in the form of a "bounty". Anyone can attempt to answer the question, the asker gets to mark any of the answers as correct. The funds is first deducted from the asker's account and then sent to the person whose response was marked as correct.

## How we built it
The mobile and web app was built using flutter using a single code base. This enabled quick prototyping. The database was built using the firebase due to it's tight integration with flutter. the back-end was built using nodeJS where we made use of various functions from the xrpl library.

## Challenges we ran into
Creating an escrow account where funds would be stored temporarily without having a receiver was challenging. We eventually resolved this having the funds sent to a dedicated account. This is a stop gap solution and a proper solution would be implemented before making it to production

## Future Plans
Our go to market strategy is going through universities and advertising locally to the students. This enables local community build up and organic users. We plan on switching from Flutter to React Native in order to support local caching and prevent sending user data to the cloud for signing.
