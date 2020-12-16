<%!
    private String lp_encode(String src, String code, String pad)
    {
        try
        {
            java.util.Random rnd = new java.util.Random();

            int r1 = (int)(Math.random() * 63);
            String r2 = pad.substring(r1, r1 + 1);

            pad = pad.substring(r1) + pad.substring(0, r1);

            int v1 = 0;
            int v2 = 0;
            int v3 = 0;
            int v4 = 0;
            String rst = "";

            src = new String(src.getBytes("KSC5601"), "8859_1");

            int i =0;
            int j = src.length() / 3;

            if (src.length() % 3 > 0)
                j++;

            for (i = 0 ; i < j; i++)
            {
                int s1 = 0;
                int s2 = 0;
                int s3 = 0;

                s1 = src.substring(i * 3 + 0, i * 3 + 0+1).hashCode();
                if ((i * 3 + 1) < src.length()) s2 = src.substring(i * 3 + 1, i * 3 + 1 +1).hashCode();
                if ((i * 3 + 2) < src.length()) s3 = src.substring(i * 3 + 2, i * 3 + 2 +1).hashCode();

                int i1 = ((s1 >> 2) ^  (i & 0x3f)) & 0x3f;
                int i2 = ((((s1 & 0x03) << 4) | (s2 >> 4)) ^ (i & 0x3f)) & 0x3f;
                int i3 = ((((s2 & 0x0f) << 2) | (s3 >> 6)) ^ (i & 0x3f)) & 0x3f;
                int i4 = ((s3 & 0x3f) ^ (i & 0x3f)) & 0x3f;

                String c1 = "";
                String c2 = "";
                String c3 = "";
                String c4 = "";

                c1 = pad.substring(i1, i1+1);
                c2 = pad.substring(i2, i2+1);
                c3 = pad.substring(i3, i3+1);
                c4 = pad.substring(i4, i4+1);

                byte[] c1_b = c1.getBytes();
                byte[] c2_b = c2.getBytes();
                byte[] c3_b = c3.getBytes();
                byte[] c4_b = c4.getBytes();

                if (c1_b.length > 0) v1 = ((v1 + (int)c1_b[0]) & 0x3f);
                if (c2_b.length > 0) v2 = ((v2 + (int)c2_b[0]) & 0x3f);
                if (c3_b.length > 0) v3 = ((v3 + (int)c3_b[0]) & 0x3f);
                if (c4_b.length > 0) v4 = ((v4 + (int)c4_b[0]) & 0x3f);

                rst += c4 + c2 + c3 + c1;
            }

            String v = pad.substring(v1, v1+1)+pad.substring(v2, v2+1)+pad.substring(v3, v3+1)+pad.substring(v4, v4+1);

            return r2 + rst + v + code;
        }
        catch (Exception e)
        {
            return "";
        }
    }

    private String lp_url_trt(String url, String code, String pad)
    {
        return url.substring(0, url.indexOf("?") + 1)+"lpev="+lp_encode(url.substring(url.indexOf("?") + 1), code, pad);
    }
%>