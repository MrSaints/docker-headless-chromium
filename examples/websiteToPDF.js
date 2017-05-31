const CDP = require("chrome-remote-interface");

const options = {
    "host": "chromium",
    "port": "9222"
};

CDP.New(options, async (err, target) => {
    try {
        const client = await CDP({target: target});
        const {Network, Page, Target} = client;
        await Promise.all([Network.enable(), Page.enable()]);
        await Page.navigate({url: "https://www.fyianlai.com"});
        await Page.loadEventFired();
        const result = await Page.printToPDF();
        await process.stdout.write(Buffer.from(result.data, "base64"));
        await client.close();
        await CDP.Close(Object.assign(options, {"id": target.id}));
    } catch (err) {
        console.error(err);
    }
});
