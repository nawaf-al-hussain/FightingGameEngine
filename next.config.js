/** @type {import('next').NextConfig} */
const nextConfig = {
  // WASM files are served from public/game/ — no special webpack config needed
  // since Emscripten output is self-contained JS + .wasm + .data
  reactStrictMode: false, // avoid double-render issues with WASM canvas
};

module.exports = nextConfig;