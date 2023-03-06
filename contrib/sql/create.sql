--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Debian 14.6-1.pgdg110+1)
-- Dumped by pg_dump version 14.6 (Debian 14.6-1.pgdg110+1)

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
-- Name: line_item; Type: TABLE; Schema: public; Owner: $POSTGRESQL_USER
--

CREATE TABLE public.line_item (
    id bigint NOT NULL,
    price numeric(8,2),
    product_code character varying(30),
    quantity integer,
    order_id bigint
);


ALTER TABLE public.line_item OWNER TO $POSTGRESQL_USER;

--
-- Name: line_item_id_seq; Type: SEQUENCE; Schema: public; Owner: $POSTGRESQL_USER
--

CREATE SEQUENCE public.line_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.line_item_id_seq OWNER TO $POSTGRESQL_USER;


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: $POSTGRESQL_USER
--

CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO $POSTGRESQL_USER;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: $POSTGRESQL_USER
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    customer_id character varying(30),
    order_ts timestamp without time zone
);


ALTER TABLE public.orders OWNER TO $POSTGRESQL_USER;
--
-- Name: shipping_address; Type: TABLE; Schema: public; Owner: $POSTGRESQL_USER
--

CREATE TABLE public.shipping_address (
    id bigint NOT NULL,
    address1 character varying(100),
    address2 character varying(100),
    city character varying(50),
    country character varying(30),
    name character varying(100),
    phone character varying(30),
    state character varying(30),
    zip character varying(30),
    order_id bigint
);


ALTER TABLE public.shipping_address OWNER TO $POSTGRESQL_USER;

--
-- Name: shipping_address_id_seq; Type: SEQUENCE; Schema: public; Owner: $POSTGRESQL_USER
--

CREATE SEQUENCE public.shipping_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_address_id_seq OWNER TO $POSTGRESQL_USER;

--
-- Name: line_item line_item_pkey; Type: CONSTRAINT; Schema: public; Owner: $POSTGRESQL_USER
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT line_item_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: $POSTGRESQL_USER
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: shipping_address shipping_address_pkey; Type: CONSTRAINT; Schema: public; Owner: $POSTGRESQL_USER
--

ALTER TABLE ONLY public.shipping_address
    ADD CONSTRAINT shipping_address_pkey PRIMARY KEY (id);


--
-- Name: shipping_address fkl88fq4d2ypn9qvg8x90uimnca; Type: FK CONSTRAINT; Schema: public; Owner: $POSTGRESQL_USER
--

ALTER TABLE ONLY public.shipping_address
    ADD CONSTRAINT fkl88fq4d2ypn9qvg8x90uimnca FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: line_item fklfuo9o3keu9a7mlxumaqoylgu; Type: FK CONSTRAINT; Schema: public; Owner: $POSTGRESQL_USER
--

ALTER TABLE ONLY public.line_item
    ADD CONSTRAINT fklfuo9o3keu9a7mlxumaqoylgu FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- PostgreSQL database dump complete
--

