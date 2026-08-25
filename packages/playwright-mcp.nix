{
  writeShellApplication,
  chromium,
  nodejs,
}:

writeShellApplication {
  name = "playwright-mcp";

  runtimeInputs = [ nodejs ];

  text = ''
    exec npx -y @playwright/mcp@latest \
      --browser chromium \
      --executable-path ${chromium}/bin/chromium \
      "$@"
  '';
}
