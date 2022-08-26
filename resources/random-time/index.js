const AWS = require('aws-sdk')
const sqs = new AWS.SQS();

exports.handler = async (event) => {

    const delaySeconds = Math.floor(Math.random() * 60)
    console.log("Punch will start after " + delaySeconds + " sec!")

    console.log("SQS_PATH " + process.env.SQS_PATH)

    let params = {
        DelaySeconds: delaySeconds,
        MessageBody: "Start Punch!!",
        QueueUrl: process.env.SQS_PATH
    };

    await sqs.sendMessage(params).promise();

    return { statusCode: 200 };
};