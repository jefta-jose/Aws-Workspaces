export async function handler(event) {
    console.log("lambda invoked");
    return {
        statusCode: 200,
        body: JSON.stringify({ message: "Lambda invoked" }),
    };
}