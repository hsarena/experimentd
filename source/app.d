import vibe.vibe;
import std.conv: to;
import std.process: environment;

void main()
{

	logInfo("Environments:");
    auto env = environment.toAA;
    foreach(k, v; env)
        logInfo("%s = %s", k, v);

    auto host = environment.get("LISTEN_IP", "0.0.0.0");
    auto port = to!ushort(environment.get("LISTEN_PORT", "8080"));

    auto router = new URLRouter;

    //router.registerRestInterface(new HelloImpl());

	auto settings = new HTTPServerSettings;
	settings.port = port;
	settings.bindAddresses = [host];

	listenHTTP(settings, &hello);

	logInfo("Please open http://%s:%d in your browser.", host, port);
	runApplication();
}

void hello(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("Hello, World!");
}

void healthz(HTTPServerRequest req, HTTPServerResponse res)
{
	res.writeBody("OK");
}

