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
    preco text NOT NULL,
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
    preco_atual text NOT NULL,
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
217	102	3.699,00	2025-07-07 22:26:39.636747
218	103	99,00	2025-07-07 22:26:39.857848
219	104	249,00	2025-07-07 22:26:40.071714
220	105	2.678,00	2025-07-07 22:26:40.181084
221	106	4.399,00	2025-07-07 22:26:40.405258
222	107	4.679,00	2025-07-07 22:26:50.730837
223	108	4.679,90	2025-07-07 22:26:50.84125
224	24	2.898,00	2025-07-07 22:26:51.056666
225	109	2.898,00	2025-07-07 22:26:51.170063
226	110	3.839,00	2025-07-07 22:26:51.38451
227	27	4.579,00	2025-07-07 22:27:07.301345
228	111	6.469,73	2025-07-07 22:27:07.403842
229	112	6.545,87	2025-07-07 22:27:07.609915
230	113	12.749,00	2025-07-07 22:27:07.711006
231	114	11.369,00	2025-07-07 22:27:07.813231
232	31	1.969,00	2025-07-07 22:27:30.774149
233	115	4.949,10	2025-07-07 22:27:30.849285
234	116	1.304,10	2025-07-07 22:27:30.925099
235	12	649,00	2025-07-07 22:27:31.107834
236	117	1.259,10	2025-07-07 22:27:31.181545
237	118	3.509,10	2025-07-07 22:27:40.572278
238	119	649,00	2025-07-07 22:27:40.694835
239	120	899,10	2025-07-07 22:27:40.816013
240	121	649,00	2025-07-07 22:27:41.035947
241	122	3.699,00	2025-07-07 22:33:11.97471
242	123	99,00	2025-07-07 22:33:12.200892
243	124	249,00	2025-07-07 22:33:12.32612
244	125	2.678,00	2025-07-07 22:33:12.448691
245	126	4.399,00	2025-07-07 22:33:12.57578
246	127	4.679,00	2025-07-07 22:33:22.100434
247	128	4.679,90	2025-07-07 22:33:22.329568
248	129	2.898,00	2025-07-07 22:33:22.455534
249	130	2.898,00	2025-07-07 22:33:22.573427
250	131	3.839,00	2025-07-07 22:33:22.686074
251	132	4.579,00	2025-07-07 22:33:38.314921
252	133	6.469,73	2025-07-07 22:33:38.417893
253	134	6.545,87	2025-07-07 22:33:38.520183
254	135	12.749,00	2025-07-07 22:33:38.736215
255	136	11.369,00	2025-07-07 22:33:38.847169
256	137	1.969,00	2025-07-07 22:34:00.780251
257	138	1.304,10	2025-07-07 22:34:00.959795
258	139	649,00	2025-07-07 22:34:01.0356
259	140	1.259,10	2025-07-07 22:34:01.110696
260	141	1.664,10	2025-07-07 22:34:01.185829
261	142	1.619,10	2025-07-07 22:34:11.403234
262	143	989,10	2025-07-07 22:34:11.639904
263	144	1.665,00	2025-07-07 22:34:11.772827
264	145	1.619,10	2025-07-07 22:34:11.893611
265	146	3.699,00	2025-07-07 22:36:59.064802
266	147	99,00	2025-07-07 22:36:59.180003
267	148	249,00	2025-07-07 22:36:59.29402
268	149	2.678,00	2025-07-07 22:36:59.411189
269	150	4.399,00	2025-07-07 22:36:59.658959
270	151	4.679,00	2025-07-07 22:37:09.080081
271	152	4.679,90	2025-07-07 22:37:09.290284
272	153	2.898,00	2025-07-07 22:37:09.511086
273	154	2.898,00	2025-07-07 22:37:09.745479
274	155	3.839,00	2025-07-07 22:37:09.955963
275	156	4.579,00	2025-07-07 22:37:25.19131
276	157	6.469,73	2025-07-07 22:37:25.295051
277	158	6.545,87	2025-07-07 22:37:25.409522
278	159	12.749,00	2025-07-07 22:37:25.512607
279	160	11.369,00	2025-07-07 22:37:25.725195
280	161	1.969,00	2025-07-07 22:37:48.031793
281	162	1.304,10	2025-07-07 22:37:48.206058
282	163	649,00	2025-07-07 22:37:48.281454
283	164	1.259,10	2025-07-07 22:37:48.357849
284	165	1.664,10	2025-07-07 22:37:48.434502
285	166	5.100,00	2025-07-07 22:37:57.697471
286	167	3.779,10	2025-07-07 22:37:57.818305
287	168	850,00	2025-07-07 22:37:57.937958
288	169	989,00	2025-07-07 22:37:58.17632
289	170	899,10	2025-07-07 22:37:58.405567
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
146	Notebook Dell Inspiron I15-I1300-M50P 15.6" Full HD 13ª Gen Intel Core i5 16GB 512GB SSD Win 11 Preto Carbono	3.699,00	https://www.amazon.com.br/Notebook-Dell-Inspiron-I15-I1300-M50P-Carbono/dp/B0CWPKYV51?pd_rd_w=PeXLT&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8YDDYZYZGT3TAJVCHHBS&pd_rd_wg=gJsYI&pd_rd_r=1e6ee1b1-ac02-4b80-a852-5178b8262127&pd_rd_i=B0CWPKYV51	https://m.media-amazon.com/images/I/41iXF7dHC7L._SR480,440_.jpg	Amazon	2025-07-07 00:00:00
147	Mouse Gamer Logitech G203 LIGHTSYNC RGB, Efeito de Ondas de Cores, 6 Botões Programáveis e Até 8.000 DPI - Preto	99,00	https://www.amazon.com.br/Logitech-LIGHTSYNC-Efeito-Bot%C3%B5es-Program%C3%A1veis/dp/B087CT8PWY?pd_rd_w=PeXLT&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8YDDYZYZGT3TAJVCHHBS&pd_rd_wg=gJsYI&pd_rd_r=1e6ee1b1-ac02-4b80-a852-5178b8262127&pd_rd_i=B087CT8PWY	https://m.media-amazon.com/images/I/41zEY42v1tL._SR480,440_.jpg	Amazon	2025-07-07 00:00:00
148	Headset Gamer Logitech G335 com Almofadas com Espuma de Memória, Design Leve e Conexão 3,5mm para PC, PlayStation, Xbox, Nintendo Switch e Mobile - Preto	249,00	https://www.amazon.com.br/Headset-Logitech-Almofadas-PlayStation-Nintendo/dp/B08KKBSDTY?pd_rd_w=PeXLT&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8YDDYZYZGT3TAJVCHHBS&pd_rd_wg=gJsYI&pd_rd_r=1e6ee1b1-ac02-4b80-a852-5178b8262127&pd_rd_i=B08KKBSDTY	https://m.media-amazon.com/images/I/41M95jhVAHL._SR480,440_.jpg	Amazon	2025-07-07 00:00:00
149	HUION Mesa digitalizadora Kamvas Pro 16 2.5K QHD com tela QLED Tablet gráfico totalmente laminado com caneta, tablet de arte digital de 15,6 polegadas compatível com Mac, PC, Android e Linux	2.678,00	https://www.amazon.com.br/desenho-gr%C3%A1fico-HUION-lamina%C3%A7%C3%A3o-polegadas/dp/B09FDZG55G?pd_rd_w=PeXLT&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8YDDYZYZGT3TAJVCHHBS&pd_rd_wg=gJsYI&pd_rd_r=1e6ee1b1-ac02-4b80-a852-5178b8262127&pd_rd_i=B09FDZG55G	https://m.media-amazon.com/images/I/41SeEWZvZSL._SR480,440_.jpg	Amazon	2025-07-07 00:00:00
150	Notebook Dell Inspiron I15-I1300-M70P 15.6" Full HD 13ª Gen Intel Core i7 16GB 512GB SSD Win 11 Preto Carbono	4.399,00	https://www.amazon.com.br/Notebook-Dell-Inspiron-I15-I1300-M70P-Carbono/dp/B0CWPJ9V2R?pd_rd_w=PeXLT&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8YDDYZYZGT3TAJVCHHBS&pd_rd_wg=gJsYI&pd_rd_r=1e6ee1b1-ac02-4b80-a852-5178b8262127&pd_rd_i=B0CWPJ9V2R	https://m.media-amazon.com/images/I/41iXF7dHC7L._SR480,440_.jpg	Amazon	2025-07-07 00:00:00
151	Notebook Gamer Acer Nitro V ANV15-51-57WS Intel® Core™ i5-13420H 13ªGeração 512SSD 8GB Nvidia® GeForce® RTX 3050 GDDR6 Linux Gutta 15,6'	4.679,00	https://www.mercadolivre.com.br/notebook-gamer-acer-nitro-v-anv15-51-57ws-intel-core-i5-13420h-13geraco-512ssd-8gb-nvidia-geforce-rtx-3050-gddr6-linux-gutta-156/p/MLB37396835?pdp_filters=deal:MLB779362-1#wid=MLB3722589767&sid=search&searchVariation=MLB37396835&position=2&search_layout=stack&type=product&tracking_id=3da9b6f4-cbac-4cba-bd65-9682d61abb53&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=1&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=259430e0-5b9c-11f0-ba39-5f018c188434&c_element_id=259430e0-5b9c-11f0-ba39-5f018c188434&c_global_position=7&deal_print_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6&c_tracking_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6	https://http2.mlstatic.com/D_Q_NP_757417-MLU76569758316_062024-P.webp	Mercado Livre	2025-07-07 00:00:00
152	Notebook Samsung Galaxy Book4 Intel® U300 (1.20 Ghz, até 4.4GHz, 8 MB L3 Cache), Windows 11 Home, 8GB, 256GB SSD, UHD Graphics, 15.6'' Full HD LED, 1.55kg	4.679,90	https://www.mercadolivre.com.br/notebook-samsung-galaxy-book4-intel-u300-120-ghz-ate-44ghz-8-mb-l3-cache-windows-11-home-8gb-256gb-ssd-uhd-graphics-156-full-hd-led-155kg/p/MLB40347107?pdp_filters=deal:MLB779362-1#wid=MLB5194930972&sid=search&searchVariation=MLB40347107&position=3&search_layout=stack&type=product&tracking_id=3da9b6f4-cbac-4cba-bd65-9682d61abb53&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=2&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=259430e1-5b9c-11f0-ba39-5f018c188434&c_element_id=259430e1-5b9c-11f0-ba39-5f018c188434&c_global_position=7&deal_print_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6&c_tracking_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6	https://http2.mlstatic.com/D_Q_NP_876091-MLU78776215826_092024-P.webp	Mercado Livre	2025-07-07 00:00:00
153	Notebook Samsung Galaxy Book4 Intel® Core™ i5-1335U (1.3 Ghz, até 4.6GHz, 12 MB L3 Cache), Windows 11 Home, 8GB, 512GB SSD, Iris Xe, 15.6'' Full HD LED, 1.55kg	2.898,00	https://www.mercadolivre.com.br/notebook-samsung-galaxy-book4-intel-core-i5-1335u-13-ghz-ate-46ghz-12-mb-l3-cache-windows-11-home-8gb-512gb-ssd-iris-xe-156-full-hd-led-155kg/p/MLB37044038?pdp_filters=deal:MLB779362-1#wid=MLB4736120696&sid=search&searchVariation=MLB37044038&position=4&search_layout=stack&type=product&tracking_id=3da9b6f4-cbac-4cba-bd65-9682d61abb53&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=3&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=259430e2-5b9c-11f0-ba39-5f018c188434&c_element_id=259430e2-5b9c-11f0-ba39-5f018c188434&c_global_position=7&deal_print_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6&c_tracking_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6	https://http2.mlstatic.com/D_Q_NP_618141-MLU76378990682_052024-P.webp	Mercado Livre	2025-07-07 00:00:00
154	Notebook Gamer Acer Nitro V Intel Core I5 - 13420H, 8GB Ram, 512GB SSD, NVIDIA RTX4050, Windows 11 Home, Tela 15,6" Full HD - ANV15-51-54DL	2.898,00	https://www.mercadolivre.com.br/notebook-gamer-acer-nitro-v-intel-core-i5-13420h-8gb-ram-512gb-ssd-nvidia-rtx4050-windows-11-home-tela-156-full-hd-anv15-51-54dl/p/MLB37728210?pdp_filters=deal:MLB779362-1#wid=MLB4844389174&sid=search&searchVariation=MLB37728210&position=5&search_layout=stack&type=product&tracking_id=3da9b6f4-cbac-4cba-bd65-9682d61abb53&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=4&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=259430e3-5b9c-11f0-ba39-5f018c188434&c_element_id=259430e3-5b9c-11f0-ba39-5f018c188434&c_global_position=7&deal_print_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6&c_tracking_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6	https://http2.mlstatic.com/D_Q_NP_975685-MLU77397723195_072024-P.webp	Mercado Livre	2025-07-07 00:00:00
155	Impressora multifuncional cor Epson EcoTank L4260	3.839,00	https://www.mercadolivre.com.br/impressora-multifuncional-cor-epson-ecotank-l4260/p/MLB18462372?pdp_filters=deal:MLB779362-1#wid=MLB5364050608&sid=search&searchVariation=MLB18462372&position=6&search_layout=stack&type=product&tracking_id=3da9b6f4-cbac-4cba-bd65-9682d61abb53&c_container_id=MLB779362-1&c_id=%2Fsplinter%2Fcarouseldynamicitem&c_element_order=5&c_campaign=ofertas-para-comprar-agora-%F0%9F%94%A5&c_label=%2Fsplinter%2Fcarouseldynamicitem&c_uid=259430e4-5b9c-11f0-ba39-5f018c188434&c_element_id=259430e4-5b9c-11f0-ba39-5f018c188434&c_global_position=7&deal_print_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6&c_tracking_id=259939f0-5b9c-11f0-ab3c-3df41c30bfa6	https://http2.mlstatic.com/D_Q_NP_810031-MLA84846513529_052025-P.webp	Mercado Livre	2025-07-07 00:00:00
156	iPhone 13 Apple 128GB iOS 5G Wi-Fi Tela 6.1'' Câmera Dupla 12MP - Estelar	4.579,00	https://www.americanas.com.br/iphone-13-apple-128gb-ios-5g-wi-fi-tela-6-1-camera-dupla-12mp-estelar-4864628680/p	https://americanas.vtexassets.com/arquivos/ids/30035456/4864628698_1SZ.jpg?v=638792860509300000	Americanas	2025-07-07 00:00:00
157	IPhone 16 Apple (128GB) Preto, Tela de 6,1, 5G e Câmera de 48MP	6.469,73	https://www.americanas.com.br/iphone-16-apple-128gb-preto-tela-de-6-1-5g-e-camera-de-48mp-7512516013/p	https://americanas.vtexassets.com/arquivos/ids/25720686/7512516017_1_xlarge.jpg?v=638822350670400000	Americanas	2025-07-07 00:00:00
158	IPhone 16 Apple (128GB) Rosa, Tela de 6,1, 5G e Câmera de 48MP	6.545,87	https://www.americanas.com.br/iphone-16-apple-128gb-rosa-tela-de-6-1-5g-e-camera-de-48mp-7512516061/p	https://americanas.vtexassets.com/arquivos/ids/5180207/7512516065_1_xlarge.jpg?v=638822351985930000	Americanas	2025-07-07 00:00:00
159	Apple iPhone 16 Pro Max 512GB Titânio natural	12.749,00	https://www.americanas.com.br/apple-iphone-16-pro-max-512gb-titanio-natural-7508562040/p	https://americanas.vtexassets.com/arquivos/ids/420702/7508562041_1SZ.jpg?v=638750819838830000	Americanas	2025-07-07 00:00:00
160	Apple iPhone 16 Pro Max 256GB Titânio branco	11.369,00	https://www.americanas.com.br/apple-iphone-16-pro-max-256gb-titanio-branco-7508526682/p	https://americanas.vtexassets.com/arquivos/ids/429831/7508526688_1SZ.jpg?v=638750822439800000	Americanas	2025-07-07 00:00:00
161	Smartphone Samsung Galaxy A56 128GB 5G 8GB RAM Rosa 6,7" Câm. Tripla + Selfie 12MP	1.969,00	https://www.magazineluiza.com.br/smartphone-samsung-galaxy-a56-128gb-5g-8gb-ram-rosa-67-cam-tripla-selfie-12mp/p/240097200/te/ga56/	https://a-static.mlcdn.com.br/280x210/smartphone-samsung-galaxy-a56-128gb-5g-8gb-ram-rosa-67-cam-tripla-selfie-12mp/magazineluiza/240097200/d9169f94917a9bb1de62d34fc43bb0ad.jpg	Magazine Luiza	2025-07-07 00:00:00
162	Smartwatch Samsung Galaxy Watch7 44mm Verde 32GB Bluetooth	1.304,10	https://www.magazineluiza.com.br/smartwatch-samsung-galaxy-watch7-44mm-verde-32gb-bluetooth/p/238533400/te/gawa/	https://a-static.mlcdn.com.br/280x210/smartwatch-samsung-galaxy-watch7-44mm-verde-32gb-bluetooth/magazineluiza/238533400/d078f0a48b70e8342e2851a67b66c184.jpg	Magazine Luiza	2025-07-07 00:00:00
163	Smartphone Samsung Galaxy A06 128GB 4GB RAM Azul Escuro 6,7" Câm. Dupla + Selfie 8MP	649,00	https://www.magazineluiza.com.br/smartphone-samsung-galaxy-a06-128gb-4gb-ram-azul-escuro-67-cam-dupla-selfie-8mp/p/238657700/te/ga06/	https://a-static.mlcdn.com.br/280x210/smartphone-samsung-galaxy-a06-128gb-4gb-ram-azul-escuro-67-cam-dupla-selfie-8mp/magazineluiza/238657700/fca7f701abc03293954ba82835473323.jpg	Magazine Luiza	2025-07-07 00:00:00
164	Smartphone Samsung Galaxy A16 128GB Verde Claro 5G 4GB RAM 6,7" FHD+ Câm Tripla até 50MP + Selfie 13MP Bateria 5000mAh	1.259,10	https://www.magazineluiza.com.br/smartphone-samsung-galaxy-a16-128gb-verde-claro-5g-4gb-ram-67-fhd-cam-tripla-ate-50mp-selfie-13mp-bateria-5000mah/p/238898700/te/ga16/	https://a-static.mlcdn.com.br/280x210/smartphone-samsung-galaxy-a16-128gb-verde-claro-5g-4gb-ram-67-fhd-cam-tripla-ate-50mp-selfie-13mp-bateria-5000mah/magazineluiza/238898700/a2038a19d7577c4cedb245ddb88217ca.jpg	Magazine Luiza	2025-07-07 00:00:00
165	Smartphone Motorola Moto G75 256GB Cinza 5G 8GB RAM 6,8" Câm. Dupla Selfie 16MP	1.664,10	https://www.magazineluiza.com.br/smartphone-motorola-moto-g75-256gb-cinza-5g-8gb-ram-68-cam-dupla-selfie-16mp/p/238836300/te/srmt/	https://a-static.mlcdn.com.br/280x210/smartphone-motorola-moto-g75-256gb-cinza-5g-8gb-ram-68-cam-dupla-selfie-16mp/magazineluiza/238836300/c940945838094cb576480b1e8f1cc305.jpg	Magazine Luiza	2025-07-07 00:00:00
166	Apple iPhone 16 128GB - Ultramarino	5.100,00	https://www.casasbahia.com.br/apple-iphone-16-128gb-ultramarino/p/55067624	https://imgs.casasbahia.com.br/55067624/1g.jpg?imwidth=180	Casas Bahia	2025-07-07 00:00:00
167	Apple iPhone 14 128GB - Meia-noite	3.779,10	https://www.casasbahia.com.br/apple-iphone-14-128gb-meia-noite/p/55058313	https://imgs.casasbahia.com.br/55058313/1g.jpg?imwidth=180	Casas Bahia	2025-07-07 00:00:00
168	Smartphone Motorola Moto g15 Grafite 256GB 4GB RAM+8GB Ram Boost e Camera 50MP com AI e Night Vision, 5.200mAh Tela FHD+ 6.7" Superbrilho e NFC	850,00	https://www.casasbahia.com.br/smartphone-motorola-moto-g15-grafite-256gb-4gb-ram-8gb-ram-boost-e-camera-50mp-com-ai-e-night-vision-5-200mah-tela-fhd-6-7-superbrilho-e-nfc/p/55068314	https://imgs.casasbahia.com.br/55068314/1g.jpg?imwidth=180	Casas Bahia	2025-07-07 00:00:00
169	Smartphone Samsung Galaxy A16 Cinza, 128GB, 4GB RAM, Câmera de até 50MP, Tela 6.7", NFC, IP54, Bateria 5000 mAh e Processador Helio G99	989,00	https://www.casasbahia.com.br/smartphone-samsung-galaxy-a16-cinza-128gb-4gb-ram-camera-de-ate-50mp-tela-6-7-nfc-ip54-bateria-5000-mah-e-processador-helio-g99/p/55068267	https://imgs.casasbahia.com.br/55068267/1g.jpg?imwidth=180	Casas Bahia	2025-07-07 00:00:00
170	Smartphone Samsung Galaxy A15 4G Azul Escuro 128GB, 4GB RAM, Processador Octa-Core, Câmera Tripla Traseira, Selfie de 13MP, Tela Infinita de 6.5" 90Hz	899,10	https://www.casasbahia.com.br/smartphone-samsung-galaxy-a15-4g-azul-escuro-128gb-4gb-ram-processador-octa-core-camera-tripla-traseira-selfie-de-13mp-tela-infinita-de-6-5-90hz/p/55065634	https://imgs.casasbahia.com.br/55065634/1g.jpg?imwidth=180	Casas Bahia	2025-07-07 00:00:00
\.


--
-- Data for Name: produtos_categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos_categorias (produto_id, categoria_id) FROM stdin;
146	3
147	7
148	7
149	7
150	3
151	3
152	2
152	3
152	6
153	2
153	3
153	6
154	3
155	7
156	1
156	6
157	1
157	6
158	1
158	6
159	1
159	6
160	1
160	6
161	2
161	6
162	2
162	4
162	6
163	2
163	6
164	2
164	6
165	6
166	1
166	6
167	1
167	6
168	6
169	2
169	6
170	2
170	6
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

SELECT pg_catalog.setval('public.historico_precos_id_seq', 289, true);


--
-- Name: lojas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lojas_id_seq', 5, true);


--
-- Name: produtos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_id_seq', 170, true);


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

