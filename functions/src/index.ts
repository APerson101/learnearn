import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import * as xrpl from "xrpl";


admin.initializeApp();
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

export const addUser=functions.https.onCall(async (data)=>{
    let info=data['data']
    let status=await admin.firestore().collection('users').add(info)
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const deleteUser=functions.https.onCall(async (data)=>{
    let info=data['user_id']
    let status=await admin.firestore().doc(`users/${info}`).delete()
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const addQuestion=functions.https.onCall(async (data)=>{
    let info=data['data']
    let status=await admin.firestore().collection('questions').add(info)
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const deleteQuestion=functions.https.onCall(async (data)=>{
    let id=data['question_id']
    let status=await admin.firestore().doc(`questions/${id}`).delete()
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const addQuestionComment=functions.https.onCall(async (data)=>{
    let comment=data['comment_data']
    let question_id=data['question_id']
    let status=await admin.firestore().collection(`questions/${question_id}/comments`).add(comment)
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const deleteComment=functions.https.onCall(async (data)=>{
    let comment_id=data['comment_id']
    let question_id=data['question_id']
    let status=await admin.firestore().doc(`questions/${question_id}/comments/${comment_id}`).delete()
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const addBounty=functions.https.onCall(async (data)=>{
    let bounty=data['bounty']
    let status=await admin.firestore().collection(`bounties`).add(bounty)
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const deleteBounty=functions.https.onCall(async (data)=>{
    let bounty=data['bounty_id']
    let status=await admin.firestore().doc(`bounties/${bounty}`).delete()
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const addBountyComment=functions.https.onCall(async (data)=>{
    let comment=data['comment_data']
    let bounty_id=data['bounty_id']
    let status=await admin.firestore().collection(`bounties/${bounty_id}/comments`).add(comment)
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const deleteBountyComment=functions.https.onCall(async (data)=>{
    let comment=data['comment_id']
    let bounty_id=data['bounty_id']
    let status=await admin.firestore().doc(`bounties/${bounty_id}/comments/${comment}`).delete()
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const setBountyStatus=functions.https.onCall(async (data)=>{
    let comment=data['newStatus']
    let bounty_id=data['bounty_id']
    let status=await admin.firestore().doc(`bounties/${bounty_id}/comments/${comment}`).delete()
    .then((_)=>true)
    .catch((error)=>{
        console.log(error);
        return false;})
    return status;
});

export const getAllBounties=functions.https.onCall(async (_)=>{
    let status=await admin.firestore().collection(`bounties`).get();
    let bounties:admin.firestore.DocumentData[]=[];
    for (const doc in status.docs) {
        if (Object.prototype.hasOwnProperty.call(status.docs, doc)) {
            const element = status.docs[doc];
bounties.push(element.data());
        }
    }
    return bounties;
});


export const getAllBountyComments = functions.https.onCall(async (id) => {
    let bountyId=id.id;
    let status = await admin.firestore().collection(`bounties/${bountyId}/comments`).get();
    let comments: admin.firestore.DocumentData[] = [];
    for (const doc in status.docs) {
        if (Object.prototype.hasOwnProperty.call(status.docs, doc)) {
            const element = status.docs[doc];
            comments.push(element.data());
        }
    }
    return comments;
});



export const getWalletFromSeed = functions.https.onCall(async (id) => {
    const testnet_server = "wss://xls20-sandbox.rippletest.net:51233";
    const client = new xrpl.Client(testnet_server);
    await client.connect();
    let seed = id.seed;
const wallet=xrpl.Wallet.fromSeed(seed);
return {'address': wallet.address,'private_key':
wallet.privateKey,'public_key':
wallet.publicKey}
});



export const getBalance=functions.https.onCall(async (id)=>{
    const testnet_server = "wss://xls20-sandbox.rippletest.net:51233";
    const client = new xrpl.Client(testnet_server);
    await client.connect();
    let wallet=id.wallet;
    return await client.getXrpBalance(wallet);

});


export const sendXrp=functions.https.onCall(async(dets)=>{
    const receiver=dets.receiver;
    const sender_seed=dets.sender_seed;
    const amount=dets.amount;
    const testnet_server = "wss://xls20-sandbox.rippletest.net:51233";
    const client = new xrpl.Client(testnet_server);
    await client.connect();
    const sender_wallet=xrpl.Wallet.fromSeed(sender_seed);
    const prepared = await client.autofill({
        "TransactionType": "Payment",
        "Account": sender_wallet.address,
        "Amount": xrpl.xrpToDrops(amount),
        "Destination": receiver
    });
   await client.submitAndWait(sender_wallet.sign(prepared).tx_blob)

});