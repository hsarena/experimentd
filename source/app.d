<<<<<<< HEAD
import vibe.vibe;
import std.conv: to;
import std.process: environment;

void main()
{

	logInfo("Environments:");
=======
module source.app;
import source.api;
import vibe.vibe;
import std.conv : to;
import std.process : environment;
import std.typecons : Nullable;

void main()
{
	logInfo("Environment dump");
>>>>>>> 9289503 (Implement simple api)
    auto env = environment.toAA;
    foreach(k, v; env)
        logInfo("%s = %s", k, v);

<<<<<<< HEAD
    auto host = environment.get("LISTEN_IP", "0.0.0.0");
    auto port = to!ushort(environment.get("LISTEN_PORT", "8080"));

    auto router = new URLRouter;

    //router.registerRestInterface(new HelloImpl());
=======
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
>>>>>>> 9289503 (Implement simple api)

	auto settings = new HTTPServerSettings;
	settings.port = port;
	settings.bindAddresses = [host];
<<<<<<< HEAD

	listenHTTP(settings, &hello);

	logInfo("Please open http://%s:%d in your browser.", host, port);
=======
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
>>>>>>> 9289503 (Implement simple api)
	runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
<<<<<<< HEAD
=======
	logInfo("hello called");
>>>>>>> 9289503 (Implement simple api)
	res.writeBody("Hello, World!");
}

void healthz(HTTPServerRequest req, HTTPServerResponse res)
{
<<<<<<< HEAD
	res.writeBody("OK");
}

=======
	logInfo("health called");
	res.writeBody("OK");
}

void error(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error)
{
	res.render!("error.dt", req, error);
}

>>>>>>> 9289503 (Implement simple api)
