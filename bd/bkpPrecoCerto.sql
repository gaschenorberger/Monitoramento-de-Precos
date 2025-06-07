--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_id_seq OWNER TO postgres;

--
-- Name: categorias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.categorias.id;


--
-- Name: historico_precos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historico_precos (
    id integer NOT NULL,
    produto_id integer NOT NULL,
    preco numeric(10,2) NOT NULL,
    coletado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.historico_precos OWNER TO postgres;

--
-- Name: historico_precos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historico_precos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historico_precos_id_seq OWNER TO postgres;

--
-- Name: historico_precos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historico_precos_id_seq OWNED BY public.historico_precos.id;


--
-- Name: lojas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lojas (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.lojas OWNER TO postgres;

--
-- Name: lojas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lojas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lojas_id_seq OWNER TO postgres;

--
-- Name: lojas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lojas_id_seq OWNED BY public.lojas.id;


--
-- Name: produtos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    preco_atual real NOT NULL,
    url text NOT NULL,
    imagem_url text,
    site_origem character varying(100) NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.produtos OWNER TO postgres;

--
-- Name: produtos_categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos_categorias (
    produto_id integer NOT NULL,
    categoria_id integer NOT NULL
);


ALTER TABLE public.produtos_categorias OWNER TO postgres;

--
-- Name: produtos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produtos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produtos_id_seq OWNER TO postgres;

--
-- Name: produtos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produtos_id_seq OWNED BY public.produtos.id;


--
-- Name: produtos_monitorados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos_monitorados (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    produto_id integer NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.produtos_monitorados OWNER TO postgres;

--
-- Name: produtos_monitorados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produtos_monitorados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produtos_monitorados_id_seq OWNER TO postgres;

--
-- Name: produtos_monitorados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produtos_monitorados_id_seq OWNED BY public.produtos_monitorados.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    senha_hash character varying(200) NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: vw_produtos_categorias; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_produtos_categorias AS
 SELECT p.id AS produto_id,
    p.nome AS nome_produto,
    p.preco_atual,
    p.url,
    p.imagem_url,
    p.site_origem,
    p.criado_em,
    c.id AS categoria_id,
    c.nome AS nome_categoria
   FROM ((public.produtos p
     JOIN public.produtos_categorias pc ON ((p.id = pc.produto_id)))
     JOIN public.categorias c ON ((pc.categoria_id = c.id)));


ALTER VIEW public.vw_produtos_categorias OWNER TO postgres;

--
-- Name: categorias id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- Name: historico_precos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_precos ALTER COLUMN id SET DEFAULT nextval('public.historico_precos_id_seq'::regclass);


--
-- Name: lojas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lojas ALTER COLUMN id SET DEFAULT nextval('public.lojas_id_seq'::regclass);


--
-- Name: produtos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos ALTER COLUMN id SET DEFAULT nextval('public.produtos_id_seq'::regclass);


--
-- Name: produtos_monitorados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_monitorados ALTER COLUMN id SET DEFAULT nextval('public.produtos_monitorados_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, nome) FROM stdin;
1	iPhone
2	Samsung
3	Notebook
4	Smartwatch
5	Headphone
6	Smartphone
7	Outros
\.


--
-- Data for Name: historico_precos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historico_precos (id, produto_id, preco, coletado_em) FROM stdin;
1	16	236.58	2025-06-03 00:08:39.047855
2	17	126.65	2025-06-03 00:08:39.296255
3	16	236.58	2025-06-03 00:11:07.341056
4	17	126.65	2025-06-03 00:11:07.597532
5	16	236.58	2025-06-03 00:12:32.898708
6	17	126.65	2025-06-03 00:12:33.056933
7	16	236.58	2025-06-03 00:13:42.677515
8	17	126.65	2025-06-03 00:13:42.851172
9	18	548.06	2025-06-03 00:14:54.988014
10	16	236.58	2025-06-03 00:14:55.268401
11	18	548.06	2025-06-03 00:16:02.633263
12	16	236.58	2025-06-03 00:16:02.940046
13	19	1099900.00	2025-06-03 00:17:23.618975
14	16	23658.00	2025-06-03 00:17:23.775825
15	17	12665.00	2025-06-03 00:17:23.922226
16	21	236.58	2025-06-03 00:19:40.608801
17	22	126.65	2025-06-03 00:19:40.771287
18	21	236.58	2025-06-03 00:20:22.777535
19	22	126.65	2025-06-03 00:20:23.035131
20	23	11.00	2025-06-03 00:22:16.181319
21	21	236.58	2025-06-03 00:22:16.319159
22	22	126.65	2025-06-03 00:22:16.454351
23	1	11.00	2025-06-03 00:25:05.731682
24	2	236.58	2025-06-03 00:25:05.888113
25	3	126.65	2025-06-03 00:25:06.133324
26	1	236.58	2025-06-03 00:39:01.488794
27	2	11.00	2025-06-03 00:39:01.629072
28	3	56.61	2025-06-03 00:39:01.767838
29	4	4.55	2025-06-03 00:45:12.074781
30	5	4.55	2025-06-03 00:45:12.205199
31	6	4.09	2025-06-03 00:45:12.333908
32	7	4734.81	2025-06-03 00:49:31.091158
33	8	4439.00	2025-06-03 00:49:31.22085
34	9	11369.00	2025-06-03 00:49:31.348833
35	10	110.19	2025-06-03 00:57:07.15492
36	11	69.00	2025-06-03 00:57:07.260559
37	12	648.90	2025-06-03 00:57:07.36298
38	13	2699.10	2025-06-03 00:57:07.463546
39	14	4399.00	2025-06-03 01:02:26.006543
40	15	3689.00	2025-06-03 01:02:27.52572
41	16	3689.00	2025-06-03 01:02:27.66508
42	17	989.00	2025-06-03 01:02:27.870408
43	1	236.58	2025-06-03 01:02:54.453311
44	2	11.00	2025-06-03 01:02:54.688751
45	3	56.61	2025-06-03 01:02:54.821729
46	4	4.55	2025-06-03 01:03:00.997937
47	5	4.55	2025-06-03 01:03:01.126757
48	6	4.09	2025-06-03 01:03:01.258455
49	7	4734.81	2025-06-03 01:03:10.74986
50	8	4439.00	2025-06-03 01:03:10.877057
51	9	11369.00	2025-06-03 01:03:11.008475
52	18	1799.10	2025-06-03 01:03:30.886496
53	19	1799.10	2025-06-03 01:03:30.990162
54	20	1699.00	2025-06-03 01:03:31.09507
55	12	648.90	2025-06-03 01:03:31.301191
56	1	236.58	2025-06-03 01:07:03.69314
57	2	11.00	2025-06-03 01:07:03.922649
58	3	56.61	2025-06-03 01:07:04.156762
59	4	4.55	2025-06-03 01:07:13.212181
60	5	4.55	2025-06-03 01:07:13.34429
61	6	4.09	2025-06-03 01:07:13.477365
62	7	4734.81	2025-06-03 01:07:24.812919
63	8	4439.00	2025-06-03 01:07:24.939466
64	9	11369.00	2025-06-03 01:07:25.066369
65	10	110.19	2025-06-03 01:07:47.636504
66	21	75.65	2025-06-03 01:07:47.837919
67	12	648.90	2025-06-03 01:07:47.938197
68	13	2699.10	2025-06-03 01:07:48.037209
69	22	2069.10	2025-06-03 01:08:06.380694
70	23	3599.10	2025-06-03 01:08:06.538746
71	24	2339.10	2025-06-03 01:08:07.804173
72	25	1969.00	2025-06-03 01:08:07.994518
73	1	11.00	2025-06-03 01:11:22.048659
74	2	236.58	2025-06-03 01:11:22.183392
75	3	56.61	2025-06-03 01:11:22.418946
76	4	4.55	2025-06-03 01:11:30.346625
77	5	4.55	2025-06-03 01:11:30.479338
78	6	4.09	2025-06-03 01:11:30.607647
79	7	4734.81	2025-06-03 01:11:41.902101
80	8	4439.00	2025-06-03 01:11:42.127359
81	9	11369.00	2025-06-03 01:11:42.251375
82	10	110.19	2025-06-03 01:12:03.856879
83	11	69.00	2025-06-03 01:12:03.953374
84	12	648.90	2025-06-03 01:12:04.049454
85	13	2699.10	2025-06-03 01:12:04.144215
86	14	1078.00	2025-06-03 01:12:13.984285
87	15	2339.10	2025-06-03 01:12:15.520935
88	16	899.00	2025-06-03 01:12:15.758149
89	17	1969.00	2025-06-03 01:12:15.982487
90	18	11.00	2025-06-03 01:17:40.585619
91	19	236.58	2025-06-03 01:17:40.723904
92	20	56.61	2025-06-03 01:17:40.860094
93	21	4.55	2025-06-03 01:17:48.772712
94	22	4.55	2025-06-03 01:17:49.013061
95	23	4.09	2025-06-03 01:17:49.251147
96	24	4734.81	2025-06-03 01:18:01.659324
97	25	4439.00	2025-06-03 01:18:01.79489
98	26	11369.00	2025-06-03 01:18:01.921031
99	27	110.19	2025-06-03 01:18:27.814032
100	28	75.65	2025-06-03 01:18:27.9135
101	29	648.90	2025-06-03 01:18:28.011945
102	30	2699.10	2025-06-03 01:18:28.112622
103	1	11.00	2025-06-03 01:30:28.880839
104	2	236.58	2025-06-03 01:30:29.118735
105	3	56.61	2025-06-03 01:30:29.250832
106	4	4.55	2025-06-03 01:30:37.80964
107	5	4.55	2025-06-03 01:30:37.941941
108	6	4.09	2025-06-03 01:30:38.075369
109	7	4734.81	2025-06-03 01:30:48.063189
110	8	4439.00	2025-06-03 01:30:48.190439
111	9	11369.00	2025-06-03 01:30:48.316965
112	10	110.19	2025-06-03 01:31:11.288013
113	11	98.79	2025-06-03 01:31:11.384053
114	12	648.90	2025-06-03 01:31:11.481511
115	13	2699.10	2025-06-03 01:31:11.578073
116	14	759.00	2025-06-03 01:31:25.655352
117	15	2069.10	2025-06-03 01:31:26.922528
118	16	2339.10	2025-06-03 01:31:27.146877
119	17	2199.00	2025-06-03 01:31:27.404625
120	1	11.00	2025-06-03 01:34:22.208732
121	2	236.58	2025-06-03 01:34:22.451117
122	3	56.61	2025-06-03 01:34:22.6936
123	4	4.55	2025-06-03 01:34:30.680331
124	5	4.55	2025-06-03 01:34:30.91277
125	6	4.09	2025-06-03 01:34:31.146351
126	7	4734.81	2025-06-03 01:34:43.939727
127	8	4439.00	2025-06-03 01:34:44.064884
128	9	11369.00	2025-06-03 01:34:44.190008
129	10	110.19	2025-06-03 01:35:06.722247
130	11	98.79	2025-06-03 01:35:06.824877
131	12	648.90	2025-06-03 01:35:06.926668
132	13	2699.10	2025-06-03 01:35:07.028313
133	14	759.00	2025-06-03 01:35:16.963317
134	15	2069.10	2025-06-03 01:35:17.220353
135	16	2339.10	2025-06-03 01:35:18.986761
136	17	2199.00	2025-06-03 01:35:19.255284
137	1	11.00	2025-06-03 01:44:30.354815
138	2	236.58	2025-06-03 01:44:30.498541
139	3	56.61	2025-06-03 01:44:30.63933
140	4	4.55	2025-06-03 01:44:38.728934
141	5	4.55	2025-06-03 01:44:38.87051
142	6	4.09	2025-06-03 01:44:39.121587
143	7	4734.81	2025-06-03 01:44:51.234735
144	8	4439.00	2025-06-03 01:44:51.372886
145	9	11369.00	2025-06-03 01:44:51.516389
146	10	110.19	2025-06-03 01:45:14.19257
147	11	98.79	2025-06-03 01:45:14.296068
148	12	648.90	2025-06-03 01:45:14.398016
149	13	2699.10	2025-06-03 01:45:14.500889
150	14	809.10	2025-06-03 01:45:25.16136
151	15	899.00	2025-06-03 01:45:26.452101
152	16	759.00	2025-06-03 01:45:26.656838
153	17	759.00	2025-06-03 01:45:26.818457
154	1	11.00	2025-06-03 01:49:14.028042
155	2	236.58	2025-06-03 01:49:14.262767
156	3	56.61	2025-06-03 01:49:14.411991
157	4	4.55	2025-06-03 01:49:22.473735
158	5	4.55	2025-06-03 01:49:22.712585
159	6	4.09	2025-06-03 01:49:22.844638
160	7	4734.81	2025-06-03 01:49:35.4183
161	8	4439.00	2025-06-03 01:49:35.545729
162	9	11369.00	2025-06-03 01:49:35.670773
163	10	110.19	2025-06-03 01:49:57.004076
164	11	98.79	2025-06-03 01:49:57.207408
165	12	648.90	2025-06-03 01:49:57.304551
166	13	2699.10	2025-06-03 01:49:57.507596
167	1	11.00	2025-06-03 01:59:33.538761
168	2	236.58	2025-06-03 01:59:33.67226
169	3	56.61	2025-06-03 01:59:33.808019
170	4	4.55	2025-06-03 01:59:42.245454
171	5	4.55	2025-06-03 01:59:42.380676
172	6	4.09	2025-06-03 01:59:42.510606
173	7	4734.81	2025-06-03 01:59:54.282711
174	8	4439.00	2025-06-03 01:59:54.411943
175	9	11369.00	2025-06-03 01:59:54.638285
176	10	94.99	2025-06-03 02:00:17.16082
177	11	1390.00	2025-06-03 02:00:17.35743
178	12	648.90	2025-06-03 02:00:17.453109
179	13	2699.10	2025-06-03 02:00:17.547703
180	14	1716.00	2025-06-03 02:00:27.307784
181	15	3599.10	2025-06-03 02:00:28.53128
182	16	1716.00	2025-06-03 02:00:28.718344
183	17	3599.10	2025-06-03 02:00:28.89361
184	18	9.50	2025-06-04 01:06:32.225672
185	19	241.20	2025-06-04 01:06:32.384825
186	20	5.10	2025-06-04 01:06:32.545148
187	21	56.61	2025-06-04 01:06:32.677635
188	18	9499.00	2025-06-04 01:07:49.915969
189	19	24120.00	2025-06-04 01:07:50.062045
190	20	5099.00	2025-06-04 01:07:50.318937
191	21	5661.00	2025-06-04 01:07:50.448393
192	22	359222.00	2025-06-04 01:07:50.576527
193	18	9.50	2025-06-04 01:12:14.289022
194	19	241.20	2025-06-04 01:12:14.448404
195	20	5.10	2025-06-04 01:12:14.602633
196	21	56.61	2025-06-04 01:12:14.865692
197	22	3592.22	2025-06-04 01:12:14.99575
198	23	1.28	2025-06-04 01:12:23.579073
199	6	1.28	2025-06-04 01:12:23.816354
200	24	779.00	2025-06-04 01:12:23.948785
201	25	779.00	2025-06-04 01:12:24.07824
202	26	3.80	2025-06-04 01:12:24.208674
203	8	4439.00	2025-06-04 01:12:35.097018
204	9	11369.00	2025-06-04 01:12:35.223409
205	27	4579.00	2025-06-04 01:12:35.353343
206	7	5087.15	2025-06-04 01:12:35.47855
207	28	6279.00	2025-06-04 01:12:35.628431
208	29	899.10	2025-06-04 01:13:03.412713
209	30	899.10	2025-06-04 01:13:03.508805
210	31	2159.10	2025-06-04 01:13:03.702803
211	32	329.00	2025-06-04 01:13:03.799867
212	12	699.00	2025-06-04 01:13:03.89498
213	33	3599.10	2025-06-04 01:13:13.960252
214	34	8999.10	2025-06-04 01:13:15.44248
215	35	3149.00	2025-06-04 01:13:15.678008
216	36	4499.91	2025-06-04 01:13:15.820656
\.


--
-- Data for Name: lojas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lojas (id, nome) FROM stdin;
1	Amazon
2	Mercado Livre
3	Americanas
4	Magazine Luiza
5	Casas Bahia
\.


--
-- Data for Name: produtos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos (id, nome, preco_atual, url, imagem_url, site_origem, criado_em) FROM stdin;
1	Apple 2024 MacBook Air (de 15 polegadas, Processador M3 da Apple com CPU 8‑core e GPU 10‑core, 16GB Memória unificada, 256 GB) - Luz das estrelas	10.999	https://www.amazon.com.br/Apple-MacBook-polegadas-Processador-unificada/dp/B0DLJ83RGF?pd_rd_w=0CRup&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=W31FJQTPJ2K7NCN4MA0T&pd_rd_wg=z3Fh3&pd_rd_r=67510e30-373c-45e0-b783-0dccd5b5f9ce&pd_rd_i=B0DLJ83RGF	https://m.media-amazon.com/images/I/410iQVdB1vL._SR480,440_.jpg	Amazon	2025-06-03 00:00:00
2	FIFINE USB Microfone jogos para PC,streaming,podcasts,gravação,microfono condensador de mesa para computador,compatível com Mac/PS4/PS5,com controle RGB,toque mudo,conector para fone ouvido- A8 Preto	236.58	https://www.amazon.com.br/FIFINEUSB-condensador-computador-compat%C3%ADvel-A8/dp/B09YLM3FNC?pd_rd_w=0CRup&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=W31FJQTPJ2K7NCN4MA0T&pd_rd_wg=z3Fh3&pd_rd_r=67510e30-373c-45e0-b783-0dccd5b5f9ce&pd_rd_i=B09YLM3FNC	https://m.media-amazon.com/images/I/41WHQwPXatL._SR480,440_.jpg	Amazon	2025-06-03 00:00:00
4	Notebook Lenovo LOQ-e 15iax9e Intel Core i5-12450hx 16gb 512gb Ssd Rtx 3050 Linux 15.6 - 83mes00000 Luna Grey	4.549	https://www.mercadolivre.com.br/notebook-lenovo-loq-e-15iax9e-intel-core-i5-12450hx-16gb-512gb-ssd-rtx-3050-linux-156-83mes00000-luna-grey/p/MLB46041404?pdp_filters=deal:MLB779362-1#wid=MLB3982993861&sid=search&searchVariation=MLB46041404&position=8&search_layout=stack&type=product&tracking_id=98c3f087-53fd-4c3c-9242-73b878f777ae&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=1&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=93f65a25-4037-11f0-a762-8dcff8f6a7c5&c_element_id=93f65a25-4037-11f0-a762-8dcff8f6a7c5&c_global_position=5&deal_print_id=93fbb150-4037-11f0-92a7-f3e38286dfa0&c_tracking_id=93fbb150-4037-11f0-92a7-f3e38286dfa0	https://http2.mlstatic.com/D_Q_NP_616917-MLA82397783055_022025-P.webp	Mercado Livre	2025-06-03 00:00:00
5	Notebook Dell Inspiron I15-i120k-a35p I5 16gb 1tb 15.6 W11	4.549	https://www.mercadolivre.com.br/notebook-dell-inspiron-i15-i120k-a35p-i5-16gb-1tb-156-w11/p/MLB37650721?pdp_filters=deal:MLB779362-1#wid=MLB4830712680&sid=search&searchVariation=MLB37650721&position=7&search_layout=stack&type=product&tracking_id=98c3f087-53fd-4c3c-9242-73b878f777ae&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=2&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=93f65a26-4037-11f0-a762-8dcff8f6a7c5&c_element_id=93f65a26-4037-11f0-a762-8dcff8f6a7c5&c_global_position=5&deal_print_id=93fbb150-4037-11f0-92a7-f3e38286dfa0&c_tracking_id=93fbb150-4037-11f0-92a7-f3e38286dfa0	https://http2.mlstatic.com/D_Q_NP_682715-MLU76925036775_062024-P.webp	Mercado Livre	2025-06-03 00:00:00
10	Carregador Usb-C 20W Turbo Compativel Com Iphone-11-12-13-14-15 - Adaptador Tomada Fonte Turbo-Original-Foxcom todos modelos	94.99	/carregador-usb-c-20w-turbo-compativel-com-iphone-11-12-13-14-15-adaptador-tomada-fonte-turbo-original-foxcom-todos-modelos/p/hedd6aec3j/te/cdcl/?seller_id=conexaocelloficial	https://a-static.mlcdn.com.br/280x210/carregador-usb-c-20w-turbo-compativel-com-iphone-11-12-13-14-15-adaptador-tomada-fonte-turbo-original-foxcom-todos-modelos/conexaocelloficial/ftusbc80/448f890ee15391adfa717cfedc970d50.jpeg	Magazine Luiza	2025-06-03 00:00:00
11	Estabilizador Osmo Mobile 6 (Platinum) DJI - DJI113	1390	/estabilizador-osmo-mobile-6-platinum-dji-dji113/p/dfg5gf4jha/te/etcl/?seller_id=obaboxtecnologia	https://a-static.mlcdn.com.br/280x210/estabilizador-osmo-mobile-6-platinum-dji-dji113/obaboxtecnologia/15004582/4a2b8a95ca58e0dd4d52160ddde7f763.jpeg	Magazine Luiza	2025-06-03 00:00:00
13	Smartphone Samsung Galaxy S24 FE 128GB Grafite 5G 8GB RAM 6,7" Câm. Tripla + Selfie 10MP	2699.1	/smartphone-samsung-galaxy-s24-fe-128gb-grafite-5g-8gb-ram-67-cam-tripla-selfie-10mp/p/240010800/te/s24f/	https://a-static.mlcdn.com.br/280x210/smartphone-samsung-galaxy-s24-fe-128gb-grafite-5g-8gb-ram-67-cam-tripla-selfie-10mp/magazineluiza/240010800/cb7f1ca382009d6cca85a254ca69a9ae.jpg	Magazine Luiza	2025-06-03 00:00:00
8	iPhone 13 Apple 128GB iOS 5G Wi-Fi Tela 6.1'' Câmera Dupla 12MP - Meia-Noite	4439	https://www.americanas.com.br/iphone-13-apple-128gb-ios-5g-wi-fi-tela-6-1-camera-dupla-12mp-meia-noite-4864625497/p	https://americanas.vtexassets.com/arquivos/ids/543035/4864625500_1SZ.jpg?v=638750836071000000	Americanas	2025-06-03 00:00:00
9	Apple iPhone 16 Pro Max 256GB Titânio Natural	11369	https://www.americanas.com.br/apple-iphone-16-pro-max-256gb-titanio-natural-7508564123/p	https://americanas.vtexassets.com/arquivos/ids/430925/7508564123_1_xlarge.jpg?v=638750822551200000	Americanas	2025-06-03 00:00:00
7	Apple iPhone 14 128GB iOS 5G Wi-Fi Tela 6.1" Câmera Dupla 12MP - Meia Noite	5087.15	https://www.americanas.com.br/apple-iphone-14-128gb-ios-5g-wi-fi-tela-6-1-camera-dupla-12mp-meia-noite-5884145714/p	https://americanas.vtexassets.com/arquivos/ids/439178/5884146047_1SZ.jpg?v=638750823947000000	Americanas	2025-06-03 00:00:00
12	Smartphone Samsung Galaxy A06 128GB 4GB RAM Azul Escuro 6,7" Câm. Dupla + Selfie 8MP	699	https://www.magazineluiza.com.br/smartphone-samsung-galaxy-a06-128gb-4gb-ram-azul-escuro-67-cam-dupla-selfie-8mp/p/238657700/te/ga06/	https://a-static.mlcdn.com.br/280x210/smartphone-samsung-galaxy-a06-128gb-4gb-ram-azul-escuro-67-cam-dupla-selfie-8mp/magazineluiza/238657700/fca7f701abc03293954ba82835473323.jpg	Magazine Luiza	2025-06-03 00:00:00
22	Notebook VAIO FE16 AMD Ryzen 7-5700U Linux 16GB 512GB SSD Tela 16" IPS WUXGA Antireflexo - Cinza Grafite	3592.22	https://www.amazon.com.br/Notebook-VAIO-Ryzen-7-5700U-Antireflexo/dp/B0DZZCQ4RX?pd_rd_w=upoki&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=2JH99KRD0V1ATB701SRV&pd_rd_wg=l02Ag&pd_rd_r=332b311f-258a-45b4-b00d-a326612b8c6a&pd_rd_i=B0DZZCQ4RX	https://m.media-amazon.com/images/I/41DgkAMwFsL._SR480,440_.jpg	Amazon	2025-06-04 00:00:00
23	Pc Computador Completo Intel I5 16gb Ssd 480gb Monitor 19	1.281	https://produto.mercadolivre.com.br/MLB-3846072266-pc-computador-completo-intel-i5-16gb-ssd-480gb-monitor-19-_JM#position=20&search_layout=stack&type=item&tracking_id=717aec74-6903-47a2-9ade-fa79845a6d29&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=1&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=2489d5e5-40fa-11f0-a310-7b3fff887a6b&c_element_id=2489d5e5-40fa-11f0-a310-7b3fff887a6b&c_global_position=5&deal_print_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6&c_tracking_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6	https://http2.mlstatic.com/D_Q_NP_923086-MLB82423196736_022025-P.webp	Mercado Livre	2025-06-04 00:00:00
6	Monitor Gamer Aoc 24 180hz 1ms Hdr Ips 24g30e	1.281	https://www.mercadolivre.com.br/monitor-gamer-aoc-24-180hz-1ms-hdr-ips-24g30e/p/MLB46127138?pdp_filters=deal:MLB779362-1#wid=MLB3978668905&sid=search&searchVariation=MLB46127138&position=1&search_layout=stack&type=product&tracking_id=717aec74-6903-47a2-9ade-fa79845a6d29&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=2&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=2489d5e6-40fa-11f0-a310-7b3fff887a6b&c_element_id=2489d5e6-40fa-11f0-a310-7b3fff887a6b&c_global_position=5&deal_print_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6&c_tracking_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6	https://http2.mlstatic.com/D_Q_NP_990738-MLA82208796708_022025-P.webp	Mercado Livre	2025-06-03 00:00:00
24	Notebook Samsung Galaxy Book4 Intel® Core™ i5-1335U (1.3 Ghz, até 4.6GHz, 12 MB L3 Cache), Windows 11 Home, 8GB, 512GB SSD, Iris Xe, 15.6'' Full HD LED, 1.55kg	779	https://www.mercadolivre.com.br/notebook-samsung-galaxy-book4-intel-core-i5-1335u-13-ghz-ate-46ghz-12-mb-l3-cache-windows-11-home-8gb-512gb-ssd-iris-xe-156-full-hd-led-155kg/p/MLB37044038?pdp_filters=deal:MLB779362-1#wid=MLB3964026507&sid=search&searchVariation=MLB37044038&position=2&search_layout=stack&type=product&tracking_id=717aec74-6903-47a2-9ade-fa79845a6d29&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=3&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=2489d5e7-40fa-11f0-a310-7b3fff887a6b&c_element_id=2489d5e7-40fa-11f0-a310-7b3fff887a6b&c_global_position=5&deal_print_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6&c_tracking_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6	https://http2.mlstatic.com/D_Q_NP_618141-MLU76378990682_052024-P.webp	Mercado Livre	2025-06-04 00:00:00
18	Apple 2024 MacBook Air (de 13 polegadas, Processador M3 da Apple com CPU 8‑core e GPU 8‑core, 16GB Memória unificada, 256 GB) - Prateado	9.499	https://www.amazon.com.br/Apple-MacBook-polegadas-Processador-unificada/dp/B0DLHHTLTB?pd_rd_w=upoki&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=2JH99KRD0V1ATB701SRV&pd_rd_wg=l02Ag&pd_rd_r=332b311f-258a-45b4-b00d-a326612b8c6a&pd_rd_i=B0DLHHTLTB	https://m.media-amazon.com/images/I/41nuKghpShL._SR480,440_.jpg	Amazon	2025-06-04 00:00:00
19	XPPen 2024 mesa digitalizadora Deco 640 6" com chave virtual	241.2	https://www.amazon.com.br/XPPen-2024-digitalizadora-chave-virtual/dp/B0D8J1MHP3?pd_rd_w=upoki&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=2JH99KRD0V1ATB701SRV&pd_rd_wg=l02Ag&pd_rd_r=332b311f-258a-45b4-b00d-a326612b8c6a&pd_rd_i=B0D8J1MHP3	https://m.media-amazon.com/images/I/31eLkiECWpL._SR480,440_.jpg	Amazon	2025-06-04 00:00:00
20	Apple 2025 iPad (Wi-Fi, 256 GB) - Prateado (A16)	5.099	https://www.amazon.com.br/Apple-2025-iPad-Wi-Fi-256/dp/B0DZK1WDW7?pd_rd_w=upoki&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=2JH99KRD0V1ATB701SRV&pd_rd_wg=l02Ag&pd_rd_r=332b311f-258a-45b4-b00d-a326612b8c6a&pd_rd_i=B0DZK1WDW7	https://m.media-amazon.com/images/I/31HhoNJrO7L._SR480,440_.jpg	Amazon	2025-06-04 00:00:00
25	Impressora multifuncional cor Epson EcoTank L3250 127/220V	779	https://www.mercadolivre.com.br/impressora-multifuncional-cor-epson-ecotank-l3250-127220v/p/MLB26986602?pdp_filters=deal:MLB779362-1#wid=MLB4501587604&sid=search&searchVariation=MLB26986602&position=6&search_layout=stack&type=product&tracking_id=717aec74-6903-47a2-9ade-fa79845a6d29&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=4&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=2489fcf0-40fa-11f0-a310-7b3fff887a6b&c_element_id=2489fcf0-40fa-11f0-a310-7b3fff887a6b&c_global_position=5&deal_print_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6&c_tracking_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6	https://http2.mlstatic.com/D_Q_NP_662288-MLU77913086438_082024-P.webp	Mercado Livre	2025-06-04 00:00:00
26	Notebook Positivo Vision C14 Lumina Bar Celeron 8gb 256gb Emmc Tela 14 Polegadas Hd Antirreflexo Linux Tecla Link - Cinza	3.799	https://www.mercadolivre.com.br/notebook-positivo-vision-c14-lumina-bar-celeron-8gb-256gb-emmc-tela-14-polegadas-hd-antirreflexo-linux-tecla-link-cinza/p/MLB38031777?pdp_filters=deal:MLB779362-1#wid=MLB4025297005&sid=search&searchVariation=MLB38031777&position=7&search_layout=stack&type=product&tracking_id=717aec74-6903-47a2-9ade-fa79845a6d29&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=5&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=2489fcf1-40fa-11f0-a310-7b3fff887a6b&c_element_id=2489fcf1-40fa-11f0-a310-7b3fff887a6b&c_global_position=5&deal_print_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6&c_tracking_id=24914ff0-40fa-11f0-bc2f-f1d4672941a6	https://http2.mlstatic.com/D_Q_NP_960836-MLU77275893974_072024-P.webp	Mercado Livre	2025-06-04 00:00:00
27	iPhone 13 Apple 128GB iOS 5G Wi-Fi Tela 6.1'' Câmera Dupla 12MP - Estelar	4579	https://www.americanas.com.br/iphone-13-apple-128gb-ios-5g-wi-fi-tela-6-1-camera-dupla-12mp-estelar-4864628680/p	https://americanas.vtexassets.com/arquivos/ids/30035456/4864628698_1SZ.jpg?v=638792860509300000	Americanas	2025-06-04 00:00:00
28	Apple iPhone 16 128GB Ultramarino	6279	https://www.americanas.com.br/apple-iphone-16-128gb-ultramarino-7510343862/p	https://americanas.vtexassets.com/arquivos/ids/461212/7510343863_1SZ.jpg?v=638822351217370000	Americanas	2025-06-04 00:00:00
29	Smartphone Motorola Moto G15 256GB Verde 4G 4GB RAM 6,7" Câm. Dupla Selfie 8MP	899.1	https://www.magazineluiza.com.br/smartphone-motorola-moto-g15-256gb-verde-4g-4gb-ram-67-cam-dupla-selfie-8mp/p/238974400/te/g200/?seller_id=motorola-1p	https://a-static.mlcdn.com.br/280x210/smartphone-motorola-moto-g15-256gb-verde-4g-4gb-ram-67-cam-dupla-selfie-8mp/magazineluiza/238974400/0fbd99e1681805da5c73a8caaa4e5c8a.jpg	Magazine Luiza	2025-06-04 00:00:00
30	Smartphone Motorola Moto G15 256GB Grafite 4G 4GB RAM 6,7" Câm. Dupla Selfie 8MP	899.1	https://www.magazineluiza.com.br/smartphone-motorola-moto-g15-256gb-grafite-4g-4gb-ram-67-cam-dupla-selfie-8mp/p/238974500/te/mg60/?seller_id=motorola-1p	https://a-static.mlcdn.com.br/280x210/smartphone-motorola-moto-g15-256gb-grafite-4g-4gb-ram-67-cam-dupla-selfie-8mp/magazineluiza/238974500/00b2c309c085e3d6021844a439201fce.jpg	Magazine Luiza	2025-06-04 00:00:00
31	Smartphone Samsung Galaxy A56 128GB 5G 8GB RAM Rosa 6,7" Câm. Tripla + Selfie 12MP	2159.1	https://www.magazineluiza.com.br/smartphone-samsung-galaxy-a56-128gb-5g-8gb-ram-rosa-67-cam-tripla-selfie-12mp/p/240097200/te/ga56/	https://a-static.mlcdn.com.br/280x210/smartphone-samsung-galaxy-a56-128gb-5g-8gb-ram-rosa-67-cam-tripla-selfie-12mp/magazineluiza/240097200/d9169f94917a9bb1de62d34fc43bb0ad.jpg	Magazine Luiza	2025-06-04 00:00:00
32	Smartband Samsung Galaxy Fit3 Prata	329	https://www.magazineluiza.com.br/smartband-samsung-galaxy-fit3-prata/p/237270800/te/smba/	https://a-static.mlcdn.com.br/280x210/smartband-samsung-galaxy-fit3-prata/magazineluiza/237270800/2b5fe640334363861f98dec293b68344.jpg	Magazine Luiza	2025-06-04 00:00:00
\.


--
-- Data for Name: produtos_categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos_categorias (produto_id, categoria_id) FROM stdin;
1	3
2	5
4	3
5	3
6	7
7	6
7	1
8	6
8	1
9	6
9	1
10	6
10	1
11	7
12	2
12	6
13	2
13	6
18	3
19	7
20	7
22	3
23	7
24	2
24	3
24	6
25	7
26	3
27	6
27	1
28	6
28	1
29	6
30	6
31	2
31	6
32	2
32	6
\.


--
-- Data for Name: produtos_monitorados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos_monitorados (id, usuario_id, produto_id, criado_em) FROM stdin;
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nome, email, senha_hash, criado_em) FROM stdin;
\.


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 7, true);


--
-- Name: historico_precos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_precos_id_seq', 216, true);


--
-- Name: lojas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lojas_id_seq', 5, true);


--
-- Name: produtos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_id_seq', 36, true);


--
-- Name: produtos_monitorados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_monitorados_id_seq', 1, false);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 1, false);


--
-- Name: categorias categorias_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nome_key UNIQUE (nome);


--
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: historico_precos historico_precos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historico_precos
    ADD CONSTRAINT historico_precos_pkey PRIMARY KEY (id);


--
-- Name: lojas lojas_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lojas
    ADD CONSTRAINT lojas_nome_key UNIQUE (nome);


--
-- Name: lojas lojas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lojas
    ADD CONSTRAINT lojas_pkey PRIMARY KEY (id);


--
-- Name: produtos_categorias produtos_categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_categorias
    ADD CONSTRAINT produtos_categorias_pkey PRIMARY KEY (produto_id, categoria_id);


--
-- Name: produtos_monitorados produtos_monitorados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_monitorados
    ADD CONSTRAINT produtos_monitorados_pkey PRIMARY KEY (id);


--
-- Name: produtos produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: produtos_categorias produtos_categorias_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_categorias
    ADD CONSTRAINT produtos_categorias_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias(id) ON DELETE CASCADE;


--
-- Name: produtos_categorias produtos_categorias_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_categorias
    ADD CONSTRAINT produtos_categorias_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produtos(id) ON DELETE CASCADE;


--
-- Name: produtos_monitorados produtos_monitorados_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_monitorados
    ADD CONSTRAINT produtos_monitorados_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produtos(id) ON DELETE CASCADE;


--
-- Name: produtos_monitorados produtos_monitorados_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos_monitorados
    ADD CONSTRAINT produtos_monitorados_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

