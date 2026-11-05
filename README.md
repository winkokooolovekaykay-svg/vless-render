# VLESS + WebSocket + TLS on Render

Personal VLESS node running Xray-core as a free Render Docker web service.
TLS is terminated by Render's edge (`*.onrender.com:443`); Xray listens
plain WebSocket on `$PORT` inside the container.

## Deploy (Render dashboard)

1. New → Web Service → this repo, branch `master`, Runtime: Docker,
   Region: Singapore, Plan: Free, Name: `winkoko-vless`
2. Environment variables:
   - `UUID` — the VLESS client UUID (generate one, keep it private)
   - (Render sets `PORT` automatically)
3. Deploy. No health-check path needed (default check).

## Client link format

```
vless://<UUID>@winkoko-vless.onrender.com:443?encryption=none&security=tls&sni=winkoko-vless.onrender.com&type=ws&host=winkoko-vless.onrender.com&path=%2Fvless#Render-VLESS
```

Import it into v2rayNG / Streisand / FoXray / NekoBox.

## Limits (free tier)

- Sleeps after ~15 min idle (first connect takes ~30s to wake).
- 0.1 CPU / 512 MB — personal use only.
- TCP only, no UDP.
- Hobby bandwidth: 5 GB/month included, $0.15/GB overage — do not share
  the link publicly.
