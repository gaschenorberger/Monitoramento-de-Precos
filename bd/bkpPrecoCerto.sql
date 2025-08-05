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
-- Name: tbl_categorias_pdtos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_categorias_pdtos (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.tbl_categorias_pdtos OWNER TO postgres;

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

ALTER SEQUENCE public.categorias_id_seq OWNED BY public.tbl_categorias_pdtos.id;


--
-- Name: tbl_historico_precos_pdtos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_historico_precos_pdtos (
    id integer NOT NULL,
    produto_id integer NOT NULL,
    preco text NOT NULL,
    coletado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_historico_precos_pdtos OWNER TO postgres;

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

ALTER SEQUENCE public.historico_precos_id_seq OWNED BY public.tbl_historico_precos_pdtos.id;


--
-- Name: tbl_lojas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_lojas (
    id integer NOT NULL,
    nome character varying(100) NOT NULL
);


ALTER TABLE public.tbl_lojas OWNER TO postgres;

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

ALTER SEQUENCE public.lojas_id_seq OWNED BY public.tbl_lojas.id;


--
-- Name: tbl_produtos_tela_ini; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_produtos_tela_ini (
    id integer NOT NULL,
    nome_produto character varying(255) NOT NULL,
    preco text NOT NULL,
    url text NOT NULL,
    imagem_url text,
    site_origem character varying(100) NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_produtos_tela_ini OWNER TO postgres;

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

ALTER SEQUENCE public.produtos_id_seq OWNED BY public.tbl_produtos_tela_ini.id;


--
-- Name: tbl_pdtos_monitorados_usr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_pdtos_monitorados_usr (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    produto_id integer NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_pdtos_monitorados_usr OWNER TO postgres;

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

ALTER SEQUENCE public.produtos_monitorados_id_seq OWNED BY public.tbl_pdtos_monitorados_usr.id;


--
-- Name: tbl_produtos_categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_produtos_categorias (
    produto_id integer NOT NULL,
    categoria_id integer NOT NULL
);


ALTER TABLE public.tbl_produtos_categorias OWNER TO postgres;

--
-- Name: tbl_usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_usuarios (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(150) NOT NULL,
    senha_hash character varying(200) NOT NULL,
    criado_em timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tbl_usuarios OWNER TO postgres;

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

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.tbl_usuarios.id;


--
-- Name: vw_produtos_tl_inicial; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_produtos_tl_inicial AS
 SELECT p.id AS produto_id,
    p.nome_produto,
    p.preco,
    p.url,
    p.imagem_url,
    p.site_origem,
    p.criado_em,
    c.id AS categoria_id,
    c.nome AS nome_categoria
   FROM ((public.tbl_produtos_tela_ini p
     JOIN public.tbl_produtos_categorias pc ON ((p.id = pc.produto_id)))
     JOIN public.tbl_categorias_pdtos c ON ((pc.categoria_id = c.id)));


ALTER VIEW public.vw_produtos_tl_inicial OWNER TO postgres;

--
-- Name: tbl_categorias_pdtos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_categorias_pdtos ALTER COLUMN id SET DEFAULT nextval('public.categorias_id_seq'::regclass);


--
-- Name: tbl_historico_precos_pdtos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_historico_precos_pdtos ALTER COLUMN id SET DEFAULT nextval('public.historico_precos_id_seq'::regclass);


--
-- Name: tbl_lojas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_lojas ALTER COLUMN id SET DEFAULT nextval('public.lojas_id_seq'::regclass);


--
-- Name: tbl_pdtos_monitorados_usr id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_pdtos_monitorados_usr ALTER COLUMN id SET DEFAULT nextval('public.produtos_monitorados_id_seq'::regclass);


--
-- Name: tbl_produtos_tela_ini id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_produtos_tela_ini ALTER COLUMN id SET DEFAULT nextval('public.produtos_id_seq'::regclass);


--
-- Name: tbl_usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: tbl_categorias_pdtos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_categorias_pdtos (id, nome) FROM stdin;
1	iPhone
2	Samsung
3	Notebook
4	Smartwatch
5	Headphone
6	Smartphone
7	Outros
\.


--
-- Data for Name: tbl_historico_precos_pdtos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_historico_precos_pdtos (id, produto_id, preco, coletado_em) FROM stdin;
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
290	171	1.399,00	2025-07-18 23:50:55.480181
291	171	1.399,00	2025-07-18 23:51:30.003865
292	172	217,93	2025-07-18 23:51:30.155865
293	173	159,99	2025-07-18 23:51:30.404531
294	174	386,91	2025-07-18 23:51:30.635259
295	175	159,99	2025-07-18 23:51:30.764758
296	171	1.399,00	2025-07-18 23:54:06.683093
297	172	217,93	2025-07-18 23:54:06.822519
298	173	159,99	2025-07-18 23:54:07.048874
299	174	386,91	2025-07-18 23:54:07.187471
300	175	159,99	2025-07-18 23:54:07.302641
301	171	1.399,00	2025-07-18 23:57:00.357036
302	172	217,93	2025-07-18 23:57:00.582486
303	173	159,99	2025-07-18 23:57:00.709949
304	174	386,91	2025-07-18 23:57:00.966372
305	175	159,99	2025-07-18 23:57:01.09084
306	171	1.399,00	2025-07-19 00:00:36.82301
307	172	217,93	2025-07-19 00:00:37.059585
308	173	159,99	2025-07-19 00:00:37.212754
309	175	159,99	2025-07-19 00:00:37.354068
310	176	54,99	2025-07-19 00:00:37.480376
311	171	1.399,00	2025-07-19 00:01:31.505943
312	172	217,93	2025-07-19 00:01:31.729052
313	173	159,99	2025-07-19 00:01:31.966022
314	175	159,99	2025-07-19 00:01:32.118931
315	176	54,99	2025-07-19 00:01:32.230641
316	171	1.399,00	2025-07-19 00:33:41.747144
317	172	217,93	2025-07-19 00:33:41.900734
318	177	160,69	2025-07-19 00:33:42.132693
319	178	13,03	2025-07-19 00:33:42.253524
320	179	43,26	2025-07-19 00:33:42.381859
321	171	1.399,00	2025-07-19 00:36:55.496757
322	172	217,93	2025-07-19 00:36:55.728519
323	177	160,69	2025-07-19 00:36:56.00831
324	180	97,61	2025-07-19 00:36:56.14596
325	178	13,03	2025-07-19 00:36:56.261054
326	171	1.399,00	2025-07-19 00:37:36.621569
327	172	217,93	2025-07-19 00:37:36.760253
328	177	160,69	2025-07-19 00:37:36.89605
329	180	97,61	2025-07-19 00:37:37.172359
330	178	13,03	2025-07-19 00:37:37.42079
331	181	2.033,91	2025-07-24 11:22:48.914421
332	182	2.339,10	2025-07-24 11:22:49.083253
333	183	161,41	2025-07-24 11:22:49.196516
334	184	28,40	2025-07-24 11:22:49.308763
335	185	512,99	2025-07-24 11:22:49.427423
336	181	2.033,91	2025-07-24 11:23:53.905108
337	182	2.339,10	2025-07-24 11:23:54.037741
338	183	161,41	2025-07-24 11:23:54.156703
339	184	28,40	2025-07-24 11:23:54.387219
340	185	512,99	2025-07-24 11:23:54.497608
341	181	2.033,91	2025-07-29 22:32:09.460691
342	198	269,10	2025-07-29 22:32:09.689002
343	199	199,00	2025-07-29 22:32:09.926706
344	200	84,15	2025-07-29 22:32:10.047347
345	184	28,40	2025-07-29 22:32:10.167743
346	199	199,00	2025-07-29 22:38:53.081282
347	181	2.033,91	2025-07-29 22:38:53.208288
348	201	863,59	2025-07-29 22:38:53.326687
349	198	269,10	2025-07-29 22:38:53.483308
350	202	2.938,07	2025-07-29 22:38:53.709786
351	199	199,00	2025-07-29 22:40:54.044007
352	181	2.033,91	2025-07-29 22:40:54.17385
353	201	863,59	2025-07-29 22:40:54.401212
354	198	269,10	2025-07-29 22:40:54.527326
355	202	2.938,07	2025-07-29 22:40:54.651473
356	203	2.449,90	2025-07-31 23:03:07.883094
357	199	199,00	2025-07-31 23:03:08.156614
358	198	269,10	2025-07-31 23:03:08.277397
359	204	268,59	2025-07-31 23:03:08.392929
360	205	58,59	2025-07-31 23:03:08.506662
361	203	2.449,90	2025-07-31 23:06:07.944583
362	199	199,00	2025-07-31 23:06:08.176495
363	198	269,10	2025-07-31 23:06:08.319233
364	204	268,59	2025-07-31 23:06:08.461805
365	205	58,59	2025-07-31 23:06:08.60098
366	203	2.449,90	2025-07-31 23:07:01.583097
367	199	199,00	2025-07-31 23:07:01.733015
368	198	269,10	2025-07-31 23:07:01.95935
369	204	268,59	2025-07-31 23:07:02.073945
370	205	58,59	2025-07-31 23:07:02.183165
371	198	269,10	2025-07-31 23:11:03.338212
372	199	199,00	2025-07-31 23:11:03.481641
373	205	58,59	2025-07-31 23:11:03.663216
374	206	1.699,90	2025-07-31 23:11:03.876671
375	207	249,00	2025-07-31 23:11:04.089925
376	198	269,10	2025-07-31 23:12:11.797751
377	199	199,00	2025-07-31 23:12:12.034372
378	205	58,59	2025-07-31 23:12:12.146179
379	206	1.699,90	2025-07-31 23:12:12.256161
380	207	249,00	2025-07-31 23:12:12.371578
381	198	269,10	2025-07-31 23:15:36.77037
382	199	199,00	2025-07-31 23:15:36.906681
383	205	58,59	2025-07-31 23:15:37.020016
384	206	1.699,90	2025-07-31 23:15:37.134703
385	207	249,00	2025-07-31 23:15:37.350717
386	198	269,10	2025-07-31 23:16:16.266736
387	199	199,00	2025-07-31 23:16:16.403269
388	205	58,59	2025-07-31 23:16:16.613241
389	206	1.699,90	2025-07-31 23:16:16.750939
390	207	249,00	2025-07-31 23:16:16.978013
391	198	269,10	2025-07-31 23:17:08.088401
392	199	199,00	2025-07-31 23:17:08.304502
393	205	58,59	2025-07-31 23:17:08.444164
394	206	1.699,90	2025-07-31 23:17:08.663679
395	207	249,00	2025-07-31 23:17:08.876048
396	198	269,10	2025-07-31 23:18:54.496324
397	199	199,00	2025-07-31 23:18:54.726454
398	205	58,59	2025-07-31 23:18:54.86755
399	206	1.699,90	2025-07-31 23:18:55.095149
400	207	249,00	2025-07-31 23:18:55.221759
401	208	1.139,90	2025-07-31 23:22:52.75226
402	201	863,59	2025-07-31 23:22:52.865953
403	198	269,10	2025-07-31 23:22:53.003582
404	209	713,99	2025-07-31 23:22:53.114762
405	210	2.959,00	2025-07-31 23:22:53.325371
406	198	269,10	2025-07-31 23:24:07.558826
407	199	199,00	2025-07-31 23:24:07.671556
408	205	58,59	2025-07-31 23:24:07.787426
409	206	1.699,90	2025-07-31 23:24:07.926258
410	207	249,00	2025-07-31 23:24:08.358698
411	198	269,10	2025-07-31 23:24:50.367801
412	199	199,00	2025-07-31 23:24:50.596222
413	205	58,59	2025-07-31 23:24:50.712495
414	206	1.699,90	2025-07-31 23:24:50.933237
415	207	249,00	2025-07-31 23:24:51.041993
416	198	269,10	2025-07-31 23:33:07.758205
417	199	199,00	2025-07-31 23:33:07.906371
418	205	58,59	2025-07-31 23:33:08.116988
419	206	1.699,90	2025-07-31 23:33:08.234638
420	207	249,00	2025-07-31 23:33:08.457297
421	198	269,10	2025-07-31 23:35:12.930983
422	199	199,00	2025-07-31 23:35:13.059187
423	205	58,59	2025-07-31 23:35:13.179131
424	206	1.699,90	2025-07-31 23:35:13.41553
425	207	249,00	2025-07-31 23:35:13.644012
426	198	269,10	2025-07-31 23:35:48.63034
427	199	199,00	2025-07-31 23:35:48.919857
428	205	58,59	2025-07-31 23:35:49.132593
429	206	1.699,90	2025-07-31 23:35:49.29342
430	207	249,00	2025-07-31 23:35:49.517861
431	198	269,10	2025-07-31 23:38:15.083933
432	199	199,00	2025-07-31 23:38:15.196464
433	211	78,99	2025-07-31 23:38:15.313209
434	205	58,59	2025-07-31 23:38:15.424844
435	212	249,90	2025-07-31 23:38:15.634126
436	198	269,10	2025-07-31 23:41:45.714486
437	199	199,00	2025-07-31 23:41:45.939789
438	211	78,99	2025-07-31 23:41:46.054385
439	205	58,59	2025-07-31 23:41:46.170518
440	212	249,90	2025-07-31 23:41:46.28331
441	213	2.609,10	2025-08-04 21:56:54.894296
442	203	2.399,90	2025-08-04 21:56:55.2132
443	198	269,10	2025-08-04 21:56:55.353948
444	214	2.599,00	2025-08-04 21:56:55.491357
445	215	260,99	2025-08-04 21:56:55.624699
\.


--
-- Data for Name: tbl_lojas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_lojas (id, nome) FROM stdin;
1	Amazon
2	Mercado Livre
3	Americanas
4	Magazine Luiza
5	Casas Bahia
\.


--
-- Data for Name: tbl_pdtos_monitorados_usr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_pdtos_monitorados_usr (id, usuario_id, produto_id, criado_em) FROM stdin;
\.


--
-- Data for Name: tbl_produtos_categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_produtos_categorias (produto_id, categoria_id) FROM stdin;
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
171	2
171	6
172	7
173	3
174	7
175	3
176	7
177	7
179	7
180	6
180	1
181	7
182	7
183	7
184	7
185	3
198	7
199	5
200	7
201	5
202	3
203	7
204	5
205	1
205	6
206	7
207	7
208	7
209	7
210	3
211	7
212	7
213	3
214	3
215	5
\.


--
-- Data for Name: tbl_produtos_tela_ini; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_produtos_tela_ini (id, nome_produto, preco, url, imagem_url, site_origem, criado_em) FROM stdin;
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
174	Mochila Executiva Swissport com Entrada USB e Bolso Antifurto	386,91	https://www.amazon.com.br/Mochila-Executiva-Swissport-Entrada-Antifurto/dp/B0F95SNLVG?pd_rd_w=mWkA1&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=TCS5NQXRA45CYRKCCBF3&pd_rd_wg=No3AE&pd_rd_r=95557140-b439-4e8c-afc2-29ca89027752&pd_rd_i=B0F95SNLVG	https://m.media-amazon.com/images/I/317SqKY5B8L._SR480,440_.jpg	Amazon	2025-07-18 00:00:00
173	Gshield Capa Ergonômica para Notebook de até 15.6" polegadas com Mousepad Embutido e Elevação de Altura, Smart Dinamic (Preta)	159,99	https://www.amazon.com.br/Gshield-Ergon%C3%B4mica-Notebook-Polegadas-Mousepad/dp/B09LXSBCYQ?pd_rd_w=m3Gsc&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=2T6CZMXYW2NVAREJTG3P&pd_rd_wg=E71YM&pd_rd_r=2be55138-38b3-428f-b11e-1673f55ba9b8&pd_rd_i=B09LXSBCYQ	https://m.media-amazon.com/images/I/41LW0e6V7uL._SR480,440_.jpg	Amazon	2025-07-18 00:00:00
172	WB Capa com Teclado e trackpad para iPad 10ª e 11ª Geração 10.9" Polegadas com Auto Hibernação (Preto)	217,93	https://www.amazon.com.br/WB-Teclado-trackpad-Polegadas-Hiberna%C3%A7%C3%A3o/dp/B0CC6G7KPC?pd_rd_w=fr5fP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=KXBZQN5QFQ08TVWW6KG7&pd_rd_wg=p9W1O&pd_rd_r=971c3cdd-6497-4671-823f-c4715730654c&pd_rd_i=B0CC6G7KPC	https://m.media-amazon.com/images/I/416VQFm1nRL._SR480,440_.jpg	Amazon	2025-07-18 00:00:00
179	Repetidor Amplificador de Sinal Wireless Aumente o alcance do seu Wi-Fi em até 10m Homologado pela ANATEL. Ideal para 110v/220v	43,26	https://www.amazon.com.br/Repetidor-Amplificador-Wireless-Aumente-Homologado/dp/B0DCX5KVQC?pd_rd_w=vwCiN&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=YJ8RP1A75EA0X4346K1A&pd_rd_wg=lRzYa&pd_rd_r=5e331996-08c3-49b1-ba29-a8c22ed4369c&pd_rd_i=B0DCX5KVQC	https://m.media-amazon.com/images/I/31VG2V2O9XL._SR480,440_.jpg	Amazon	2025-07-19 00:00:00
171	SAMSUNG Monitor Gamer Odyssey 27", FHD, 240 Hz, 1ms, com ajuste de altura, HDMI, DP, Gsync, Freesync, Preto, Série G40	1.399,00	https://www.amazon.com.br/SAMSUNG-Monitor-Odyssey-ajuste-Freesync/dp/B0B8F7C61M?pd_rd_w=fr5fP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=KXBZQN5QFQ08TVWW6KG7&pd_rd_wg=p9W1O&pd_rd_r=971c3cdd-6497-4671-823f-c4715730654c&pd_rd_i=B0B8F7C61M	https://m.media-amazon.com/images/I/41lyfNHWdgL._SR480,440_.jpg	Amazon	2025-07-18 00:00:00
175	Gshield Adaptador Hub Multifuncional 6 em 1 USB-C, Hub USB 3.0 com Saída HDMI 4K Leitor de Cartão SD, Micro SD e TF para Notebook e PC, Prata	159,99	https://www.amazon.com.br/Gshield-Adaptador-Multifuncional-Leitor-Notebook/dp/B0DG62NQ33?pd_rd_w=m3Gsc&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=2T6CZMXYW2NVAREJTG3P&pd_rd_wg=E71YM&pd_rd_r=2be55138-38b3-428f-b11e-1673f55ba9b8&pd_rd_i=B0DG62NQ33	https://m.media-amazon.com/images/I/31Fl3cqYcBL._SR480,440_.jpg	Amazon	2025-07-18 00:00:00
176	Cabo Turbo Militar Tipo C para Carregamento rápido 3A - Type C/USB A - Qualcomm 3.0, Nylon trançado, 1,5 Metros - Gshield	54,99	https://www.amazon.com.br/Cabo-Turbo-Militar-Original-Gshield/dp/B07DCYK5CK?pd_rd_w=m3Gsc&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=2T6CZMXYW2NVAREJTG3P&pd_rd_wg=E71YM&pd_rd_r=2be55138-38b3-428f-b11e-1673f55ba9b8&pd_rd_i=B07DCYK5CK	https://m.media-amazon.com/images/I/41GNBB-CHlL._SR480,440_.jpg	Amazon	2025-07-19 00:00:00
177	WB Teclado com Trackpad para Tablet e iPad (Preto)	160,69	https://www.amazon.com.br/WB-Teclado-Trackpad-Tablet-Preto/dp/B0CC6HC1KP?pd_rd_w=fr5fP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=KXBZQN5QFQ08TVWW6KG7&pd_rd_wg=p9W1O&pd_rd_r=971c3cdd-6497-4671-823f-c4715730654c&pd_rd_i=B0CC6HC1KP	https://m.media-amazon.com/images/I/41rLbvNwbyL._SR480,440_.jpg	Amazon	2025-07-19 00:00:00
180	Gshield Cabo Lightning para Tipo C (iPhone/iPad) Carregamento Rápido 64,5W 3A, Revestido em Nylon Ballistico, 1,5M, Survivor Branco	97,61	https://www.amazon.com.br/Cabo-Survivor-para-Lightning-Tipo/dp/B0CFFZ3KNM?pd_rd_w=fr5fP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=KXBZQN5QFQ08TVWW6KG7&pd_rd_wg=p9W1O&pd_rd_r=971c3cdd-6497-4671-823f-c4715730654c&pd_rd_i=B0CFFZ3KNM	https://m.media-amazon.com/images/I/31fPHw-EZWL._SR480,440_.jpg	Amazon	2025-07-19 00:00:00
183	WB Teclado com Trackpad para Tablet e iPad (Branco)	161,41	https://www.amazon.com.br/WB-Teclado-Trackpad-Tablet-Branco/dp/B0CC6GBXQW?pd_rd_w=k5fxG&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=ZQG819AHGSY9Z7WA7D2Z&pd_rd_wg=UGWBm&pd_rd_r=d8e5d7b8-187e-4372-8d1d-3ce058bafc83&pd_rd_i=B0CC6GBXQW	https://m.media-amazon.com/images/I/51QL-9NkADL._SR480,440_.jpg	Amazon	2025-07-24 00:00:00
184	Mouse Sem Fio Recarregável Ergonômico, RGB, Silencioso, Bluetooth 5.0 + USB, DPI Ajustável – Cinza Premium	28,40	https://www.amazon.com.br/Recarreg%C3%A1vel-Ergon%C3%B4mico-Silencioso-Bluetooth-Ajust%C3%A1vel/dp/B0F5CVYHP6?pd_rd_w=XIZ2o&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8J48CK6BT5VZDTBHSR15&pd_rd_wg=vWNh0&pd_rd_r=e7c77ff9-dca0-4c93-8c8f-be4bb3358e7c&pd_rd_i=B0F5CVYHP6	https://m.media-amazon.com/images/I/31C0UMHBj6L._SR480,440_.jpg	Amazon	2025-07-24 00:00:00
182	PLACA DE VIDEO NV RTX5060 8GB BLACK GF 1-CLICK OC 128BITS GDDR7 GALAX 56NSN8MDDCOC	2.339,10	https://www.amazon.com.br/PLACA-RTX5060-1-CLICK-128BITS-56NSN8MDDCOC/dp/B0FCMLXTFC?pd_rd_w=k5fxG&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=ZQG819AHGSY9Z7WA7D2Z&pd_rd_wg=UGWBm&pd_rd_r=d8e5d7b8-187e-4372-8d1d-3ce058bafc83&pd_rd_i=B0FCMLXTFC	https://m.media-amazon.com/images/I/41eRm-qONML._SR480,440_.jpg	Amazon	2025-07-24 00:00:00
185	Armazém Brasil, Monitor Portatil 15,6'', FHD 1080P Monitor Portátil Conectado Com USB C Dupla/HDMI, IPS Extensor De Tela para Notebook com VESA e Funda Inteligente magnético, Plug and Play	512,99	https://www.amazon.com.br/Portatil-Port%C3%A1til-Conectado-Inteligente-magn%C3%A9tico/dp/B0DHGCX3CX?pd_rd_w=k5fxG&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=ZQG819AHGSY9Z7WA7D2Z&pd_rd_wg=UGWBm&pd_rd_r=d8e5d7b8-187e-4372-8d1d-3ce058bafc83&pd_rd_i=B0DHGCX3CX	https://m.media-amazon.com/images/I/61HF-IEm-SL._SR480,440_.jpg	Amazon	2025-07-24 00:00:00
181	Placa de Vídeo Zotac Gaming - GeForce RTX 3060, Twin Edge, LHR, 12GB GDDR6	2.033,91	https://www.amazon.com.br/Placa-V%C3%ADdeo-Zotac-Gaming-GeForce/dp/B08WRF18SC?pd_rd_w=yyxFJ&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=3YBKG5VF3PCCR9VSWY5R&pd_rd_wg=edkmg&pd_rd_r=ac8e910d-e4ec-40ad-8042-dc93589f934d&pd_rd_i=B08WRF18SC	https://m.media-amazon.com/images/I/518K4YBQodL._SR480,440_.jpg	Amazon	2025-07-24 00:00:00
200	JETech Capa para iPad (A16) 11ª/10ª Geração (2025/2022) com Porta Pencil, Case Fina para Tablet com Parte Traseira de TPU Macio, Ativação/Repouso Automático (Marinha)	84,15	https://www.amazon.com.br/JETech-polegadas-traseira-despertar-automaticamente/dp/B0C7ZLWVYZ?pd_rd_w=XIZ2o&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8J48CK6BT5VZDTBHSR15&pd_rd_wg=vWNh0&pd_rd_r=e7c77ff9-dca0-4c93-8c8f-be4bb3358e7c&pd_rd_i=B0C7ZLWVYZ	https://m.media-amazon.com/images/I/41EseSGeLTL._SR480,440_.jpg	Amazon	2025-07-29 00:00:00
198	GameSir G7 Controle com fio para Xbox,Windows gamepad para PC com 2 placas frontais trocáveis, controlador de jogos com fio com zona de gatilhos ajustáveis e nível de vibração funciona	269,10	https://www.amazon.com.br/GameSir-G7-troc%C3%A1veis-controlador-ajust%C3%A1veis/dp/B0BLNLGXWZ?pd_rd_w=HIHfk&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=BT7KS0XJVKYRXQBS89ES&pd_rd_wg=4yNM2&pd_rd_r=d2dbdfca-5304-48b3-b40f-e7ab5fdb44a3&pd_rd_i=B0BLNLGXWZ	https://m.media-amazon.com/images/I/41sZ6NJqboL._SR480,440_.jpg	Amazon	2025-07-29 00:00:00
207	GameSir Nova Wireless Switch Pro Controller para Switch/Lite/OLED, controladores de Switch com JoySticks de efeito Hall, LED RGB, recarregável de 1200mAh, turbo, programável, controle de movimento	249,00	https://www.amazon.com.br/GameSir-Controller-controladores-recarreg%C3%A1vel-program%C3%A1vel/dp/B0CMCPRT3L?pd_rd_w=3MTOX&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=NJB7KCH28XJD5QRWJV97&pd_rd_wg=DJqsD&pd_rd_r=f82778b2-f54d-4ee6-853e-e98a71a2c4ac&pd_rd_i=B0CMCPRT3L	https://m.media-amazon.com/images/I/41Ho-qnWOwL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
202	Notebook HP 256R G9 Intel Core i5 13º Geração. Memoria RAM 8GB. SSD 256GB. Tela de 15,6" LCD. Windows 11 - Home SL - Cinza Escuro. Bivolt. (BQ9L1AT#AK4)	2.938,07	https://www.amazon.com.br/Notebook-HP-Gera%C3%A7%C3%A3o-Memoria-Windows/dp/B0F6CLQHQR?pd_rd_w=yyxFJ&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=3YBKG5VF3PCCR9VSWY5R&pd_rd_wg=edkmg&pd_rd_r=ac8e910d-e4ec-40ad-8042-dc93589f934d&pd_rd_i=B0F6CLQHQR	https://m.media-amazon.com/images/I/41x8yFOtr1L._SR480,440_.jpg	Amazon	2025-07-29 00:00:00
208	Monitor Gamer AOC DESTINY 25" 240Hz 0,5ms FreeSync Premium 25G3ZM	1.139,90	https://www.amazon.com.br/Monitor-AOC-DESTINY-FreeSync-25G3ZM/dp/B0CJ9NVNW6?pd_rd_w=DltZP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=282RXNCTH5AFRTCYMBHD&pd_rd_wg=zIHwx&pd_rd_r=b5aec9c0-6fdb-4120-ae0b-a226dda944ce&pd_rd_i=B0CJ9NVNW6	https://m.media-amazon.com/images/I/41jSySqb4HL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
201	ARZOPA Monitor portátil de 17,3”, monitor para jogos IPS 1080P FHD 103% sRGB Monitor para laptop com suporte embutido Tela externa HDMI USB C para PC Mac Telefone Xbox Switch PS5	863,59	https://www.amazon.com.br/ARZOPA-Monitor-port%C3%A1til-embutido-Telefone/dp/B0CH9Y9SV3?pd_rd_w=DltZP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=282RXNCTH5AFRTCYMBHD&pd_rd_wg=zIHwx&pd_rd_r=b5aec9c0-6fdb-4120-ae0b-a226dda944ce&pd_rd_i=B0CH9Y9SV3	https://m.media-amazon.com/images/I/41lpldc+1eL._SR480,440_.jpg	Amazon	2025-07-29 00:00:00
209	Monitor Portátil ARZOPA 15,6'' FHD 1080P - Monitor Ultra Fino para Laptop com Suporte - Display IPS para PC, MAC, Celular, Xbox, PS5 - Conectividade USB C e HDMI -A1	713,99	https://www.amazon.com.br/Monitor-Port%C3%A1til-ARZOPA-1080P-Conectividade/dp/B0CH9XW8RK?pd_rd_w=DltZP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=282RXNCTH5AFRTCYMBHD&pd_rd_wg=zIHwx&pd_rd_r=b5aec9c0-6fdb-4120-ae0b-a226dda944ce&pd_rd_i=B0CH9XW8RK	https://m.media-amazon.com/images/I/51qgAD7WZSL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
204	FIFINE Gaming PC Microfone USB, Microfone Condensador para Podcast com Braço,Filtro Pop,Botão Mudo para Streaming,Twitch,Chat Online,Mic RGB para Computador para PS4/5 y Jogadores e Youtuber-A6T	268,59	https://www.amazon.com.br/FIFINE-condensador-computador-Youtuber-AmpliGame-A6T/dp/B09Q2ZZGH2?pd_rd_w=JQDtC&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=8TZ3FFK9Z8B8Y5C9K995&pd_rd_wg=Qh1Fi&pd_rd_r=f1597133-4e0a-4715-998b-cd15100df3ab&pd_rd_i=B09Q2ZZGH2	https://m.media-amazon.com/images/I/41B+stBkkiL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
210	Notebook Lenovo Ideapad 1i Intel Core i5-1235U 8GB 512GB SSD 15.6" W11	2.959,00	https://www.amazon.com.br/Notebook-Lenovo-Ideapad-i5-1235U-512GB/dp/B0CK3R8JYG?pd_rd_w=DltZP&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=282RXNCTH5AFRTCYMBHD&pd_rd_wg=zIHwx&pd_rd_r=b5aec9c0-6fdb-4120-ae0b-a226dda944ce&pd_rd_i=B0CK3R8JYG	https://m.media-amazon.com/images/I/41QfFX-mc3L._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
211	Combo de Teclado e Mouse USB HP 150 - Plug and Play, com Digitação Silenciosa, Confortável e Precisa, Mouse com DPI de 1600, Layout ABNT2, Preto (240J7AA)	78,99	https://www.amazon.com.br/Teclado-HP-Digita%C3%A7%C3%A3o-Silenciosa-ABNT2-240J7AA/dp/B0D6SRSGX8?pd_rd_w=93ZDS&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=703DTBMHQA6WE8EPCH2E&pd_rd_wg=GSxDT&pd_rd_r=420ccd12-8ba8-4734-9ea4-af91daad63dd&pd_rd_i=B0D6SRSGX8	https://m.media-amazon.com/images/I/31BqMH2+vZL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
212	Fonte Mancer Thunder 500W | Certificação 80 Plus Bronze | PFC Ativo | Bivolt Automático 100-240V AC | Formato ATX | Preto	249,90	https://www.amazon.com.br/Mancer-Thunder-Certifica%C3%A7%C3%A3o-Autom%C3%A1tico-100-240V/dp/B08PKV8PGC?pd_rd_w=93ZDS&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=703DTBMHQA6WE8EPCH2E&pd_rd_wg=GSxDT&pd_rd_r=420ccd12-8ba8-4734-9ea4-af91daad63dd&pd_rd_i=B08PKV8PGC	https://m.media-amazon.com/images/I/41Y7juXbb1L._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
206	Kit Upgrade Gamer AMD Ryzen 5 5600GT | Radeon Vega 7 Graphics | Placa-Mãe B450M | 16GB RAM DDR4	1.699,90	https://www.amazon.com.br/Upgrade-5600GT-Radeon-Graphics-Placa-M%C3%A3e/dp/B09LRD4Y57?pd_rd_w=3MTOX&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=NJB7KCH28XJD5QRWJV97&pd_rd_wg=DJqsD&pd_rd_r=f82778b2-f54d-4ee6-853e-e98a71a2c4ac&pd_rd_i=B09LRD4Y57	https://m.media-amazon.com/images/I/51gSeVTC9HL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
199	Havit Fone de Ouvido Headset Gamer Fuxi-H3 White Black, Com Fio e Sem Fio, Wireless 2,4GHz, Bluetooth, Cabo USB-C, Cabo 3,5mm. Surround, Baixa Latência, Quad-Mode	199,00	https://www.amazon.com.br/Wireless-Bluetooth-Surround-Lat%C3%AAncia-Quad-Mode/dp/B0CK2DP7FX?pd_rd_w=93ZDS&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=703DTBMHQA6WE8EPCH2E&pd_rd_wg=GSxDT&pd_rd_r=420ccd12-8ba8-4734-9ea4-af91daad63dd&pd_rd_i=B0CK2DP7FX	https://m.media-amazon.com/images/I/31vY5pX+YLL._SR480,440_.jpg	Amazon	2025-07-29 00:00:00
205	Cabo Usb-C-Lightning + Fonte Carregador 25W Turbo Compatível iPhone X Xr SE 11 12 13 14 Premium LAGUS IMP.	58,59	https://www.amazon.com.br/Usb-C-Lightning-Carregador-Compat%C3%ADvel-LAGUS-IMP/dp/B0CMMPSF2F?pd_rd_w=93ZDS&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=703DTBMHQA6WE8EPCH2E&pd_rd_wg=GSxDT&pd_rd_r=420ccd12-8ba8-4734-9ea4-af91daad63dd&pd_rd_i=B0CMMPSF2F	https://m.media-amazon.com/images/I/31vYUaVgheL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
213	Notebook ASUS Vivobook 15 AMD Ryzen 7, 8 GB, 512 GB SSD, KeepOS, 15.6'' FHD, Cool Silver - M1502YA-NJ611	2.609,10	https://www.amazon.com.br/Notebook-ASUS-Vivobook-KeepOS-Silver/dp/B0F84PXR9V?pd_rd_w=HIHfk&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=BT7KS0XJVKYRXQBS89ES&pd_rd_wg=4yNM2&pd_rd_r=d2dbdfca-5304-48b3-b40f-e7ab5fdb44a3&pd_rd_i=B0F84PXR9V	https://m.media-amazon.com/images/I/41X94kods3L._SR480,440_.jpg	Amazon	2025-08-04 00:00:00
203	PC Gamer Completo Mancer, AMD Ryzen 5 3400G, 16GB DDR4, SSD 480GB, Fonte 400W 80 Plus	2.399,90	https://www.amazon.com.br/Gamer-Completo-Mancer-RYZEN-2400G/dp/B0B5YNZFF6?pd_rd_w=HIHfk&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=BT7KS0XJVKYRXQBS89ES&pd_rd_wg=4yNM2&pd_rd_r=d2dbdfca-5304-48b3-b40f-e7ab5fdb44a3&pd_rd_i=B0B5YNZFF6	https://m.media-amazon.com/images/I/51hahzRbMGL._SR480,440_.jpg	Amazon	2025-07-31 00:00:00
214	Notebook HP G9 Intel Core i3 13 Geração - 8GB RAM SSD 256GB 15,6" Windows 11 AN1A2LA#AK4 - Home 64 SL-SSD 256-15.6 HD-1/1/0 Warranty	2.599,00	https://www.amazon.com.br/Notebook-HP-Intel-Core-Gera%C3%A7%C3%A3o/dp/B0DP3DM5YK?pd_rd_w=HIHfk&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=BT7KS0XJVKYRXQBS89ES&pd_rd_wg=4yNM2&pd_rd_r=d2dbdfca-5304-48b3-b40f-e7ab5fdb44a3&pd_rd_i=B0DP3DM5YK	https://m.media-amazon.com/images/I/419EMcoZBsL._SR480,440_.jpg	Amazon	2025-08-04 00:00:00
215	EMEET Webcam C960 4K para PC, sensor Sony UHD 4K, foco automático PDAF, microfones com cancelamento de ruído de IA dupla, correção automática de luz, FOV de 73°, webcam Plug & Play com capa de	260,99	https://www.amazon.com.br/EMEET-autom%C3%A1tico-microfones-cancelamento-privacidade/dp/B0CJHZ92P6?pd_rd_w=HIHfk&content-id=amzn1.sym.828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_p=828de3bf-2f14-4174-a8d7-8b6108724168&pf_rd_r=BT7KS0XJVKYRXQBS89ES&pd_rd_wg=4yNM2&pd_rd_r=d2dbdfca-5304-48b3-b40f-e7ab5fdb44a3&pd_rd_i=B0CJHZ92P6	https://m.media-amazon.com/images/I/41OnE1PPPbL._SR480,440_.jpg	Amazon	2025-08-04 00:00:00
\.


--
-- Data for Name: tbl_usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tbl_usuarios (id, nome, email, senha_hash, criado_em) FROM stdin;
\.


--
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 7, true);


--
-- Name: historico_precos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historico_precos_id_seq', 445, true);


--
-- Name: lojas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lojas_id_seq', 5, true);


--
-- Name: produtos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_id_seq', 215, true);


--
-- Name: produtos_monitorados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_monitorados_id_seq', 1, false);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 1, false);


--
-- Name: tbl_categorias_pdtos categorias_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_categorias_pdtos
    ADD CONSTRAINT categorias_nome_key UNIQUE (nome);


--
-- Name: tbl_categorias_pdtos categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_categorias_pdtos
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- Name: tbl_historico_precos_pdtos historico_precos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_historico_precos_pdtos
    ADD CONSTRAINT historico_precos_pkey PRIMARY KEY (id);


--
-- Name: tbl_lojas lojas_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_lojas
    ADD CONSTRAINT lojas_nome_key UNIQUE (nome);


--
-- Name: tbl_lojas lojas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_lojas
    ADD CONSTRAINT lojas_pkey PRIMARY KEY (id);


--
-- Name: tbl_produtos_categorias produtos_categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_produtos_categorias
    ADD CONSTRAINT produtos_categorias_pkey PRIMARY KEY (produto_id, categoria_id);


--
-- Name: tbl_pdtos_monitorados_usr produtos_monitorados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_pdtos_monitorados_usr
    ADD CONSTRAINT produtos_monitorados_pkey PRIMARY KEY (id);


--
-- Name: tbl_produtos_tela_ini produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_produtos_tela_ini
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);


--
-- Name: tbl_usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: tbl_usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: tbl_produtos_categorias produtos_categorias_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_produtos_categorias
    ADD CONSTRAINT produtos_categorias_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.tbl_categorias_pdtos(id) ON DELETE CASCADE;


--
-- Name: tbl_produtos_categorias produtos_categorias_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_produtos_categorias
    ADD CONSTRAINT produtos_categorias_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.tbl_produtos_tela_ini(id) ON DELETE CASCADE;


--
-- Name: tbl_pdtos_monitorados_usr produtos_monitorados_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_pdtos_monitorados_usr
    ADD CONSTRAINT produtos_monitorados_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.tbl_produtos_tela_ini(id) ON DELETE CASCADE;


--
-- Name: tbl_pdtos_monitorados_usr produtos_monitorados_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_pdtos_monitorados_usr
    ADD CONSTRAINT produtos_monitorados_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.tbl_usuarios(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

