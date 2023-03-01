'use strict';
const aws = require('aws-sdk');
const rdsDataService = new aws.RDSDataService()
exports.handler = (event, context, callback) => {
    console.log(event);
    if (event.request.userAttributes.email && event.request.userAttributes.birthdate) {
        createUser(event.request.userAttributes.email, event.request.userAttributes.birthdate, callback, context);
        callback(null, event);
    } else {
        console.log('Nothing to do, the users email ID is unknown');
        callback(null, event);
    }
};

function getUserType(birthdate_value) {
    const age = new Date().getFullYear() - new Date(birthdate_value).getFullYear();
    if (age < 13) {
        return 'KID';
    } else if (age < 18) {
        return 'TEEN';
    } else {
        return 'ADULT';
    }
}

function createUser(email_value, birthdate_value, completedCallback, context) {
// prepare SQL command
    console.log('In createUser: email_value=' + email_value + ' birthdate_value=' + birthdate_value);

    const user_type = getUserType(birthdate_value)

    const sql_query = `insert into users (email, birthday,user_type,email_verified) values ('${email_value}', '${birthdate_value}', '${user_type}', true);`
    let sqlParams = {
        secretArn: process.env.SECRET_ARN,
        resourceArn: process.env.CLUSTER_ARN,
        sql: sql_query,
        database: process.env.DB_NAME,
        includeResultMetadata: true,
        continueAfterTimeout: false
    }

    // run SQL command

    console.log('sqlParams=' + JSON.stringify(sqlParams));
    try {
        rdsDataService.executeStatement(sqlParams, function (err, data) {
            if (err) {
                // error
                console.log('err', err);
                completedCallback(err, context);
            } else {
                // done
                console.log('User created')
                completedCallback(null, context);
            }
        })
    } catch (e) {
        console.log('Unexpected error happend', e);
        completedCallback(e, context);
    }
}
