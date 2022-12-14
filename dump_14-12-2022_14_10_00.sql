--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE law_advisor_dev;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md53175bce1d3201d16594cebf9d7eb3f9d';






--
-- PostgreSQL database dump
--

-- Dumped from database version 11.18
-- Dumped by pg_dump version 11.18

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.18
-- Dumped by pg_dump version 11.18

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
-- Name: law_advisor_dev; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE law_advisor_dev WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE law_advisor_dev OWNER TO postgres;

\connect law_advisor_dev

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    content character varying(255) NOT NULL,
    task_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO postgres;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: lists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lists (
    id bigint NOT NULL,
    title character varying(255),
    "position" double precision,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.lists OWNER TO postgres;

--
-- Name: lists_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lists_id_seq OWNER TO postgres;

--
-- Name: lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lists_id_seq OWNED BY public.lists.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255),
    assigned_person character varying(255),
    list_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    "position" double precision
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission integer NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.user_permissions OWNER TO postgres;

--
-- Name: user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_permissions_id_seq OWNER TO postgres;

--
-- Name: user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_permissions_id_seq OWNED BY public.user_permissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: lists id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lists ALTER COLUMN id SET DEFAULT nextval('public.lists_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions ALTER COLUMN id SET DEFAULT nextval('public.user_permissions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, content, task_id, inserted_at, updated_at) FROM stdin;
2	This is my first comment working on this feature	10	2022-12-04 08:31:53	2022-12-04 08:31:53
3	2nd comment!	10	2022-12-04 13:22:23	2022-12-04 13:22:23
4	currently working on this feature	10	2022-12-04 13:32:38	2022-12-04 13:32:38
5	this will be used for the authentication module	2	2022-12-04 13:40:49	2022-12-04 13:40:49
6	auth test	2	2022-12-04 13:53:34	2022-12-04 13:53:34
7	test comment	2	2022-12-04 14:04:01	2022-12-04 14:04:01
8	this is also complementary with User module	3	2022-12-04 14:06:08	2022-12-04 14:06:08
9	having unit tests would make the refactoring safer	20	2022-12-04 14:15:49	2022-12-04 14:15:49
10	we'd notice if some changes breaks the features	20	2022-12-04 14:17:36	2022-12-04 14:17:36
11	it seems comment is now working	20	2022-12-04 14:17:57	2022-12-04 14:17:57
12	clear input test	20	2022-12-04 14:36:01	2022-12-04 14:36:01
13	checking if input is cleared	20	2022-12-04 14:38:21	2022-12-04 14:38:21
14	Both are complementary for building the Auth module	3	2022-12-04 14:38:56	2022-12-04 14:38:56
15	can now edit task	27	2022-12-04 14:41:17	2022-12-04 14:41:17
64	slfkdasflksdjf	10	2022-12-05 10:24:46	2022-12-05 10:24:46
65	test comment	24	2022-12-12 07:49:25	2022-12-12 07:49:25
52	checking if input still works	20	2022-12-05 09:09:56	2022-12-05 09:09:56
\.


--
-- Data for Name: lists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lists (id, title, "position", inserted_at, updated_at) FROM stdin;
1	Backlog	1669254661.16019893	2022-11-23 10:35:24	2022-12-05 09:47:03
50	DONE	1669900644	2022-12-01 13:19:04	2022-12-05 09:47:14
225	Done Protecting Following Routes	1669900694	2022-12-12 05:52:03	2022-12-12 13:32:37
227	Done Enforcing Policies for the following	1669900594	2022-12-13 00:07:26	2022-12-13 00:08:49
42	In Progress	1669900594	2022-12-01 11:48:54	2022-12-13 00:19:14
226	Goal for each Day	1669254561.16019893	2022-12-12 06:05:51	2022-12-13 00:37:56
2	TODO	1669900544	2022-11-24 01:58:31	2022-12-13 00:44:20
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20221123055156	2022-11-23 06:28:01
20221123092834	2022-11-23 06:28:01
20221129054055	2022-11-29 05:44:58
20221204064048	2022-12-04 06:53:17
20221206044131	2022-12-06 04:45:40
20221207062647	2022-12-07 06:30:56
20221213052136	2022-12-13 05:32:40
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, title, description, assigned_person, list_id, inserted_at, updated_at, "position") FROM stdin;
81	[MOCKUP] Register User Page	fields: username, email, password	kriz	50	2022-12-06 04:13:20	2022-12-07 12:17:02	1669901422060.875
97	Reorder Task/Move Task to different List	when calling update task API, Bearer access token is required	kriz	225	2022-12-12 08:55:50	2022-12-12 08:55:50	1670835350518
75	[MOCKUP] Login Page	has email and password input fields, has Register link nav below	kriz	50	2022-12-06 03:39:41	2022-12-08 05:39:25	1669901422010.875
21	[LIST] Create a list	Click "Add another list" which is on the right-most side of the Lists, then a new empty List is created	kriz	50	2022-12-01 13:30:22	2022-12-02 08:50:44	1669901504273.5
77	[MOCKUP] Index page after login	username on upper right, board name, boards and permissions button on upper left	kriz	42	2022-12-06 03:47:17	2022-12-08 05:39:40	1670477980244
98	[AUTH-Z] User w/ READ permission not allowed to Create List	"Add another list" button should be hidden	kriz	227	2022-12-12 13:47:06	2022-12-13 00:08:55	1670890123083
3	[BOARD] Implement Board context	Once a user creates a board it becomes an owner and it gets the manage role.  User with manage permission will be able to invite other users and assign on the roles	kriz	1	2022-11-23 10:38:04	2022-12-06 03:38:49	1670297927921
28	[TASK] Move a task to different list	Same as normal reorder but is extended to other Lists aside from the current List	kriz	50	2022-12-01 23:49:36	2022-12-05 10:23:17	1669901422301.5
27	[TASK] Change order of tasks	Click and hold the Task then drag to reorder on the List	kriz	50	2022-12-01 13:38:18	2022-12-05 10:23:23	1669901422260.875
10	[TASK] Add a comment for the task	Upon clicking view Task details, we should also be able to input our comment	kriz	50	2022-11-24 11:45:15	2022-12-05 10:23:48	1669901463287.5
83	[API] Login User	pass params email and password	kriz	50	2022-12-12 05:24:09	2022-12-12 05:24:18	1669901422085.875
22	[LIST] Delete a list	At the moment, if the List is empty that is when you can delete the List	kriz	50	2022-12-01 13:33:06	2022-12-05 10:26:39	1669901595685.625
87	Delete List	when calling delete list API, Bearer access token is required	kriz	225	2022-12-12 05:55:55	2022-12-12 08:12:18	1670824555627
24	[TASK] Create a task	Click "Add a card" then input details for new task like Title, Description, and Assigned Person	kriz	50	2022-12-01 13:35:17	2022-12-05 11:11:21	1669901422210.875
84	[API] Logout User	just call API with header set as "Authorization: Bearer #{access_token}"	kriz	50	2022-12-12 05:25:22	2022-12-12 05:25:27	1669901422073.375
72	[Architecture] Docker compose will have 3 containers	(example project provided https://github.com/singularity-is/trello_clone_template):  * Client Phoenix frontend  * API Phoenix backed  * Database PostgreSQL	kriz	50	2022-12-05 09:49:56	2022-12-06 03:38:26	1669901422160.875
78	[MOCKUP] Permissions Modal	username dropdown and permissions dropdown, upon selection added to list below	kriz	2	2022-12-06 03:54:24	2022-12-06 03:54:24	1670298864753
79	[MOCKUP] Comment Modal	view button on card then view is a modal with comment below	kriz	2	2022-12-06 04:06:54	2022-12-06 04:06:54	1670299614773
80	[MOCKUP][REDESIGN] Edit Card Modal	Remove comments below the modal	kriz	2	2022-12-06 04:07:57	2022-12-06 04:07:57	1670299677197
82	[API] Register User	pass params username, email, password	kriz	50	2022-12-06 04:19:10	2022-12-07 10:21:42	1669901422110.875
85	[FEATURE] Logout user after clicking the logout button	Upon click, following are deleted from session: username, access token. Then, delete session API is called	kriz	50	2022-12-12 05:27:49	2022-12-12 05:28:05	1669901421960.875
88	Create List	when calling create list API, Bearer access token is required	kriz	225	2022-12-12 05:56:28	2022-12-12 05:56:28	1670824588645
89	Dec 12	Finish protected routes, start permissions API	kriz	226	2022-12-12 06:07:34	2022-12-12 06:07:34	1670825254229
95	Update Task	when calling update task API, Bearer access token is required	kriz	225	2022-12-12 08:15:27	2022-12-12 08:15:27	1670832927052
90	Edit List Title	when calling update list API, Bearer access token is required	kriz	225	2022-12-12 06:22:08	2022-12-12 06:22:08	1670826128063
91	Change Order of Lists	when calling update list API, Bearer access token is required	kriz	225	2022-12-12 07:35:13	2022-12-12 07:35:13	1670830513531
92	Get comments and Add comment	when calling get/add comments API, Bearer access token is required", "title" => "Get comments and Add comment	kriz	225	2022-12-12 07:55:12	2022-12-12 07:55:12	1670831712079
93	Create a Task	when calling create task API, Bearer access token is required	kriz	225	2022-12-12 07:57:30	2022-12-12 07:57:30	1670831850281
96	Delete Task	when calling delete task API, Bearer access token is required	kriz	225	2022-12-12 08:15:43	2022-12-12 08:15:43	1670832943271
86	[AUTH-N] Protect all routes except login and register user	when accessing covered routes, user should be authenticated to proceed	kriz	50	2022-12-12 05:29:51	2022-12-12 13:44:16	1669901421910.875
100	[AUTH-Z] User w/ READ permission not allowed to Edit List Title	Title should not be editable	kriz	227	2022-12-12 14:28:51	2022-12-13 00:40:15	1670890122983
2	[USER] Implement User context	All users of the system have to  be registered and authenticated to be able to use the system. Email will be used as a username.	kriz	1	2022-11-23 10:37:35	2022-12-12 08:50:15	1670297927871
99	[AUTH-Z] User w/ READ permission not allowed to Delete List	Delete List button shall be hidden	kriz	227	2022-12-12 14:21:39	2022-12-13 00:08:43	1670890123033
102	[AUTH-Z] User w/ READ permission not allowed to Change Order of Lists	Lists should not be draggable	kriz	227	2022-12-13 00:41:07	2022-12-13 00:49:26	1670890122933
101	Dec 13	Continue hiding components, disabling features for users w/ READ permissions 	kriz	226	2022-12-13 00:05:04	2022-12-13 00:47:32	1670825254279
20	[UNIT TEST] There must be written unit tests.	Create unit tests especially for features related to business logic like Reorder Task	kriz	2	2022-12-01 13:28:03	2022-12-13 09:06:30	1670298864703
103	[AUTH-Z] User w/ READ permission not allowed to Create Task	"Add a card" button should be hidden	kriz	227	2022-12-13 00:55:30	2022-12-13 01:03:37	1670890122883
105	[AUTH-Z] User w/ READ permission not allowed to Delete Task	Delete Task button should be hidden	kriz	227	2022-12-13 01:03:11	2022-12-13 01:03:41	1670890122858
104	[AUTH-Z] User w/ READ permission not allowed to Edit Task	Edit Task button should be hidden	kriz 	227	2022-12-13 01:02:43	2022-12-13 02:43:22	1670890122808
110	Dec 14	Finish all things permissions	kriz	226	2022-12-14 01:57:34	2022-12-14 01:57:42	1670983054125
26	[TASK] Edit task’s title, description, assigned person	Click the edit button, then edit the details in the form	kriz	50	2022-12-01 13:37:18	2022-12-05 09:53:00	1669901422276.5
25	[TASK] Delete a task	Just click the delete button, a prompt will be asked to confirm before deleting	kriz	50	2022-12-01 13:36:20	2022-12-05 09:53:12	1669901422279.625
4	[LIST] Change order of lists	Implement reorder, but for Lists	kriz	50	2022-11-24 02:00:04	2022-12-05 09:53:56	1669901646168
23	[LIST] Edit list title	Just double click the List's title, it would then turn into an editable input field	kriz	50	2022-12-01 13:34:06	2022-12-05 09:54:03	1669901545203.25
106	[AUTH-Z] User w/ READ permission not allowed to Reorder or Move Task	Task should not be draggable	kriz	227	2022-12-13 01:04:22	2022-12-13 02:49:03	1670890122758
107	[AUTH-Z] User w/ READ permission not allowed to Add Comment to Task	Comments section should be hidden	kriz	227	2022-12-13 02:50:05	2022-12-13 03:22:42	1670890122708
108	[AUTH-Z] Create Permissions table that belongs to each User	Each User has many Permissions	kriz	227	2022-12-13 03:29:11	2022-12-13 06:28:04	1670890122658
109	[Feature] Add Users with Permission	Add Permissions button, user selects email w/ corresponding permission to enforce how much said user can access 	kriz	227	2022-12-13 06:34:06	2022-12-14 05:45:53	1670890122608
111	[AUTH-Z] User w/ MANAGE permission is the only one allowed to Share Access to other Users	Share button should be hidden for Users w/ Read or Write Permission	kriz	227	2022-12-14 06:07:25	2022-12-14 06:07:35	1670890122558
\.


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_permissions (id, user_id, permission, inserted_at, updated_at) FROM stdin;
3	3	0	2022-12-13 06:30:20	2022-12-13 06:30:20
4	4	2	2022-12-14 05:40:45	2022-12-14 05:40:45
1	1	2	2022-12-13 05:52:46	2022-12-14 05:43:49
2	2	1	2022-12-13 06:27:23	2022-12-14 05:51:26
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password, inserted_at, updated_at) FROM stdin;
1	kriz	kriz@gmail.com	$2a$12$yxAd08PCXhlvRHqMPTa5V.FOQQaIE0bMfuZ3D5xSL.nQp99eL8sA.	2022-12-07 07:01:03	2022-12-07 07:01:03
2	johndoe	johndoe@gmail.com	$2a$12$CTgx32CxnI28coq.cRRcY.FbNw2Z7wP3/I0sk5uMJVlsdYDf0e7AK	2022-12-07 10:57:47	2022-12-07 10:57:47
3	janedoe	janedoe@gmail.com	$2a$12$aUvRJyBs6KxfKRDaDy/vFelHjJXg2nLQdLt3ESMCJmSL4cULfJFxW	2022-12-07 10:59:06	2022-12-07 10:59:06
4	juandelacruz	juandelacruz@gmail.com	$2a$12$YCUGUWYcOg.Q2km8OTtW7e2mvHtAGlDCVZGRVSG.4YdZxzuU9.3o2	2022-12-07 11:53:14	2022-12-07 11:53:14
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 65, true);


--
-- Name: lists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lists_id_seq', 229, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 111, true);


--
-- Name: user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_permissions_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: lists lists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lists
    ADD CONSTRAINT lists_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_permissions user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: comments_task_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX comments_task_id_index ON public.comments USING btree (task_id);


--
-- Name: user_permissions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_permissions_user_id_index ON public.user_permissions USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: comments comments_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.tasks(id) ON DELETE CASCADE;


--
-- Name: tasks tasks_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.lists(id);


--
-- Name: user_permissions user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.18
-- Dumped by pg_dump version 11.18

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

