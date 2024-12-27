--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_table_access_method = heap;

--
-- Name: records; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.records (
    username character varying(22) NOT NULL,
    games_played integer NOT NULL,
    best_game character varying
);


ALTER TABLE public.records OWNER TO freecodecamp;

--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.records VALUES ('user_1735323561234', 1, '580');
INSERT INTO public.records VALUES ('user_1735323561233', 1, '615');
INSERT INTO public.records VALUES ('gg', 1, '13');
INSERT INTO public.records VALUES ('user_1735324691776', 2, '456');
INSERT INTO public.records VALUES ('user_1735324691777', 5, '87');
INSERT INTO public.records VALUES ('user_1735324742572', 2, '530');
INSERT INTO public.records VALUES ('user_1735324742573', 5, '738');
INSERT INTO public.records VALUES ('user_1735324865264', 2, '235');
INSERT INTO public.records VALUES ('user_1735324865265', 5, '98');
INSERT INTO public.records VALUES ('user_1735325376603', 2, '65');
INSERT INTO public.records VALUES ('user_1735325376604', 5, '55');
INSERT INTO public.records VALUES ('user_1735325585488', 2, '426');
INSERT INTO public.records VALUES ('user_1735325585489', 5, '106');
INSERT INTO public.records VALUES ('user_1735325700642', 2, '63');
INSERT INTO public.records VALUES ('user_1735325700643', 5, '251');


--
-- PostgreSQL database dump complete
--

