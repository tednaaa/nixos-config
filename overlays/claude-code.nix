final: prev: {
  claude-code = prev.claude-code.overrideAttrs (_: {
    version = "2.1.92";
    src = prev.fetchurl {
      url = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/2.1.92/linux-x64/claude";
      sha256 = "sha256-4iMkUUln/y1en5Hw7jfkZ1v4tt/sJ/r7GcslzFsj/K8=";
    };
  });
}
