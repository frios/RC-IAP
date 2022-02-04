# RC-IAP

A RevenueCat based in-app purchase package.

RC-IAP is a simple to implement RevenueCat based in-app purchase system. It takes care of displaying a purchase page with
a Title, Image, and a message from the developer, all of which are optional (Title defaults to "In-App Purchases").

Setup is easy following the steps outlined below.

1) Set up your RevenueCat products as described here: https://docs.revenuecat.com/docs/getting-started (this is the hardest part)

2) Be sure to include InApp Purchases as an app capability

3) In your app, instantiate IAPManager with your RevenueCat API Key

4) Instantiate an IAPView and pass it the previously instantiated IAPManager as an environmentObject

```
struct ContentView: View {
    let iapManager = IAPManager(apiKey: revenueCatAPIKey)

    var body: some View {
        IAPView() //or pass in title, imageName and/or message
            .environmentObject(iapManager)
    }
}
```

5) Thats all there is to it!
