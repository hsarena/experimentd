module source.app;
import source.api;
import vibe.vibe;
import std.conv : to;
import std.process : environment;
import std.typecons : Nullable;

void main()
{
	logInfo("Environment dump");
    auto env = environment.toAA;
    foreach(k, v; env)
        logInfo("%s = %s", k, v);

	auto host = environment.get("HELLO_HOST", "0.0.0.0");
    auto port = to!ushort(environment.get("HELLO_PORT", "8080"));

	auto router = new URLRouter;
	registerRestInterface(router, new Example1());
	// note additional last parameter that defines used naming convention for compile-time introspection
	registerRestInterface(router, new Example2(), MethodStyle.upperUnderscored);
	// naming style is default again, those can be router path specific.
	registerRestInterface(router, new Example3());
	registerRestInterface(router, new Example4());
	registerRestInterface(router, new Example5());
	registerRestInterface(router, new Example6());
	registerRestInterface(router, new Example7());
	router.get("/", &hello);
	router.get("/healthz", &healthz);
	router.get("*", serveStaticFiles("public"));

	auto settings = new HTTPServerSettings;
	settings.port = port;
	settings.bindAddresses = [host];
	settings.errorPageHandler = toDelegate(&error);
	//listenHTTP(settings, router);
	immutable serverAddr = listenHTTP(settings, router).bindAddresses[0];

	logInfo("Please open http://%s:%d/hello in your browser.",host, port);
	// runTask({
	// 	try {
	// 		runTests("http://" ~ serverAddr.toString);
	// 		logInfo("Success.");
	// 	} catch (Exception e) {
	// 		import core.stdc.stdlib : exit;
	// 		import std.encoding : sanitize;
	// 		logError("Fail: %s", e.toString().sanitize);
	// 		exit(1);
	// 	} finally {
	// 		exitEventLoop(true);
	// 	}
	// });
	runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	logInfo("hello called");
	res.writeBody("Hello, World!");
}

void healthz(HTTPServerRequest req, HTTPServerResponse res)
{
	logInfo("health called");
	res.writeBody("OK");
}

void error(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error)
{
	res.render!("error.dt", req, error);
}

