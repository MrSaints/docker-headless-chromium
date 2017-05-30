const CDP = require("chrome-remote-interface");
const options = {
    "host": "chromium",
    "port": "9222"
};

CDP(options, async (client) => {
    const {Network, Page} = client;

    try {
        await Promise.all([Network.enable(), Page.enable()]);
        await Page.navigate({url: "https://www.fyianlai.com"});
        await Page.loadEventFired();
        const result = await Page.printToPDF();
        await process.stdout.write(Buffer.from(result.data, "base64"));
    } catch (err) {
        console.error(err);
    }

    await client.close();
}).on("error", (err) => {
    console.error(err);
});
