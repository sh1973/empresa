toc.dat                                                                                             0000600 0004000 0002000 00000033157 14261170735 0014456 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP                           z            empresa #   12.9 (Ubuntu 12.9-0ubuntu0.20.04.1) #   12.9 (Ubuntu 12.9-0ubuntu0.20.04.1) /    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         ?           1262    57048    empresa    DATABASE     y   CREATE DATABASE empresa WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE empresa;
                postgres    false         ?           0    0    DATABASE empresa    ACL     .   GRANT ALL ON DATABASE empresa TO empresauser;
                   postgres    false    2987         ?           0    0    SCHEMA public    ACL     -   GRANT USAGE ON SCHEMA public TO empresauser;
                   postgres    false    3         ?           1247    57160    roles    TYPE     P   CREATE TYPE public.roles AS ENUM (
    'publico',
    'privado',
    'admin'
);
    DROP TYPE public.roles;
       public          postgres    false         ?            1255    57172    establecer_fecha_creacion()    FUNCTION     ?   CREATE FUNCTION public.establecer_fecha_creacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.creacion := CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.establecer_fecha_creacion();
       public          postgres    false         ?           0    0 $   FUNCTION establecer_fecha_creacion()    ACL     I   GRANT ALL ON FUNCTION public.establecer_fecha_creacion() TO empresauser;
          public          postgres    false    209         ?            1255    57173    establecer_fecha_modificacion()    FUNCTION     ?   CREATE FUNCTION public.establecer_fecha_modificacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.modificacion := CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;
 6   DROP FUNCTION public.establecer_fecha_modificacion();
       public          postgres    false         ?           0    0 (   FUNCTION establecer_fecha_modificacion()    ACL     M   GRANT ALL ON FUNCTION public.establecer_fecha_modificacion() TO empresauser;
          public          postgres    false    208         ?            1259    57073    departamento    TABLE     	  CREATE TABLE public.departamento (
    id integer NOT NULL,
    nombre character varying(255),
    codigo character varying(255),
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);
     DROP TABLE public.departamento;
       public         heap    postgres    false         ?           0    0    TABLE departamento    ACL     7   GRANT ALL ON TABLE public.departamento TO empresauser;
          public          postgres    false    204         ?            1259    57085 	   municipio    TABLE     ,  CREATE TABLE public.municipio (
    id integer NOT NULL,
    nombre character varying(255),
    codigo character varying(255),
    id_departamento integer NOT NULL,
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);
    DROP TABLE public.municipio;
       public         heap    postgres    false         ?           0    0    TABLE municipio    ACL     4   GRANT ALL ON TABLE public.municipio TO empresauser;
          public          postgres    false    205         ?            1259    57141    persona    TABLE       CREATE TABLE public.persona (
    id integer NOT NULL,
    nombre character varying(255),
    id_tipo_documento integer NOT NULL,
    numero_documento character varying(255) NOT NULL,
    id_municipio integer NOT NULL,
    id_sexo integer NOT NULL,
    usuario character varying(255) NOT NULL,
    clave character varying(255) NOT NULL,
    eliminado integer,
    rol public.roles,
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);
    DROP TABLE public.persona;
       public         heap    postgres    false    648         ?           0    0    TABLE persona    ACL     2   GRANT ALL ON TABLE public.persona TO empresauser;
          public          postgres    false    207         ?            1259    57139    persona_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.persona_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.persona_id_seq;
       public          postgres    false    207         ?           0    0    persona_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.persona_id_seq OWNED BY public.persona.id;
          public          postgres    false    206         ?           0    0    SEQUENCE persona_id_seq    ACL     <   GRANT ALL ON SEQUENCE public.persona_id_seq TO empresauser;
          public          postgres    false    206         ?            1259    57059    sexo    TABLE     ?   CREATE TABLE public.sexo (
    id integer NOT NULL,
    nombre character varying(255),
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);
    DROP TABLE public.sexo;
       public         heap    postgres    false         ?           0    0 
   TABLE sexo    ACL     /   GRANT ALL ON TABLE public.sexo TO empresauser;
          public          postgres    false    202         ?            1259    57066    tipo_documento    TABLE       CREATE TABLE public.tipo_documento (
    id integer NOT NULL,
    nombre character varying(255),
    abreviatura character varying(255) NOT NULL,
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);
 "   DROP TABLE public.tipo_documento;
       public         heap    postgres    false         ?           0    0    TABLE tipo_documento    ACL     9   GRANT ALL ON TABLE public.tipo_documento TO empresauser;
          public          postgres    false    203                    2604    57144 
   persona id    DEFAULT     h   ALTER TABLE ONLY public.persona ALTER COLUMN id SET DEFAULT nextval('public.persona_id_seq'::regclass);
 9   ALTER TABLE public.persona ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    207    206    207         ?          0    57073    departamento 
   TABLE DATA           _   COPY public.departamento (id, nombre, codigo, creacion, modificacion, eliminacion) FROM stdin;
    public          postgres    false    204       2978.dat ?          0    57085 	   municipio 
   TABLE DATA           m   COPY public.municipio (id, nombre, codigo, id_departamento, creacion, modificacion, eliminacion) FROM stdin;
    public          postgres    false    205       2979.dat ?          0    57141    persona 
   TABLE DATA           ?   COPY public.persona (id, nombre, id_tipo_documento, numero_documento, id_municipio, id_sexo, usuario, clave, eliminado, rol, creacion, modificacion, eliminacion) FROM stdin;
    public          postgres    false    207       2981.dat ?          0    57059    sexo 
   TABLE DATA           O   COPY public.sexo (id, nombre, creacion, modificacion, eliminacion) FROM stdin;
    public          postgres    false    202       2976.dat ?          0    57066    tipo_documento 
   TABLE DATA           f   COPY public.tipo_documento (id, nombre, abreviatura, creacion, modificacion, eliminacion) FROM stdin;
    public          postgres    false    203       2977.dat ?           0    0    persona_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.persona_id_seq', 8, true);
          public          postgres    false    206                    2606    57084 $   departamento departamento_codigo_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_codigo_key UNIQUE (codigo);
 N   ALTER TABLE ONLY public.departamento DROP CONSTRAINT departamento_codigo_key;
       public            postgres    false    204                    2606    57082 $   departamento departamento_nombre_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_nombre_key UNIQUE (nombre);
 N   ALTER TABLE ONLY public.departamento DROP CONSTRAINT departamento_nombre_key;
       public            postgres    false    204                    2606    57080    departamento departamento_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.departamento DROP CONSTRAINT departamento_pkey;
       public            postgres    false    204                    2606    57096    municipio municipio_codigo_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT municipio_codigo_key UNIQUE (codigo);
 H   ALTER TABLE ONLY public.municipio DROP CONSTRAINT municipio_codigo_key;
       public            postgres    false    205                    2606    57092    municipio municipio_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT municipio_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.municipio DROP CONSTRAINT municipio_pkey;
       public            postgres    false    205                    2606    57151 #   persona persona_nombre_completo_key 
   CONSTRAINT     `   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_nombre_completo_key UNIQUE (nombre);
 M   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_nombre_completo_key;
       public            postgres    false    207                    2606    57153 $   persona persona_numero_documento_key 
   CONSTRAINT     k   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_numero_documento_key UNIQUE (numero_documento);
 N   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_numero_documento_key;
       public            postgres    false    207                    2606    57149    persona persona_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public            postgres    false    207                    2606    57065    sexo sexo_nombre_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.sexo
    ADD CONSTRAINT sexo_nombre_key UNIQUE (nombre);
 >   ALTER TABLE ONLY public.sexo DROP CONSTRAINT sexo_nombre_key;
       public            postgres    false    202         	           2606    57063    sexo sexo_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.sexo
    ADD CONSTRAINT sexo_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.sexo DROP CONSTRAINT sexo_pkey;
       public            postgres    false    202                    2606    57072 (   tipo_documento tipo_documento_nombre_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT tipo_documento_nombre_key UNIQUE (nombre);
 R   ALTER TABLE ONLY public.tipo_documento DROP CONSTRAINT tipo_documento_nombre_key;
       public            postgres    false    203                    2606    57070 "   tipo_documento tipo_documento_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT tipo_documento_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.tipo_documento DROP CONSTRAINT tipo_documento_pkey;
       public            postgres    false    203                     2620    57174 %   persona trg_establecer_fecha_creacion    TRIGGER     ?   CREATE TRIGGER trg_establecer_fecha_creacion BEFORE INSERT ON public.persona FOR EACH ROW EXECUTE FUNCTION public.establecer_fecha_creacion();
 >   DROP TRIGGER trg_establecer_fecha_creacion ON public.persona;
       public          postgres    false    209    207         !           2620    57175 )   persona trg_establecer_fecha_modificacion    TRIGGER     ?   CREATE TRIGGER trg_establecer_fecha_modificacion BEFORE UPDATE ON public.persona FOR EACH ROW EXECUTE FUNCTION public.establecer_fecha_modificacion();
 B   DROP TRIGGER trg_establecer_fecha_modificacion ON public.persona;
       public          postgres    false    207    208                    2606    57097 $   municipio fk_municipio__departamento    FK CONSTRAINT     ?   ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT fk_municipio__departamento FOREIGN KEY (id_departamento) REFERENCES public.departamento(id);
 N   ALTER TABLE ONLY public.municipio DROP CONSTRAINT fk_municipio__departamento;
       public          postgres    false    204    2835    205                    2606    57154    persona fk_persona__municipio    FK CONSTRAINT     ?   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_persona__municipio FOREIGN KEY (id_municipio) REFERENCES public.municipio(id);
 G   ALTER TABLE ONLY public.persona DROP CONSTRAINT fk_persona__municipio;
       public          postgres    false    2839    207    205                                                                                                                                                                                                                                                                                                                                                                                                                         2978.dat                                                                                            0000600 0004000 0002000 00000001453 14261170735 0014274 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Antioquia	05	\N	\N	\N
2	Atlántico	08	\N	\N	\N
3	Distrito Capital de Bogotá	11	\N	\N	\N
4	Bolívar	13	\N	\N	\N
5	Boyacá	15	\N	\N	\N
6	Caldas	17	\N	\N	\N
7	Caquetá	18	\N	\N	\N
8	Cauca	19	\N	\N	\N
9	Cesar	20	\N	\N	\N
10	Córdoba	23	\N	\N	\N
11	Cundinamarca	25	\N	\N	\N
12	Chocó	27	\N	\N	\N
13	Huila	41	\N	\N	\N
14	La Guajira	44	\N	\N	\N
15	Magdalena	47	\N	\N	\N
16	Meta	50	\N	\N	\N
17	Nariño	52	\N	\N	\N
18	Norte de Santander	54	\N	\N	\N
19	Quindío	63	\N	\N	\N
20	Risaralda	66	\N	\N	\N
21	Santander	68	\N	\N	\N
22	Sucre	70	\N	\N	\N
23	Tolima	73	\N	\N	\N
24	Valle del Cauca	76	\N	\N	\N
25	Arauca	81	\N	\N	\N
26	Casanare	85	\N	\N	\N
27	Putumayo	86	\N	\N	\N
28	San Andrés	88	\N	\N	\N
29	Amazonas	91	\N	\N	\N
30	Guainía	94	\N	\N	\N
31	Guaviare	95	\N	\N	\N
32	Vaupés	97	\N	\N	\N
33	Vichada	99	\N	\N	\N
\.


                                                                                                                                                                                                                     2979.dat                                                                                            0000600 0004000 0002000 00000111732 14261170735 0014277 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        5001	MEDELLÍN	05001	1	\N	\N	\N
5002	ABEJORRAL	05002	1	\N	\N	\N
5004	ABRIAQUÍ	05004	1	\N	\N	\N
5021	ALEJANDRÍA	05021	1	\N	\N	\N
5030	AMAGÁ	05030	1	\N	\N	\N
5031	AMALFI	05031	1	\N	\N	\N
5034	ANDES	05034	1	\N	\N	\N
5036	ANGELÓPOLIS	05036	1	\N	\N	\N
5038	ANGOSTURA	05038	1	\N	\N	\N
5040	ANORÍ	05040	1	\N	\N	\N
5042	SANTA FÉ DE ANTIOQUIA	05042	1	\N	\N	\N
5044	ANZÁ	05044	1	\N	\N	\N
5045	APARTADÓ	05045	1	\N	\N	\N
5051	ARBOLETES	05051	1	\N	\N	\N
5055	ARGELIA	05055	1	\N	\N	\N
5059	ARMENIA	05059	1	\N	\N	\N
5079	BARBOSA	05079	1	\N	\N	\N
5086	BELMIRA	05086	1	\N	\N	\N
5088	BELLO	05088	1	\N	\N	\N
5091	BETANIA	05091	1	\N	\N	\N
5093	BETULIA	05093	1	\N	\N	\N
5101	CIUDAD BOLÍVAR	05101	1	\N	\N	\N
5107	BRICEÑO	05107	1	\N	\N	\N
5113	BURITICÁ	05113	1	\N	\N	\N
5120	CÁCERES	05120	1	\N	\N	\N
5125	CAICEDO	05125	1	\N	\N	\N
5129	CALDAS	05129	1	\N	\N	\N
5134	CAMPAMENTO	05134	1	\N	\N	\N
5138	CAÑASGORDAS	05138	1	\N	\N	\N
5142	CARACOLÍ	05142	1	\N	\N	\N
5145	CARAMANTA	05145	1	\N	\N	\N
5147	CAREPA	05147	1	\N	\N	\N
5148	EL CARMEN DE VIBORAL	05148	1	\N	\N	\N
5150	CAROLINA	05150	1	\N	\N	\N
5154	CAUCASIA	05154	1	\N	\N	\N
5172	CHIGORODÓ	05172	1	\N	\N	\N
5190	CISNEROS	05190	1	\N	\N	\N
5197	COCORNÁ	05197	1	\N	\N	\N
5206	CONCEPCIÓN	05206	1	\N	\N	\N
5209	CONCORDIA	05209	1	\N	\N	\N
5212	COPACABANA	05212	1	\N	\N	\N
5234	DABEIBA	05234	1	\N	\N	\N
5237	DONMATÍAS	05237	1	\N	\N	\N
5240	EBÉJICO	05240	1	\N	\N	\N
5250	EL BAGRE	05250	1	\N	\N	\N
5264	ENTRERRÍOS	05264	1	\N	\N	\N
5266	ENVIGADO	05266	1	\N	\N	\N
5282	FREDONIA	05282	1	\N	\N	\N
5284	FRONTINO	05284	1	\N	\N	\N
5306	GIRALDO	05306	1	\N	\N	\N
5308	GIRARDOTA	05308	1	\N	\N	\N
5310	GÓMEZ PLATA	05310	1	\N	\N	\N
5313	GRANADA	05313	1	\N	\N	\N
5315	GUADALUPE	05315	1	\N	\N	\N
5318	GUARNE	05318	1	\N	\N	\N
5321	GUATAPÉ	05321	1	\N	\N	\N
5347	HELICONIA	05347	1	\N	\N	\N
5353	HISPANIA	05353	1	\N	\N	\N
5360	ITAGÜÍ	05360	1	\N	\N	\N
5361	ITUANGO	05361	1	\N	\N	\N
5364	JARDÍN	05364	1	\N	\N	\N
5368	JERICÓ	05368	1	\N	\N	\N
5376	LA CEJA	05376	1	\N	\N	\N
5380	LA ESTRELLA	05380	1	\N	\N	\N
5390	LA PINTADA	05390	1	\N	\N	\N
5400	LA UNIÓN	05400	1	\N	\N	\N
5411	LIBORINA	05411	1	\N	\N	\N
5425	MACEO	05425	1	\N	\N	\N
5440	MARINILLA	05440	1	\N	\N	\N
5467	MONTEBELLO	05467	1	\N	\N	\N
5475	MURINDÓ	05475	1	\N	\N	\N
5480	MUTATÁ	05480	1	\N	\N	\N
5483	NARIÑO	05483	1	\N	\N	\N
5490	NECOCLÍ	05490	1	\N	\N	\N
5495	NECHÍ	05495	1	\N	\N	\N
5501	OLAYA	05501	1	\N	\N	\N
5541	PEÑOL	05541	1	\N	\N	\N
5543	PEQUE	05543	1	\N	\N	\N
5576	PUEBLORRICO	05576	1	\N	\N	\N
5579	PUERTO BERRÍO	05579	1	\N	\N	\N
5585	PUERTO NARE	05585	1	\N	\N	\N
5591	PUERTO TRIUNFO	05591	1	\N	\N	\N
5604	REMEDIOS	05604	1	\N	\N	\N
5607	RETIRO	05607	1	\N	\N	\N
5615	RIONEGRO	05615	1	\N	\N	\N
5628	SABANALARGA	05628	1	\N	\N	\N
5631	SABANETA	05631	1	\N	\N	\N
5642	SALGAR	05642	1	\N	\N	\N
5647	SAN ANDRÉS DE CUERQUÍA	05647	1	\N	\N	\N
5649	SAN CARLOS	05649	1	\N	\N	\N
5652	SAN FRANCISCO	05652	1	\N	\N	\N
5656	SAN JERÓNIMO	05656	1	\N	\N	\N
5658	SAN JOSÉ DE LA MONTAÑA	05658	1	\N	\N	\N
5659	SAN JUAN DE URABÁ	05659	1	\N	\N	\N
5660	SAN LUIS	05660	1	\N	\N	\N
5664	SAN PEDRO DE LOS MILAGROS	05664	1	\N	\N	\N
5665	SAN PEDRO DE URABÁ	05665	1	\N	\N	\N
5667	SAN RAFAEL	05667	1	\N	\N	\N
5670	SAN ROQUE	05670	1	\N	\N	\N
5674	SAN VICENTE FERRER	05674	1	\N	\N	\N
5679	SANTA BÁRBARA	05679	1	\N	\N	\N
5686	SANTA ROSA DE OSOS	05686	1	\N	\N	\N
5690	SANTO DOMINGO	05690	1	\N	\N	\N
5697	EL SANTUARIO	05697	1	\N	\N	\N
5736	SEGOVIA	05736	1	\N	\N	\N
5756	SONSÓN	05756	1	\N	\N	\N
5761	SOPETRÁN	05761	1	\N	\N	\N
5789	TÁMESIS	05789	1	\N	\N	\N
5790	TARAZÁ	05790	1	\N	\N	\N
5792	TARSO	05792	1	\N	\N	\N
5809	TITIRIBÍ	05809	1	\N	\N	\N
5819	TOLEDO	05819	1	\N	\N	\N
5837	TURBO	05837	1	\N	\N	\N
5842	URAMITA	05842	1	\N	\N	\N
5847	URRAO	05847	1	\N	\N	\N
5854	VALDIVIA	05854	1	\N	\N	\N
5856	VALPARAÍSO	05856	1	\N	\N	\N
5858	VEGACHÍ	05858	1	\N	\N	\N
5861	VENECIA	05861	1	\N	\N	\N
5873	VIGÍA DEL FUERTE	05873	1	\N	\N	\N
5885	YALÍ	05885	1	\N	\N	\N
5887	YARUMAL	05887	1	\N	\N	\N
5890	YOLOMBÓ	05890	1	\N	\N	\N
5893	YONDÓ	05893	1	\N	\N	\N
5895	ZARAGOZA	05895	1	\N	\N	\N
8001	BARRANQUILLA	08001	2	\N	\N	\N
8078	BARANOA	08078	2	\N	\N	\N
8137	CAMPO DE LA CRUZ	08137	2	\N	\N	\N
8141	CANDELARIA	08141	2	\N	\N	\N
8296	GALAPA	08296	2	\N	\N	\N
8372	JUAN DE ACOSTA	08372	2	\N	\N	\N
8421	LURUACO	08421	2	\N	\N	\N
8433	MALAMBO	08433	2	\N	\N	\N
8436	MANATÍ	08436	2	\N	\N	\N
8520	PALMAR DE VARELA	08520	2	\N	\N	\N
8549	PIOJÓ	08549	2	\N	\N	\N
8558	POLONUEVO	08558	2	\N	\N	\N
8560	PONEDERA	08560	2	\N	\N	\N
8573	PUERTO COLOMBIA	08573	2	\N	\N	\N
8606	REPELÓN	08606	2	\N	\N	\N
8634	SABANAGRANDE	08634	2	\N	\N	\N
8638	SABANALARGA	08638	2	\N	\N	\N
8675	SANTA LUCÍA	08675	2	\N	\N	\N
8685	SANTO TOMÁS	08685	2	\N	\N	\N
8758	SOLEDAD	08758	2	\N	\N	\N
8770	SUAN	08770	2	\N	\N	\N
8832	TUBARÁ	08832	2	\N	\N	\N
8849	USIACURÍ	08849	2	\N	\N	\N
11001	Bogotá	11001	3	\N	\N	\N
13001	CARTAGENA DE INDIAS	13001	4	\N	\N	\N
13006	ACHÍ	13006	4	\N	\N	\N
13030	ALTOS DEL ROSARIO	13030	4	\N	\N	\N
13042	ARENAL	13042	4	\N	\N	\N
13052	ARJONA	13052	4	\N	\N	\N
13062	ARROYOHONDO	13062	4	\N	\N	\N
13074	BARRANCO DE LOBA	13074	4	\N	\N	\N
13140	CALAMAR	13140	4	\N	\N	\N
13160	CANTAGALLO	13160	4	\N	\N	\N
13188	CICUCO	13188	4	\N	\N	\N
13212	CÓRDOBA	13212	4	\N	\N	\N
13222	CLEMENCIA	13222	4	\N	\N	\N
13244	EL CARMEN DE BOLÍVAR	13244	4	\N	\N	\N
13248	EL GUAMO	13248	4	\N	\N	\N
13268	EL PEÑÓN	13268	4	\N	\N	\N
13300	HATILLO DE LOBA	13300	4	\N	\N	\N
13430	MAGANGUÉ	13430	4	\N	\N	\N
13433	MAHATES	13433	4	\N	\N	\N
13440	MARGARITA	13440	4	\N	\N	\N
13442	MARÍA LA BAJA	13442	4	\N	\N	\N
13458	MONTECRISTO	13458	4	\N	\N	\N
13468	MOMPÓS	13468	4	\N	\N	\N
13473	MORALES	13473	4	\N	\N	\N
13490	NOROSÍ	13490	4	\N	\N	\N
13549	PINILLOS	13549	4	\N	\N	\N
13580	REGIDOR	13580	4	\N	\N	\N
13600	RÍO VIEJO	13600	4	\N	\N	\N
13620	SAN CRISTÓBAL	13620	4	\N	\N	\N
13647	SAN ESTANISLAO	13647	4	\N	\N	\N
13650	SAN FERNANDO	13650	4	\N	\N	\N
13654	SAN JACINTO	13654	4	\N	\N	\N
13655	SAN JACINTO DEL CAUCA	13655	4	\N	\N	\N
13657	SAN JUAN NEPOMUCENO	13657	4	\N	\N	\N
13667	SAN MARTÍN DE LOBA	13667	4	\N	\N	\N
13670	SAN PABLO	13670	4	\N	\N	\N
13673	SANTA CATALINA	13673	4	\N	\N	\N
13683	SANTA ROSA	13683	4	\N	\N	\N
13688	SANTA ROSA DEL SUR	13688	4	\N	\N	\N
13744	SIMITÍ	13744	4	\N	\N	\N
13760	SOPLAVIENTO	13760	4	\N	\N	\N
13780	TALAIGUA NUEVO	13780	4	\N	\N	\N
13810	TIQUISIO	13810	4	\N	\N	\N
13836	TURBACO	13836	4	\N	\N	\N
13838	TURBANÁ	13838	4	\N	\N	\N
13873	VILLANUEVA	13873	4	\N	\N	\N
13894	ZAMBRANO	13894	4	\N	\N	\N
15001	TUNJA	15001	5	\N	\N	\N
15022	ALMEIDA	15022	5	\N	\N	\N
15047	AQUITANIA	15047	5	\N	\N	\N
15051	ARCABUCO	15051	5	\N	\N	\N
15087	BELÉN	15087	5	\N	\N	\N
15090	BERBEO	15090	5	\N	\N	\N
15092	BETÉITIVA	15092	5	\N	\N	\N
15097	BOAVITA	15097	5	\N	\N	\N
15104	BOYACÁ	15104	5	\N	\N	\N
15106	BRICEÑO	15106	5	\N	\N	\N
15109	BUENAVISTA	15109	5	\N	\N	\N
15114	BUSBANZÁ	15114	5	\N	\N	\N
15131	CALDAS	15131	5	\N	\N	\N
15135	CAMPOHERMOSO	15135	5	\N	\N	\N
15162	CERINZA	15162	5	\N	\N	\N
15172	CHINAVITA	15172	5	\N	\N	\N
15176	CHIQUINQUIRÁ	15176	5	\N	\N	\N
15180	CHISCAS	15180	5	\N	\N	\N
15183	CHITA	15183	5	\N	\N	\N
15185	CHITARAQUE	15185	5	\N	\N	\N
15187	CHIVATÁ	15187	5	\N	\N	\N
15189	CIÉNEGA	15189	5	\N	\N	\N
15204	CÓMBITA	15204	5	\N	\N	\N
15212	COPER	15212	5	\N	\N	\N
15215	CORRALES	15215	5	\N	\N	\N
15218	COVARACHÍA	15218	5	\N	\N	\N
15223	CUBARÁ	15223	5	\N	\N	\N
15224	CUCAITA	15224	5	\N	\N	\N
15226	CUÍTIVA	15226	5	\N	\N	\N
15232	CHÍQUIZA	15232	5	\N	\N	\N
15236	CHIVOR	15236	5	\N	\N	\N
15238	DUITAMA	15238	5	\N	\N	\N
15244	EL COCUY	15244	5	\N	\N	\N
15248	EL ESPINO	15248	5	\N	\N	\N
15272	FIRAVITOBA	15272	5	\N	\N	\N
15276	FLORESTA	15276	5	\N	\N	\N
15293	GACHANTIVÁ	15293	5	\N	\N	\N
15296	GÁMEZA	15296	5	\N	\N	\N
15299	GARAGOA	15299	5	\N	\N	\N
15317	GUACAMAYAS	15317	5	\N	\N	\N
15322	GUATEQUE	15322	5	\N	\N	\N
15325	GUAYATÁ	15325	5	\N	\N	\N
15332	GÜICÁN DE LA SIERRA	15332	5	\N	\N	\N
15362	IZA	15362	5	\N	\N	\N
15367	JENESANO	15367	5	\N	\N	\N
15368	JERICÓ	15368	5	\N	\N	\N
15377	LABRANZAGRANDE	15377	5	\N	\N	\N
15380	LA CAPILLA	15380	5	\N	\N	\N
15401	LA VICTORIA	15401	5	\N	\N	\N
15403	LA UVITA	15403	5	\N	\N	\N
15407	VILLA DE LEYVA	15407	5	\N	\N	\N
15425	MACANAL	15425	5	\N	\N	\N
15442	MARIPÍ	15442	5	\N	\N	\N
15455	MIRAFLORES	15455	5	\N	\N	\N
15464	MONGUA	15464	5	\N	\N	\N
15466	MONGUÍ	15466	5	\N	\N	\N
15469	MONIQUIRÁ	15469	5	\N	\N	\N
15476	MOTAVITA	15476	5	\N	\N	\N
15480	MUZO	15480	5	\N	\N	\N
15491	NOBSA	15491	5	\N	\N	\N
15494	NUEVO COLÓN	15494	5	\N	\N	\N
15500	OICATÁ	15500	5	\N	\N	\N
15507	OTANCHE	15507	5	\N	\N	\N
15511	PACHAVITA	15511	5	\N	\N	\N
15514	PÁEZ	15514	5	\N	\N	\N
15516	PAIPA	15516	5	\N	\N	\N
15518	PAJARITO	15518	5	\N	\N	\N
15522	PANQUEBA	15522	5	\N	\N	\N
15531	PAUNA	15531	5	\N	\N	\N
15533	PAYA	15533	5	\N	\N	\N
15537	PAZ DE RÍO	15537	5	\N	\N	\N
15542	PESCA	15542	5	\N	\N	\N
15550	PISBA	15550	5	\N	\N	\N
15572	PUERTO BOYACÁ	15572	5	\N	\N	\N
15580	QUÍPAMA	15580	5	\N	\N	\N
15599	RAMIRIQUÍ	15599	5	\N	\N	\N
15600	RÁQUIRA	15600	5	\N	\N	\N
15621	RONDÓN	15621	5	\N	\N	\N
15632	SABOYÁ	15632	5	\N	\N	\N
15638	SÁCHICA	15638	5	\N	\N	\N
15646	SAMACÁ	15646	5	\N	\N	\N
15660	SAN EDUARDO	15660	5	\N	\N	\N
15664	SAN JOSÉ DE PARE	15664	5	\N	\N	\N
15667	SAN LUIS DE GACENO	15667	5	\N	\N	\N
15673	SAN MATEO	15673	5	\N	\N	\N
15676	SAN MIGUEL DE SEMA	15676	5	\N	\N	\N
15681	SAN PABLO DE BORBUR	15681	5	\N	\N	\N
15686	SANTANA	15686	5	\N	\N	\N
15690	SANTA MARÍA	15690	5	\N	\N	\N
15693	SANTA ROSA DE VITERBO	15693	5	\N	\N	\N
15696	SANTA SOFÍA	15696	5	\N	\N	\N
15720	SATIVANORTE	15720	5	\N	\N	\N
15723	SATIVASUR	15723	5	\N	\N	\N
15740	SIACHOQUE	15740	5	\N	\N	\N
15753	SOATÁ	15753	5	\N	\N	\N
15755	SOCOTÁ	15755	5	\N	\N	\N
15757	SOCHA	15757	5	\N	\N	\N
15759	SOGAMOSO	15759	5	\N	\N	\N
15761	SOMONDOCO	15761	5	\N	\N	\N
15762	SORA	15762	5	\N	\N	\N
15763	SOTAQUIRÁ	15763	5	\N	\N	\N
15764	SORACÁ	15764	5	\N	\N	\N
15774	SUSACÓN	15774	5	\N	\N	\N
15776	SUTAMARCHÁN	15776	5	\N	\N	\N
15778	SUTATENZA	15778	5	\N	\N	\N
15790	TASCO	15790	5	\N	\N	\N
15798	TENZA	15798	5	\N	\N	\N
15804	TIBANÁ	15804	5	\N	\N	\N
15806	TIBASOSA	15806	5	\N	\N	\N
15808	TINJACÁ	15808	5	\N	\N	\N
15810	TIPACOQUE	15810	5	\N	\N	\N
15814	TOCA	15814	5	\N	\N	\N
15816	TOGÜÍ	15816	5	\N	\N	\N
15820	TÓPAGA	15820	5	\N	\N	\N
15822	TOTA	15822	5	\N	\N	\N
15832	TUNUNGUÁ	15832	5	\N	\N	\N
15835	TURMEQUÉ	15835	5	\N	\N	\N
15837	TUTA	15837	5	\N	\N	\N
15839	TUTAZÁ	15839	5	\N	\N	\N
15842	ÚMBITA	15842	5	\N	\N	\N
15861	VENTAQUEMADA	15861	5	\N	\N	\N
15879	VIRACACHÁ	15879	5	\N	\N	\N
15897	ZETAQUIRA	15897	5	\N	\N	\N
17001	MANIZALES	17001	6	\N	\N	\N
17013	AGUADAS	17013	6	\N	\N	\N
17042	ANSERMA	17042	6	\N	\N	\N
17050	ARANZAZU	17050	6	\N	\N	\N
17088	BELALCÁZAR	17088	6	\N	\N	\N
17174	CHINCHINÁ	17174	6	\N	\N	\N
17272	FILADELFIA	17272	6	\N	\N	\N
17380	LA DORADA	17380	6	\N	\N	\N
17388	LA MERCED	17388	6	\N	\N	\N
17433	MANZANARES	17433	6	\N	\N	\N
17442	MARMATO	17442	6	\N	\N	\N
17444	MARQUETALIA	17444	6	\N	\N	\N
17446	MARULANDA	17446	6	\N	\N	\N
17486	NEIRA	17486	6	\N	\N	\N
17495	NORCASIA	17495	6	\N	\N	\N
17513	PÁCORA	17513	6	\N	\N	\N
17524	PALESTINA	17524	6	\N	\N	\N
17541	PENSILVANIA	17541	6	\N	\N	\N
17614	RIOSUCIO	17614	6	\N	\N	\N
17616	RISARALDA	17616	6	\N	\N	\N
17653	SALAMINA	17653	6	\N	\N	\N
17662	SAMANÁ	17662	6	\N	\N	\N
17665	SAN JOSÉ	17665	6	\N	\N	\N
17777	SUPÍA	17777	6	\N	\N	\N
17867	VICTORIA	17867	6	\N	\N	\N
17873	VILLAMARÍA	17873	6	\N	\N	\N
17877	VITERBO	17877	6	\N	\N	\N
18001	FLORENCIA	18001	7	\N	\N	\N
18029	ALBANIA	18029	7	\N	\N	\N
18094	BELÉN DE LOS ANDAQUÍES	18094	7	\N	\N	\N
18150	CARTAGENA DEL CHAIRÁ	18150	7	\N	\N	\N
18205	CURILLO	18205	7	\N	\N	\N
18247	EL DONCELLO	18247	7	\N	\N	\N
18256	EL PAUJÍL	18256	7	\N	\N	\N
18410	LA MONTAÑITA	18410	7	\N	\N	\N
18460	MILÁN	18460	7	\N	\N	\N
18479	MORELIA	18479	7	\N	\N	\N
18592	PUERTO RICO	18592	7	\N	\N	\N
18610	SAN JOSÉ DEL FRAGUA	18610	7	\N	\N	\N
18753	SAN VICENTE DEL CAGUÁN	18753	7	\N	\N	\N
18756	SOLANO	18756	7	\N	\N	\N
18785	SOLITA	18785	7	\N	\N	\N
18860	VALPARAÍSO	18860	7	\N	\N	\N
19001	POPAYÁN	19001	8	\N	\N	\N
19022	ALMAGUER	19022	8	\N	\N	\N
19050	ARGELIA	19050	8	\N	\N	\N
19075	BALBOA	19075	8	\N	\N	\N
19100	BOLÍVAR	19100	8	\N	\N	\N
19110	BUENOS AIRES	19110	8	\N	\N	\N
19130	CAJIBÍO	19130	8	\N	\N	\N
19137	CALDONO	19137	8	\N	\N	\N
19142	CALOTO	19142	8	\N	\N	\N
19212	CORINTO	19212	8	\N	\N	\N
19256	EL TAMBO	19256	8	\N	\N	\N
19290	FLORENCIA	19290	8	\N	\N	\N
19300	GUACHENÉ	19300	8	\N	\N	\N
19318	GUAPI	19318	8	\N	\N	\N
19355	INZÁ	19355	8	\N	\N	\N
19364	JAMBALÓ	19364	8	\N	\N	\N
19392	LA SIERRA	19392	8	\N	\N	\N
19397	LA VEGA	19397	8	\N	\N	\N
19418	LÓPEZ DE MICAY	19418	8	\N	\N	\N
19450	MERCADERES	19450	8	\N	\N	\N
19455	MIRANDA	19455	8	\N	\N	\N
19473	MORALES	19473	8	\N	\N	\N
19513	PADILLA	19513	8	\N	\N	\N
19517	PÁEZ	19517	8	\N	\N	\N
19532	PATÍA	19532	8	\N	\N	\N
19533	PIAMONTE	19533	8	\N	\N	\N
19548	PIENDAMÓ - TUNÍA	19548	8	\N	\N	\N
19573	PUERTO TEJADA	19573	8	\N	\N	\N
19585	PURACÉ	19585	8	\N	\N	\N
19622	ROSAS	19622	8	\N	\N	\N
19693	SAN SEBASTIÁN	19693	8	\N	\N	\N
19698	SANTANDER DE QUILICHAO	19698	8	\N	\N	\N
19701	SANTA ROSA	19701	8	\N	\N	\N
19743	SILVIA	19743	8	\N	\N	\N
19760	SOTARÁ - PAISPAMBA	19760	8	\N	\N	\N
19780	SUÁREZ	19780	8	\N	\N	\N
19785	SUCRE	19785	8	\N	\N	\N
19807	TIMBÍO	19807	8	\N	\N	\N
19809	TIMBIQUÍ	19809	8	\N	\N	\N
19821	TORIBÍO	19821	8	\N	\N	\N
19824	TOTORÓ	19824	8	\N	\N	\N
19845	VILLA RICA	19845	8	\N	\N	\N
20001	VALLEDUPAR	20001	9	\N	\N	\N
20011	AGUACHICA	20011	9	\N	\N	\N
20013	AGUSTÍN CODAZZI	20013	9	\N	\N	\N
20032	ASTREA	20032	9	\N	\N	\N
20045	BECERRIL	20045	9	\N	\N	\N
20060	BOSCONIA	20060	9	\N	\N	\N
20175	CHIMICHAGUA	20175	9	\N	\N	\N
20178	CHIRIGUANÁ	20178	9	\N	\N	\N
20228	CURUMANÍ	20228	9	\N	\N	\N
20238	EL COPEY	20238	9	\N	\N	\N
20250	EL PASO	20250	9	\N	\N	\N
20295	GAMARRA	20295	9	\N	\N	\N
20310	GONZÁLEZ	20310	9	\N	\N	\N
20383	LA GLORIA	20383	9	\N	\N	\N
20400	LA JAGUA DE IBIRICO	20400	9	\N	\N	\N
20443	MANAURE BALCÓN DEL CESAR	20443	9	\N	\N	\N
20517	PAILITAS	20517	9	\N	\N	\N
20550	PELAYA	20550	9	\N	\N	\N
20570	PUEBLO BELLO	20570	9	\N	\N	\N
20614	RÍO DE ORO	20614	9	\N	\N	\N
20621	LA PAZ	20621	9	\N	\N	\N
20710	SAN ALBERTO	20710	9	\N	\N	\N
20750	SAN DIEGO	20750	9	\N	\N	\N
20770	SAN MARTÍN	20770	9	\N	\N	\N
20787	TAMALAMEQUE	20787	9	\N	\N	\N
23001	MONTERÍA	23001	10	\N	\N	\N
23068	AYAPEL	23068	10	\N	\N	\N
23079	BUENAVISTA	23079	10	\N	\N	\N
23090	CANALETE	23090	10	\N	\N	\N
23162	CERETÉ	23162	10	\N	\N	\N
23168	CHIMÁ	23168	10	\N	\N	\N
23182	CHINÚ	23182	10	\N	\N	\N
23189	CIÉNAGA DE ORO	23189	10	\N	\N	\N
23300	COTORRA	23300	10	\N	\N	\N
23350	LA APARTADA	23350	10	\N	\N	\N
23417	LORICA	23417	10	\N	\N	\N
23419	LOS CÓRDOBAS	23419	10	\N	\N	\N
23464	MOMIL	23464	10	\N	\N	\N
23466	MONTELÍBANO	23466	10	\N	\N	\N
23500	MOÑITOS	23500	10	\N	\N	\N
23555	PLANETA RICA	23555	10	\N	\N	\N
23570	PUEBLO NUEVO	23570	10	\N	\N	\N
23574	PUERTO ESCONDIDO	23574	10	\N	\N	\N
23580	PUERTO LIBERTADOR	23580	10	\N	\N	\N
23586	PURÍSIMA DE LA CONCEPCIÓN	23586	10	\N	\N	\N
23660	SAHAGÚN	23660	10	\N	\N	\N
23670	SAN ANDRÉS DE SOTAVENTO	23670	10	\N	\N	\N
23672	SAN ANTERO	23672	10	\N	\N	\N
23675	SAN BERNARDO DEL VIENTO	23675	10	\N	\N	\N
23678	SAN CARLOS	23678	10	\N	\N	\N
23682	SAN JOSÉ DE URÉ	23682	10	\N	\N	\N
23686	SAN PELAYO	23686	10	\N	\N	\N
23807	TIERRALTA	23807	10	\N	\N	\N
23815	TUCHÍN	23815	10	\N	\N	\N
23855	VALENCIA	23855	10	\N	\N	\N
25001	Agua de Dios	25001	11	\N	\N	\N
25019	Albán	25019	11	\N	\N	\N
25035	Anapoima	25035	11	\N	\N	\N
25040	Anolaima	25040	11	\N	\N	\N
25053	Arbeláez	25053	11	\N	\N	\N
25086	Beltrán	25086	11	\N	\N	\N
25095	Bituima	25095	11	\N	\N	\N
25099	Bojacá	25099	11	\N	\N	\N
25120	Cabrera	25120	11	\N	\N	\N
25123	Cachipay	25123	11	\N	\N	\N
25126	Cajicá	25126	11	\N	\N	\N
25148	Caparrapí	25148	11	\N	\N	\N
25151	Cáqueza	25151	11	\N	\N	\N
25154	Carmen de Carupa	25154	11	\N	\N	\N
25168	Chaguaní	25168	11	\N	\N	\N
25175	Chía	25175	11	\N	\N	\N
25178	Chipaque	25178	11	\N	\N	\N
25181	Choachí	25181	11	\N	\N	\N
25183	Chocontá	25183	11	\N	\N	\N
25200	Cogua	25200	11	\N	\N	\N
25214	Cota	25214	11	\N	\N	\N
25224	Cucunubá	25224	11	\N	\N	\N
25245	El Colegio	25245	11	\N	\N	\N
25258	El Peñón	25258	11	\N	\N	\N
25260	El Rosal	25260	11	\N	\N	\N
25269	Facatativá	25269	11	\N	\N	\N
25279	Fómeque	25279	11	\N	\N	\N
25281	Fosca	25281	11	\N	\N	\N
25286	Funza	25286	11	\N	\N	\N
25288	Fúquene	25288	11	\N	\N	\N
25290	Fusagasugá	25290	11	\N	\N	\N
25293	Gachalá	25293	11	\N	\N	\N
25295	Gachancipá	25295	11	\N	\N	\N
25297	Gachetá	25297	11	\N	\N	\N
25299	Gama	25299	11	\N	\N	\N
25307	Girardot	25307	11	\N	\N	\N
25312	Granada	25312	11	\N	\N	\N
25317	Guachetá	25317	11	\N	\N	\N
25320	Guaduas	25320	11	\N	\N	\N
25322	Guasca	25322	11	\N	\N	\N
25324	Guataquí	25324	11	\N	\N	\N
25326	Guatavita	25326	11	\N	\N	\N
25328	Guayabal de Síquima	25328	11	\N	\N	\N
25335	Guayabetal	25335	11	\N	\N	\N
25339	Gutiérrez	25339	11	\N	\N	\N
25368	Jerusalén	25368	11	\N	\N	\N
25372	Junín	25372	11	\N	\N	\N
25377	La Calera	25377	11	\N	\N	\N
25386	La Mesa	25386	11	\N	\N	\N
25394	La Palma	25394	11	\N	\N	\N
25398	La Peña	25398	11	\N	\N	\N
25402	La Vega	25402	11	\N	\N	\N
25407	Lenguazaque	25407	11	\N	\N	\N
25426	Machetá	25426	11	\N	\N	\N
25430	Madrid	25430	11	\N	\N	\N
25436	Manta	25436	11	\N	\N	\N
25438	Medina	25438	11	\N	\N	\N
25473	Mosquera	25473	11	\N	\N	\N
25483	NARIÑO	25483	11	\N	\N	\N
25486	Nemocón	25486	11	\N	\N	\N
25488	Nilo	25488	11	\N	\N	\N
25489	Nimaima	25489	11	\N	\N	\N
25491	Nocaima	25491	11	\N	\N	\N
25506	Venecia	25506	11	\N	\N	\N
25513	Pacho	25513	11	\N	\N	\N
25518	Paime	25518	11	\N	\N	\N
25524	Pandi	25524	11	\N	\N	\N
25530	Paratebueno	25530	11	\N	\N	\N
25535	Pasca	25535	11	\N	\N	\N
25572	Puerto Salgar	25572	11	\N	\N	\N
25580	Pulí	25580	11	\N	\N	\N
25592	Quebradanegra	25592	11	\N	\N	\N
25594	Quetame	25594	11	\N	\N	\N
25596	Quipile	25596	11	\N	\N	\N
25599	Apulo	25599	11	\N	\N	\N
25612	Ricaurte	25612	11	\N	\N	\N
25645	San Antonio del Tequendama	25645	11	\N	\N	\N
25649	San Bernardo	25649	11	\N	\N	\N
25653	San Cayetano	25653	11	\N	\N	\N
25658	San Francisco	25658	11	\N	\N	\N
25662	San Juan de Rioseco	25662	11	\N	\N	\N
25718	Sasaima	25718	11	\N	\N	\N
25736	Sesquilé	25736	11	\N	\N	\N
25740	Sibaté	25740	11	\N	\N	\N
25743	Silvania	25743	11	\N	\N	\N
25745	Simijaca	25745	11	\N	\N	\N
25754	Soacha	25754	11	\N	\N	\N
25758	Sopó	25758	11	\N	\N	\N
25769	Subachoque	25769	11	\N	\N	\N
25772	Suesca	25772	11	\N	\N	\N
25777	Supatá	25777	11	\N	\N	\N
25779	Susa	25779	11	\N	\N	\N
25781	Sutatausa	25781	11	\N	\N	\N
25785	Tabio	25785	11	\N	\N	\N
25793	Tausa	25793	11	\N	\N	\N
25797	Tena	25797	11	\N	\N	\N
25799	Tenjo	25799	11	\N	\N	\N
25805	Tibacuy	25805	11	\N	\N	\N
25807	Tibirita	25807	11	\N	\N	\N
25815	Tocaima	25815	11	\N	\N	\N
25817	Tocancipá	25817	11	\N	\N	\N
25823	Topaipí	25823	11	\N	\N	\N
25839	Ubalá	25839	11	\N	\N	\N
25841	Ubaque	25841	11	\N	\N	\N
25843	Ubaté	25843	11	\N	\N	\N
25845	Une	25845	11	\N	\N	\N
25851	Útica	25851	11	\N	\N	\N
25862	Vergara	25862	11	\N	\N	\N
25867	Vianí	25867	11	\N	\N	\N
25871	Villagómez	25871	11	\N	\N	\N
25873	Villapinzón	25873	11	\N	\N	\N
25875	Villeta	25875	11	\N	\N	\N
25878	Viotá	25878	11	\N	\N	\N
25885	Yacopí	25885	11	\N	\N	\N
25898	Zipacón	25898	11	\N	\N	\N
25899	Zipaquirá	25899	11	\N	\N	\N
27001	QUIBDÓ	27001	12	\N	\N	\N
27006	ACANDÍ	27006	12	\N	\N	\N
27025	ALTO BAUDÓ	27025	12	\N	\N	\N
27050	ATRATO	27050	12	\N	\N	\N
27073	BAGADÓ	27073	12	\N	\N	\N
27075	BAHÍA SOLANO	27075	12	\N	\N	\N
27077	BAJO BAUDÓ	27077	12	\N	\N	\N
27099	BOJAYÁ	27099	12	\N	\N	\N
27135	EL CANTÓN DEL SAN PABLO	27135	12	\N	\N	\N
27150	CARMEN DEL DARIÉN	27150	12	\N	\N	\N
27160	CÉRTEGUI	27160	12	\N	\N	\N
27205	CONDOTO	27205	12	\N	\N	\N
27245	EL CARMEN DE ATRATO	27245	12	\N	\N	\N
27250	EL LITORAL DEL SAN JUAN	27250	12	\N	\N	\N
27361	ISTMINA	27361	12	\N	\N	\N
27372	JURADÓ	27372	12	\N	\N	\N
27413	LLORÓ	27413	12	\N	\N	\N
27425	MEDIO ATRATO	27425	12	\N	\N	\N
27430	MEDIO BAUDÓ	27430	12	\N	\N	\N
27450	MEDIO SAN JUAN	27450	12	\N	\N	\N
27491	NÓVITA	27491	12	\N	\N	\N
27495	NUQUÍ	27495	12	\N	\N	\N
27580	RÍO IRÓ	27580	12	\N	\N	\N
27600	RÍO QUITO	27600	12	\N	\N	\N
27615	RIOSUCIO	27615	12	\N	\N	\N
27660	SAN JOSÉ DEL PALMAR	27660	12	\N	\N	\N
27745	SIPÍ	27745	12	\N	\N	\N
27787	TADÓ	27787	12	\N	\N	\N
27800	UNGUÍA	27800	12	\N	\N	\N
27810	UNIÓN PANAMERICANA	27810	12	\N	\N	\N
41001	NEIVA	41001	13	\N	\N	\N
41006	ACEVEDO	41006	13	\N	\N	\N
41013	AGRADO	41013	13	\N	\N	\N
41016	AIPE	41016	13	\N	\N	\N
41020	ALGECIRAS	41020	13	\N	\N	\N
41026	ALTAMIRA	41026	13	\N	\N	\N
41078	BARAYA	41078	13	\N	\N	\N
41132	CAMPOALEGRE	41132	13	\N	\N	\N
41206	COLOMBIA	41206	13	\N	\N	\N
41244	ELÍAS	41244	13	\N	\N	\N
41298	GARZÓN	41298	13	\N	\N	\N
41306	GIGANTE	41306	13	\N	\N	\N
41319	GUADALUPE	41319	13	\N	\N	\N
41349	HOBO	41349	13	\N	\N	\N
41357	ÍQUIRA	41357	13	\N	\N	\N
41359	ISNOS	41359	13	\N	\N	\N
41378	LA ARGENTINA	41378	13	\N	\N	\N
41396	LA PLATA	41396	13	\N	\N	\N
41483	NÁTAGA	41483	13	\N	\N	\N
41503	OPORAPA	41503	13	\N	\N	\N
41518	PAICOL	41518	13	\N	\N	\N
41524	PALERMO	41524	13	\N	\N	\N
41530	PALESTINA	41530	13	\N	\N	\N
41548	PITAL	41548	13	\N	\N	\N
41551	PITALITO	41551	13	\N	\N	\N
41615	RIVERA	41615	13	\N	\N	\N
41660	SALADOBLANCO	41660	13	\N	\N	\N
41668	SAN AGUSTÍN	41668	13	\N	\N	\N
41676	SANTA MARÍA	41676	13	\N	\N	\N
41770	SUAZA	41770	13	\N	\N	\N
41791	TARQUI	41791	13	\N	\N	\N
41797	TESALIA	41797	13	\N	\N	\N
41799	TELLO	41799	13	\N	\N	\N
41801	TERUEL	41801	13	\N	\N	\N
41807	TIMANÁ	41807	13	\N	\N	\N
41872	VILLAVIEJA	41872	13	\N	\N	\N
41885	YAGUARÁ	41885	13	\N	\N	\N
44001	RIOHACHA	44001	14	\N	\N	\N
44035	ALBANIA	44035	14	\N	\N	\N
44078	BARRANCAS	44078	14	\N	\N	\N
44090	DIBULLA	44090	14	\N	\N	\N
44098	DISTRACCIÓN	44098	14	\N	\N	\N
44110	EL MOLINO	44110	14	\N	\N	\N
44279	FONSECA	44279	14	\N	\N	\N
44378	HATONUEVO	44378	14	\N	\N	\N
44420	LA JAGUA DEL PILAR	44420	14	\N	\N	\N
44430	MAICAO	44430	14	\N	\N	\N
44560	MANAURE	44560	14	\N	\N	\N
44650	SAN JUAN DEL CESAR	44650	14	\N	\N	\N
44847	URIBIA	44847	14	\N	\N	\N
44855	URUMITA	44855	14	\N	\N	\N
44874	VILLANUEVA	44874	14	\N	\N	\N
47001	SANTA MARTA	47001	15	\N	\N	\N
47030	ALGARROBO	47030	15	\N	\N	\N
47053	ARACATACA	47053	15	\N	\N	\N
47058	ARIGUANÍ	47058	15	\N	\N	\N
47161	CERRO DE SAN ANTONIO	47161	15	\N	\N	\N
47170	CHIVOLO	47170	15	\N	\N	\N
47189	CIÉNAGA	47189	15	\N	\N	\N
47205	CONCORDIA	47205	15	\N	\N	\N
47245	EL BANCO	47245	15	\N	\N	\N
47258	EL PIÑÓN	47258	15	\N	\N	\N
47268	EL RETÉN	47268	15	\N	\N	\N
47288	FUNDACIÓN	47288	15	\N	\N	\N
47318	GUAMAL	47318	15	\N	\N	\N
47460	NUEVA GRANADA	47460	15	\N	\N	\N
47541	PEDRAZA	47541	15	\N	\N	\N
47545	PIJIÑO DEL CARMEN	47545	15	\N	\N	\N
47551	PIVIJAY	47551	15	\N	\N	\N
47555	PLATO	47555	15	\N	\N	\N
47570	PUEBLOVIEJO	47570	15	\N	\N	\N
47605	REMOLINO	47605	15	\N	\N	\N
47660	SABANAS DE SAN ÁNGEL	47660	15	\N	\N	\N
47675	SALAMINA	47675	15	\N	\N	\N
47692	SAN SEBASTIÁN DE BUENAVISTA	47692	15	\N	\N	\N
47703	SAN ZENÓN	47703	15	\N	\N	\N
47707	SANTA ANA	47707	15	\N	\N	\N
47720	SANTA BÁRBARA DE PINTO	47720	15	\N	\N	\N
47745	SITIONUEVO	47745	15	\N	\N	\N
47798	TENERIFE	47798	15	\N	\N	\N
47960	ZAPAYÁN	47960	15	\N	\N	\N
47980	ZONA BANANERA	47980	15	\N	\N	\N
50001	VILLAVICENCIO	50001	16	\N	\N	\N
50006	ACACÍAS	50006	16	\N	\N	\N
50110	BARRANCA DE UPÍA	50110	16	\N	\N	\N
50124	CABUYARO	50124	16	\N	\N	\N
50150	CASTILLA LA NUEVA	50150	16	\N	\N	\N
50223	CUBARRAL	50223	16	\N	\N	\N
50226	CUMARAL	50226	16	\N	\N	\N
50245	EL CALVARIO	50245	16	\N	\N	\N
50251	EL CASTILLO	50251	16	\N	\N	\N
50270	EL DORADO	50270	16	\N	\N	\N
50287	FUENTE DE ORO	50287	16	\N	\N	\N
50313	GRANADA	50313	16	\N	\N	\N
50318	GUAMAL	50318	16	\N	\N	\N
50325	MAPIRIPÁN	50325	16	\N	\N	\N
50330	MESETAS	50330	16	\N	\N	\N
50350	LA MACARENA	50350	16	\N	\N	\N
50370	URIBE	50370	16	\N	\N	\N
50400	LEJANÍAS	50400	16	\N	\N	\N
50450	PUERTO CONCORDIA	50450	16	\N	\N	\N
50568	PUERTO GAITÁN	50568	16	\N	\N	\N
50573	PUERTO LÓPEZ	50573	16	\N	\N	\N
50577	PUERTO LLERAS	50577	16	\N	\N	\N
50590	PUERTO RICO	50590	16	\N	\N	\N
50606	RESTREPO	50606	16	\N	\N	\N
50680	SAN CARLOS DE GUAROA	50680	16	\N	\N	\N
50683	SAN JUAN DE ARAMA	50683	16	\N	\N	\N
50686	SAN JUANITO	50686	16	\N	\N	\N
50689	SAN MARTÍN	50689	16	\N	\N	\N
50711	VISTAHERMOSA	50711	16	\N	\N	\N
52001	PASTO	52001	17	\N	\N	\N
52019	ALBÁN	52019	17	\N	\N	\N
52022	ALDANA	52022	17	\N	\N	\N
52036	ANCUYA	52036	17	\N	\N	\N
52051	ARBOLEDA	52051	17	\N	\N	\N
52079	BARBACOAS	52079	17	\N	\N	\N
52083	BELÉN	52083	17	\N	\N	\N
52110	BUESACO	52110	17	\N	\N	\N
52203	COLÓN	52203	17	\N	\N	\N
52207	CONSACÁ	52207	17	\N	\N	\N
52210	CONTADERO	52210	17	\N	\N	\N
52215	CÓRDOBA	52215	17	\N	\N	\N
52224	CUASPUD CARLOSAMA	52224	17	\N	\N	\N
52227	CUMBAL	52227	17	\N	\N	\N
52233	CUMBITARA	52233	17	\N	\N	\N
52240	CHACHAGÜÍ	52240	17	\N	\N	\N
52250	EL CHARCO	52250	17	\N	\N	\N
52254	EL PEÑOL	52254	17	\N	\N	\N
52256	EL ROSARIO	52256	17	\N	\N	\N
52258	EL TABLÓN DE GÓMEZ	52258	17	\N	\N	\N
52260	EL TAMBO	52260	17	\N	\N	\N
52287	FUNES	52287	17	\N	\N	\N
52317	GUACHUCAL	52317	17	\N	\N	\N
52320	GUAITARILLA	52320	17	\N	\N	\N
52323	GUALMATÁN	52323	17	\N	\N	\N
52352	ILES	52352	17	\N	\N	\N
52354	IMUÉS	52354	17	\N	\N	\N
52356	IPIALES	52356	17	\N	\N	\N
52378	LA CRUZ	52378	17	\N	\N	\N
52381	LA FLORIDA	52381	17	\N	\N	\N
52385	LA LLANADA	52385	17	\N	\N	\N
52390	LA TOLA	52390	17	\N	\N	\N
52399	LA UNIÓN	52399	17	\N	\N	\N
52405	LEIVA	52405	17	\N	\N	\N
52411	LINARES	52411	17	\N	\N	\N
52418	LOS ANDES	52418	17	\N	\N	\N
52427	MAGÜÍ	52427	17	\N	\N	\N
52435	MALLAMA	52435	17	\N	\N	\N
52473	MOSQUERA	52473	17	\N	\N	\N
52480	NARIÑO	52480	17	\N	\N	\N
52490	OLAYA HERRERA	52490	17	\N	\N	\N
52506	OSPINA	52506	17	\N	\N	\N
52520	FRANCISCO PIZARRO	52520	17	\N	\N	\N
52540	POLICARPA	52540	17	\N	\N	\N
52560	POTOSÍ	52560	17	\N	\N	\N
52565	PROVIDENCIA	52565	17	\N	\N	\N
52573	PUERRES	52573	17	\N	\N	\N
52585	PUPIALES	52585	17	\N	\N	\N
52612	RICAURTE	52612	17	\N	\N	\N
52621	ROBERTO PAYÁN	52621	17	\N	\N	\N
52678	SAMANIEGO	52678	17	\N	\N	\N
52683	SANDONÁ	52683	17	\N	\N	\N
52685	SAN BERNARDO	52685	17	\N	\N	\N
52687	SAN LORENZO	52687	17	\N	\N	\N
52693	SAN PABLO	52693	17	\N	\N	\N
52694	SAN PEDRO DE CARTAGO	52694	17	\N	\N	\N
52696	SANTA BÁRBARA	52696	17	\N	\N	\N
52699	SANTACRUZ	52699	17	\N	\N	\N
52720	SAPUYES	52720	17	\N	\N	\N
52786	TAMINANGO	52786	17	\N	\N	\N
52788	TANGUA	52788	17	\N	\N	\N
52835	SAN ANDRÉS DE TUMACO	52835	17	\N	\N	\N
52838	TÚQUERRES	52838	17	\N	\N	\N
52885	YACUANQUER	52885	17	\N	\N	\N
54001	SAN JOSÉ DE CÚCUTA	54001	18	\N	\N	\N
54003	ÁBREGO	54003	18	\N	\N	\N
54051	ARBOLEDAS	54051	18	\N	\N	\N
54099	BOCHALEMA	54099	18	\N	\N	\N
54109	BUCARASICA	54109	18	\N	\N	\N
54125	CÁCOTA	54125	18	\N	\N	\N
54128	CÁCHIRA	54128	18	\N	\N	\N
54172	CHINÁCOTA	54172	18	\N	\N	\N
54174	CHITAGÁ	54174	18	\N	\N	\N
54206	CONVENCIÓN	54206	18	\N	\N	\N
54223	CUCUTILLA	54223	18	\N	\N	\N
54239	DURANIA	54239	18	\N	\N	\N
54245	EL CARMEN	54245	18	\N	\N	\N
54250	EL TARRA	54250	18	\N	\N	\N
54261	EL ZULIA	54261	18	\N	\N	\N
54313	GRAMALOTE	54313	18	\N	\N	\N
54344	HACARÍ	54344	18	\N	\N	\N
54347	HERRÁN	54347	18	\N	\N	\N
54377	LABATECA	54377	18	\N	\N	\N
54385	LA ESPERANZA	54385	18	\N	\N	\N
54398	LA PLAYA	54398	18	\N	\N	\N
54405	LOS PATIOS	54405	18	\N	\N	\N
54418	LOURDES	54418	18	\N	\N	\N
54480	MUTISCUA	54480	18	\N	\N	\N
54498	OCAÑA	54498	18	\N	\N	\N
54518	PAMPLONA	54518	18	\N	\N	\N
54520	PAMPLONITA	54520	18	\N	\N	\N
54553	PUERTO SANTANDER	54553	18	\N	\N	\N
54599	RAGONVALIA	54599	18	\N	\N	\N
54660	SALAZAR	54660	18	\N	\N	\N
54670	SAN CALIXTO	54670	18	\N	\N	\N
54673	SAN CAYETANO	54673	18	\N	\N	\N
54680	SANTIAGO	54680	18	\N	\N	\N
54720	SARDINATA	54720	18	\N	\N	\N
54743	SILOS	54743	18	\N	\N	\N
54800	TEORAMA	54800	18	\N	\N	\N
54810	TIBÚ	54810	18	\N	\N	\N
54820	TOLEDO	54820	18	\N	\N	\N
54871	VILLA CARO	54871	18	\N	\N	\N
54874	VILLA DEL ROSARIO	54874	18	\N	\N	\N
63001	ARMENIA	63001	19	\N	\N	\N
63111	BUENAVISTA	63111	19	\N	\N	\N
63130	CALARCÁ	63130	19	\N	\N	\N
63190	CIRCASIA	63190	19	\N	\N	\N
63212	CÓRDOBA	63212	19	\N	\N	\N
63272	FILANDIA	63272	19	\N	\N	\N
63302	GÉNOVA	63302	19	\N	\N	\N
63401	LA TEBAIDA	63401	19	\N	\N	\N
63470	MONTENEGRO	63470	19	\N	\N	\N
63548	PIJAO	63548	19	\N	\N	\N
63594	QUIMBAYA	63594	19	\N	\N	\N
63690	SALENTO	63690	19	\N	\N	\N
66001	PEREIRA	66001	20	\N	\N	\N
66045	APÍA	66045	20	\N	\N	\N
66075	BALBOA	66075	20	\N	\N	\N
66088	BELÉN DE UMBRÍA	66088	20	\N	\N	\N
66170	DOSQUEBRADAS	66170	20	\N	\N	\N
66318	GUÁTICA	66318	20	\N	\N	\N
66383	LA CELIA	66383	20	\N	\N	\N
66400	LA VIRGINIA	66400	20	\N	\N	\N
66440	MARSELLA	66440	20	\N	\N	\N
66456	MISTRATÓ	66456	20	\N	\N	\N
66572	PUEBLO RICO	66572	20	\N	\N	\N
66594	QUINCHÍA	66594	20	\N	\N	\N
66682	SANTA ROSA DE CABAL	66682	20	\N	\N	\N
66687	SANTUARIO	66687	20	\N	\N	\N
68001	BUCARAMANGA	68001	21	\N	\N	\N
68013	AGUADA	68013	21	\N	\N	\N
68020	ALBANIA	68020	21	\N	\N	\N
68051	ARATOCA	68051	21	\N	\N	\N
68077	BARBOSA	68077	21	\N	\N	\N
68079	BARICHARA	68079	21	\N	\N	\N
68081	BARRANCABERMEJA	68081	21	\N	\N	\N
68092	BETULIA	68092	21	\N	\N	\N
68101	BOLÍVAR	68101	21	\N	\N	\N
68121	CABRERA	68121	21	\N	\N	\N
68132	CALIFORNIA	68132	21	\N	\N	\N
68147	CAPITANEJO	68147	21	\N	\N	\N
68152	CARCASÍ	68152	21	\N	\N	\N
68160	CEPITÁ	68160	21	\N	\N	\N
68162	CERRITO	68162	21	\N	\N	\N
68167	CHARALÁ	68167	21	\N	\N	\N
68169	CHARTA	68169	21	\N	\N	\N
68176	CHIMA	68176	21	\N	\N	\N
68179	CHIPATÁ	68179	21	\N	\N	\N
68190	CIMITARRA	68190	21	\N	\N	\N
68207	CONCEPCIÓN	68207	21	\N	\N	\N
68209	CONFINES	68209	21	\N	\N	\N
68211	CONTRATACIÓN	68211	21	\N	\N	\N
68217	COROMORO	68217	21	\N	\N	\N
68229	CURITÍ	68229	21	\N	\N	\N
68235	EL CARMEN DE CHUCURI	68235	21	\N	\N	\N
68245	EL GUACAMAYO	68245	21	\N	\N	\N
68250	EL PEÑÓN	68250	21	\N	\N	\N
68255	EL PLAYÓN	68255	21	\N	\N	\N
68264	ENCINO	68264	21	\N	\N	\N
68266	ENCISO	68266	21	\N	\N	\N
68271	FLORIÁN	68271	21	\N	\N	\N
68276	FLORIDABLANCA	68276	21	\N	\N	\N
68296	GALÁN	68296	21	\N	\N	\N
68298	GÁMBITA	68298	21	\N	\N	\N
68307	GIRÓN	68307	21	\N	\N	\N
68318	GUACA	68318	21	\N	\N	\N
68320	GUADALUPE	68320	21	\N	\N	\N
68322	GUAPOTÁ	68322	21	\N	\N	\N
68324	GUAVATÁ	68324	21	\N	\N	\N
68327	GÜEPSA	68327	21	\N	\N	\N
68344	HATO	68344	21	\N	\N	\N
68368	JESÚS MARÍA	68368	21	\N	\N	\N
68370	JORDÁN	68370	21	\N	\N	\N
68377	LA BELLEZA	68377	21	\N	\N	\N
68385	LANDÁZURI	68385	21	\N	\N	\N
68397	LA PAZ	68397	21	\N	\N	\N
68406	LEBRIJA	68406	21	\N	\N	\N
68418	LOS SANTOS	68418	21	\N	\N	\N
68425	MACARAVITA	68425	21	\N	\N	\N
68432	MÁLAGA	68432	21	\N	\N	\N
68444	MATANZA	68444	21	\N	\N	\N
68464	MOGOTES	68464	21	\N	\N	\N
68468	MOLAGAVITA	68468	21	\N	\N	\N
68498	OCAMONTE	68498	21	\N	\N	\N
68500	OIBA	68500	21	\N	\N	\N
68502	ONZAGA	68502	21	\N	\N	\N
68522	PALMAR	68522	21	\N	\N	\N
68524	PALMAS DEL SOCORRO	68524	21	\N	\N	\N
68533	PÁRAMO	68533	21	\N	\N	\N
68547	PIEDECUESTA	68547	21	\N	\N	\N
68549	PINCHOTE	68549	21	\N	\N	\N
68572	PUENTE NACIONAL	68572	21	\N	\N	\N
68573	PUERTO PARRA	68573	21	\N	\N	\N
68575	PUERTO WILCHES	68575	21	\N	\N	\N
68615	RIONEGRO	68615	21	\N	\N	\N
68655	SABANA DE TORRES	68655	21	\N	\N	\N
68669	SAN ANDRÉS	68669	21	\N	\N	\N
68673	SAN BENITO	68673	21	\N	\N	\N
68679	SAN GIL	68679	21	\N	\N	\N
68682	SAN JOAQUÍN	68682	21	\N	\N	\N
68684	SAN JOSÉ DE MIRANDA	68684	21	\N	\N	\N
68686	SAN MIGUEL	68686	21	\N	\N	\N
68689	SAN VICENTE DE CHUCURÍ	68689	21	\N	\N	\N
68705	SANTA BÁRBARA	68705	21	\N	\N	\N
68720	SANTA HELENA DEL OPÓN	68720	21	\N	\N	\N
68745	SIMACOTA	68745	21	\N	\N	\N
68755	SOCORRO	68755	21	\N	\N	\N
68770	SUAITA	68770	21	\N	\N	\N
68773	SUCRE	68773	21	\N	\N	\N
68780	SURATÁ	68780	21	\N	\N	\N
68820	TONA	68820	21	\N	\N	\N
68855	VALLE DE SAN JOSÉ	68855	21	\N	\N	\N
68861	VÉLEZ	68861	21	\N	\N	\N
68867	VETAS	68867	21	\N	\N	\N
68872	VILLANUEVA	68872	21	\N	\N	\N
68895	ZAPATOCA	68895	21	\N	\N	\N
70001	SINCELEJO	70001	22	\N	\N	\N
70110	BUENAVISTA	70110	22	\N	\N	\N
70124	CAIMITO	70124	22	\N	\N	\N
70204	COLOSÓ	70204	22	\N	\N	\N
70215	COROZAL	70215	22	\N	\N	\N
70221	COVEÑAS	70221	22	\N	\N	\N
70230	CHALÁN	70230	22	\N	\N	\N
70233	EL ROBLE	70233	22	\N	\N	\N
70235	GALERAS	70235	22	\N	\N	\N
70265	GUARANDA	70265	22	\N	\N	\N
70400	LA UNIÓN	70400	22	\N	\N	\N
70418	LOS PALMITOS	70418	22	\N	\N	\N
70429	MAJAGUAL	70429	22	\N	\N	\N
70473	MORROA	70473	22	\N	\N	\N
70508	OVEJAS	70508	22	\N	\N	\N
70523	PALMITO	70523	22	\N	\N	\N
70670	SAMPUÉS	70670	22	\N	\N	\N
70678	SAN BENITO ABAD	70678	22	\N	\N	\N
70702	SAN JUAN DE BETULIA	70702	22	\N	\N	\N
70708	SAN MARCOS	70708	22	\N	\N	\N
70713	SAN ONOFRE	70713	22	\N	\N	\N
70717	SAN PEDRO	70717	22	\N	\N	\N
70742	SAN LUIS DE SINCÉ	70742	22	\N	\N	\N
70771	SUCRE	70771	22	\N	\N	\N
70820	SANTIAGO DE TOLÚ	70820	22	\N	\N	\N
70823	SAN JOSÉ DE TOLUVIEJO	70823	22	\N	\N	\N
73001	IBAGUÉ	73001	23	\N	\N	\N
73024	ALPUJARRA	73024	23	\N	\N	\N
73026	ALVARADO	73026	23	\N	\N	\N
73030	AMBALEMA	73030	23	\N	\N	\N
73043	ANZOÁTEGUI	73043	23	\N	\N	\N
73055	ARMERO	73055	23	\N	\N	\N
73067	ATACO	73067	23	\N	\N	\N
73124	CAJAMARCA	73124	23	\N	\N	\N
73148	CARMEN DE APICALÁ	73148	23	\N	\N	\N
73152	CASABIANCA	73152	23	\N	\N	\N
73168	CHAPARRAL	73168	23	\N	\N	\N
73200	COELLO	73200	23	\N	\N	\N
73217	COYAIMA	73217	23	\N	\N	\N
73226	CUNDAY	73226	23	\N	\N	\N
73236	DOLORES	73236	23	\N	\N	\N
73268	ESPINAL	73268	23	\N	\N	\N
73270	FALAN	73270	23	\N	\N	\N
73275	FLANDES	73275	23	\N	\N	\N
73283	FRESNO	73283	23	\N	\N	\N
73319	GUAMO	73319	23	\N	\N	\N
73347	HERVEO	73347	23	\N	\N	\N
73349	HONDA	73349	23	\N	\N	\N
73352	ICONONZO	73352	23	\N	\N	\N
73408	LÉRIDA	73408	23	\N	\N	\N
73411	LÍBANO	73411	23	\N	\N	\N
73443	SAN SEBASTIÁN DE MARIQUITA	73443	23	\N	\N	\N
73449	MELGAR	73449	23	\N	\N	\N
73461	MURILLO	73461	23	\N	\N	\N
73483	NATAGAIMA	73483	23	\N	\N	\N
73504	ORTEGA	73504	23	\N	\N	\N
73520	PALOCABILDO	73520	23	\N	\N	\N
73547	PIEDRAS	73547	23	\N	\N	\N
73555	PLANADAS	73555	23	\N	\N	\N
73563	PRADO	73563	23	\N	\N	\N
73585	PURIFICACIÓN	73585	23	\N	\N	\N
73616	RIOBLANCO	73616	23	\N	\N	\N
73622	RONCESVALLES	73622	23	\N	\N	\N
73624	ROVIRA	73624	23	\N	\N	\N
73671	SALDAÑA	73671	23	\N	\N	\N
73675	SAN ANTONIO	73675	23	\N	\N	\N
73678	SAN LUIS	73678	23	\N	\N	\N
73686	SANTA ISABEL	73686	23	\N	\N	\N
73770	SUÁREZ	73770	23	\N	\N	\N
73854	VALLE DE SAN JUAN	73854	23	\N	\N	\N
73861	VENADILLO	73861	23	\N	\N	\N
73870	VILLAHERMOSA	73870	23	\N	\N	\N
73873	VILLARRICA	73873	23	\N	\N	\N
76001	CALI	76001	24	\N	\N	\N
76020	ALCALÁ	76020	24	\N	\N	\N
76036	ANDALUCÍA	76036	24	\N	\N	\N
76041	ANSERMANUEVO	76041	24	\N	\N	\N
76054	ARGELIA	76054	24	\N	\N	\N
76100	BOLÍVAR	76100	24	\N	\N	\N
76109	BUENAVENTURA	76109	24	\N	\N	\N
76111	GUADALAJARA DE BUGA	76111	24	\N	\N	\N
76113	BUGALAGRANDE	76113	24	\N	\N	\N
76122	CAICEDONIA	76122	24	\N	\N	\N
76126	CALIMA	76126	24	\N	\N	\N
76130	CANDELARIA	76130	24	\N	\N	\N
76147	CARTAGO	76147	24	\N	\N	\N
76233	DAGUA	76233	24	\N	\N	\N
76243	EL ÁGUILA	76243	24	\N	\N	\N
76246	EL CAIRO	76246	24	\N	\N	\N
76248	EL CERRITO	76248	24	\N	\N	\N
76250	EL DOVIO	76250	24	\N	\N	\N
76275	FLORIDA	76275	24	\N	\N	\N
76306	GINEBRA	76306	24	\N	\N	\N
76318	GUACARÍ	76318	24	\N	\N	\N
76364	JAMUNDÍ	76364	24	\N	\N	\N
76377	LA CUMBRE	76377	24	\N	\N	\N
76400	LA UNIÓN	76400	24	\N	\N	\N
76403	LA VICTORIA	76403	24	\N	\N	\N
76497	OBANDO	76497	24	\N	\N	\N
76520	PALMIRA	76520	24	\N	\N	\N
76563	PRADERA	76563	24	\N	\N	\N
76606	RESTREPO	76606	24	\N	\N	\N
76616	RIOFRÍO	76616	24	\N	\N	\N
76622	ROLDANILLO	76622	24	\N	\N	\N
76670	SAN PEDRO	76670	24	\N	\N	\N
76736	SEVILLA	76736	24	\N	\N	\N
76823	TORO	76823	24	\N	\N	\N
76828	TRUJILLO	76828	24	\N	\N	\N
76834	TULUÁ	76834	24	\N	\N	\N
76845	ULLOA	76845	24	\N	\N	\N
76863	VERSALLES	76863	24	\N	\N	\N
76869	VIJES	76869	24	\N	\N	\N
76890	YOTOCO	76890	24	\N	\N	\N
76892	YUMBO	76892	24	\N	\N	\N
76895	ZARZAL	76895	24	\N	\N	\N
81001	ARAUCA	81001	25	\N	\N	\N
81065	ARAUQUITA	81065	25	\N	\N	\N
81220	CRAVO NORTE	81220	25	\N	\N	\N
81300	FORTUL	81300	25	\N	\N	\N
81591	PUERTO RONDÓN	81591	25	\N	\N	\N
81736	SARAVENA	81736	25	\N	\N	\N
81794	TAME	81794	25	\N	\N	\N
85001	YOPAL	85001	26	\N	\N	\N
85010	AGUAZUL	85010	26	\N	\N	\N
85015	CHÁMEZA	85015	26	\N	\N	\N
85125	HATO COROZAL	85125	26	\N	\N	\N
85136	LA SALINA	85136	26	\N	\N	\N
85139	MANÍ	85139	26	\N	\N	\N
85162	MONTERREY	85162	26	\N	\N	\N
85225	NUNCHÍA	85225	26	\N	\N	\N
85230	OROCUÉ	85230	26	\N	\N	\N
85250	PAZ DE ARIPORO	85250	26	\N	\N	\N
85263	PORE	85263	26	\N	\N	\N
85279	RECETOR	85279	26	\N	\N	\N
85300	SABANALARGA	85300	26	\N	\N	\N
85315	SÁCAMA	85315	26	\N	\N	\N
85325	SAN LUIS DE PALENQUE	85325	26	\N	\N	\N
85400	TÁMARA	85400	26	\N	\N	\N
85410	TAURAMENA	85410	26	\N	\N	\N
85430	TRINIDAD	85430	26	\N	\N	\N
85440	VILLANUEVA	85440	26	\N	\N	\N
86001	MOCOA	86001	27	\N	\N	\N
86219	COLÓN	86219	27	\N	\N	\N
86320	ORITO	86320	27	\N	\N	\N
86568	PUERTO ASÍS	86568	27	\N	\N	\N
86569	PUERTO CAICEDO	86569	27	\N	\N	\N
86571	PUERTO GUZMÁN	86571	27	\N	\N	\N
86573	PUERTO LEGUÍZAMO	86573	27	\N	\N	\N
86749	SIBUNDOY	86749	27	\N	\N	\N
86755	SAN FRANCISCO	86755	27	\N	\N	\N
86757	SAN MIGUEL	86757	27	\N	\N	\N
86760	SANTIAGO	86760	27	\N	\N	\N
86865	VALLE DEL GUAMUEZ	86865	27	\N	\N	\N
86885	VILLAGARZÓN	86885	27	\N	\N	\N
88001	SAN ANDRÉS	88001	28	\N	\N	\N
88564	PROVIDENCIA	88564	28	\N	\N	\N
91001	LETICIA	91001	29	\N	\N	\N
91263	EL ENCANTO	91263	29	\N	\N	\N
91405	LA CHORRERA	91405	29	\N	\N	\N
91407	LA PEDRERA	91407	29	\N	\N	\N
91430	LA VICTORIA	91430	29	\N	\N	\N
91460	MIRITÍ - PARANÁ	91460	29	\N	\N	\N
91530	PUERTO ALEGRÍA	91530	29	\N	\N	\N
91536	PUERTO ARICA	91536	29	\N	\N	\N
91540	PUERTO NARIÑO	91540	29	\N	\N	\N
91669	PUERTO SANTANDER	91669	29	\N	\N	\N
91798	TARAPACÁ	91798	29	\N	\N	\N
94001	INÍRIDA	94001	30	\N	\N	\N
94343	BARRANCOMINAS	94343	30	\N	\N	\N
94883	SAN FELIPE	94883	30	\N	\N	\N
94884	PUERTO COLOMBIA	94884	30	\N	\N	\N
94885	LA GUADALUPE	94885	30	\N	\N	\N
94886	CACAHUAL	94886	30	\N	\N	\N
94887	PANA PANA	94887	30	\N	\N	\N
94888	MORICHAL	94888	30	\N	\N	\N
95001	SAN JOSÉ DEL GUAVIARE	95001	31	\N	\N	\N
95015	CALAMAR	95015	31	\N	\N	\N
95025	EL RETORNO	95025	31	\N	\N	\N
95200	MIRAFLORES	95200	31	\N	\N	\N
97001	MITÚ	97001	32	\N	\N	\N
97161	CARURÚ	97161	32	\N	\N	\N
97511	PACOA	97511	32	\N	\N	\N
97666	TARAIRA	97666	32	\N	\N	\N
97777	PAPUNAHUA	97777	32	\N	\N	\N
97889	YAVARATÉ	97889	32	\N	\N	\N
99001	PUERTO CARREÑO	99001	33	\N	\N	\N
99524	LA PRIMAVERA	99524	33	\N	\N	\N
99624	SANTA ROSALÍA	99624	33	\N	\N	\N
99773	CUMARIBO	99773	33	\N	\N	\N
\.


                                      2981.dat                                                                                            0000600 0004000 0002000 00000000506 14261170735 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	María Angélica Cótamo Vesga	1	1111112	50223	1	CC-1111112	$2y$10$aEJZNmdCRGZheGZtbkw0Redc7jYXClDhM0YmglLcInJqktuO2hISy	0	privado	\N	2022-07-06 01:39:48.035766	\N
1	Santiago Hernández	1	80503561	11001	2	CC-80503561	$2y$10$SlRidkExMW5hbWRuL1p6UO76XFAM3mNAz0g6lO0lUChwdjw1Tyy3G	0	admin	\N	2022-07-06 01:40:52.959577	\N
\.


                                                                                                                                                                                          2976.dat                                                                                            0000600 0004000 0002000 00000000056 14261170735 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Femenino	\N	\N	\N
2	Masculino	\N	\N	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  2977.dat                                                                                            0000600 0004000 0002000 00000000220 14261170735 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Cédula de Ciudadanía	CC	\N	\N	\N
2	Tarjeta de Identidad	TI	\N	\N	\N
3	Registro Civil	RC	\N	\N	\N
4	Cédula de Extranjería	CE	\N	\N	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                restore.sql                                                                                         0000600 0004000 0002000 00000026417 14261170735 0015404 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE empresa;
--
-- Name: empresa; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE empresa WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE empresa OWNER TO postgres;

\connect empresa

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: roles; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.roles AS ENUM (
    'publico',
    'privado',
    'admin'
);


ALTER TYPE public.roles OWNER TO postgres;

--
-- Name: establecer_fecha_creacion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.establecer_fecha_creacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.creacion := CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.establecer_fecha_creacion() OWNER TO postgres;

--
-- Name: establecer_fecha_modificacion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.establecer_fecha_modificacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.modificacion := CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.establecer_fecha_modificacion() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: departamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamento (
    id integer NOT NULL,
    nombre character varying(255),
    codigo character varying(255),
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);


ALTER TABLE public.departamento OWNER TO postgres;

--
-- Name: municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipio (
    id integer NOT NULL,
    nombre character varying(255),
    codigo character varying(255),
    id_departamento integer NOT NULL,
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);


ALTER TABLE public.municipio OWNER TO postgres;

--
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    id integer NOT NULL,
    nombre character varying(255),
    id_tipo_documento integer NOT NULL,
    numero_documento character varying(255) NOT NULL,
    id_municipio integer NOT NULL,
    id_sexo integer NOT NULL,
    usuario character varying(255) NOT NULL,
    clave character varying(255) NOT NULL,
    eliminado integer,
    rol public.roles,
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- Name: persona_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.persona_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.persona_id_seq OWNER TO postgres;

--
-- Name: persona_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.persona_id_seq OWNED BY public.persona.id;


--
-- Name: sexo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sexo (
    id integer NOT NULL,
    nombre character varying(255),
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);


ALTER TABLE public.sexo OWNER TO postgres;

--
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_documento (
    id integer NOT NULL,
    nombre character varying(255),
    abreviatura character varying(255) NOT NULL,
    creacion timestamp without time zone,
    modificacion timestamp without time zone,
    eliminacion timestamp without time zone
);


ALTER TABLE public.tipo_documento OWNER TO postgres;

--
-- Name: persona id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona ALTER COLUMN id SET DEFAULT nextval('public.persona_id_seq'::regclass);


--
-- Data for Name: departamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departamento (id, nombre, codigo, creacion, modificacion, eliminacion) FROM stdin;
\.
COPY public.departamento (id, nombre, codigo, creacion, modificacion, eliminacion) FROM '$$PATH$$/2978.dat';

--
-- Data for Name: municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.municipio (id, nombre, codigo, id_departamento, creacion, modificacion, eliminacion) FROM stdin;
\.
COPY public.municipio (id, nombre, codigo, id_departamento, creacion, modificacion, eliminacion) FROM '$$PATH$$/2979.dat';

--
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persona (id, nombre, id_tipo_documento, numero_documento, id_municipio, id_sexo, usuario, clave, eliminado, rol, creacion, modificacion, eliminacion) FROM stdin;
\.
COPY public.persona (id, nombre, id_tipo_documento, numero_documento, id_municipio, id_sexo, usuario, clave, eliminado, rol, creacion, modificacion, eliminacion) FROM '$$PATH$$/2981.dat';

--
-- Data for Name: sexo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sexo (id, nombre, creacion, modificacion, eliminacion) FROM stdin;
\.
COPY public.sexo (id, nombre, creacion, modificacion, eliminacion) FROM '$$PATH$$/2976.dat';

--
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_documento (id, nombre, abreviatura, creacion, modificacion, eliminacion) FROM stdin;
\.
COPY public.tipo_documento (id, nombre, abreviatura, creacion, modificacion, eliminacion) FROM '$$PATH$$/2977.dat';

--
-- Name: persona_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.persona_id_seq', 8, true);


--
-- Name: departamento departamento_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_codigo_key UNIQUE (codigo);


--
-- Name: departamento departamento_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_nombre_key UNIQUE (nombre);


--
-- Name: departamento departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamento
    ADD CONSTRAINT departamento_pkey PRIMARY KEY (id);


--
-- Name: municipio municipio_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT municipio_codigo_key UNIQUE (codigo);


--
-- Name: municipio municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT municipio_pkey PRIMARY KEY (id);


--
-- Name: persona persona_nombre_completo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_nombre_completo_key UNIQUE (nombre);


--
-- Name: persona persona_numero_documento_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_numero_documento_key UNIQUE (numero_documento);


--
-- Name: persona persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (id);


--
-- Name: sexo sexo_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexo
    ADD CONSTRAINT sexo_nombre_key UNIQUE (nombre);


--
-- Name: sexo sexo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexo
    ADD CONSTRAINT sexo_pkey PRIMARY KEY (id);


--
-- Name: tipo_documento tipo_documento_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT tipo_documento_nombre_key UNIQUE (nombre);


--
-- Name: tipo_documento tipo_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT tipo_documento_pkey PRIMARY KEY (id);


--
-- Name: persona trg_establecer_fecha_creacion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_establecer_fecha_creacion BEFORE INSERT ON public.persona FOR EACH ROW EXECUTE FUNCTION public.establecer_fecha_creacion();


--
-- Name: persona trg_establecer_fecha_modificacion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_establecer_fecha_modificacion BEFORE UPDATE ON public.persona FOR EACH ROW EXECUTE FUNCTION public.establecer_fecha_modificacion();


--
-- Name: municipio fk_municipio__departamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT fk_municipio__departamento FOREIGN KEY (id_departamento) REFERENCES public.departamento(id);


--
-- Name: persona fk_persona__municipio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_persona__municipio FOREIGN KEY (id_municipio) REFERENCES public.municipio(id);


--
-- Name: DATABASE empresa; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE empresa TO empresauser;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA public TO empresauser;


--
-- Name: FUNCTION establecer_fecha_creacion(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.establecer_fecha_creacion() TO empresauser;


--
-- Name: FUNCTION establecer_fecha_modificacion(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.establecer_fecha_modificacion() TO empresauser;


--
-- Name: TABLE departamento; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.departamento TO empresauser;


--
-- Name: TABLE municipio; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.municipio TO empresauser;


--
-- Name: TABLE persona; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.persona TO empresauser;


--
-- Name: SEQUENCE persona_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.persona_id_seq TO empresauser;


--
-- Name: TABLE sexo; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sexo TO empresauser;


--
-- Name: TABLE tipo_documento; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tipo_documento TO empresauser;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 