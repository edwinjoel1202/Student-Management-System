PGDMP          	            |            student    16.3    16.3 (    1           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            2           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            3           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            4           1262    16591    student    DATABASE     z   CREATE DATABASE student WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
    DROP DATABASE student;
                postgres    false            �            1259    16592    admin_details    TABLE     �   CREATE TABLE public.admin_details (
    name character(50) NOT NULL,
    username character(20) NOT NULL,
    password character(20) NOT NULL,
    email character(50) NOT NULL,
    phone character(10) NOT NULL
);
 !   DROP TABLE public.admin_details;
       public         heap    postgres    false            �            1259    16595    class_courses    TABLE     �   CREATE TABLE public.class_courses (
    classname character(5) NOT NULL,
    courseid character(10) NOT NULL,
    facultyid character(10) NOT NULL,
    facultyname character(50) NOT NULL
);
 !   DROP TABLE public.class_courses;
       public         heap    postgres    false            �            1259    16598    classes    TABLE     �   CREATE TABLE public.classes (
    classname character(20) NOT NULL,
    inchargeid character(20) NOT NULL,
    noofstudents bigint
);
    DROP TABLE public.classes;
       public         heap    postgres    false            �            1259    16601    courses    TABLE     �   CREATE TABLE public.courses (
    id character(10) NOT NULL,
    name character(50) NOT NULL,
    description character(100) NOT NULL,
    weeks bigint NOT NULL,
    maximum_capacity bigint NOT NULL
);
    DROP TABLE public.courses;
       public         heap    postgres    false            �            1259    16604    exam_schedule    TABLE     �  CREATE TABLE public.exam_schedule (
    courseid character(50) NOT NULL,
    coursename character(10020) NOT NULL,
    exam_date date NOT NULL,
    start_time time with time zone NOT NULL,
    end_time time with time zone NOT NULL,
    exam_type character(20) NOT NULL,
    hall_no character(20) NOT NULL,
    examinerid character(100) NOT NULL,
    total_duration bigint NOT NULL,
    maximum_marks bigint NOT NULL,
    class_name character(50) NOT NULL,
    noofstudents bigint NOT NULL
);
 !   DROP TABLE public.exam_schedule;
       public         heap    postgres    false            �            1259    16609 	   faculties    TABLE     �   CREATE TABLE public.faculties (
    facultyid character(10) NOT NULL,
    facultyname character(50) NOT NULL,
    email character(50) NOT NULL
);
    DROP TABLE public.faculties;
       public         heap    postgres    false            �            1259    16612 	   incharges    TABLE     �   CREATE TABLE public.incharges (
    id character(20) NOT NULL,
    name character(50) NOT NULL,
    gender character(10) NOT NULL,
    "isClassIncharge" boolean NOT NULL
);
    DROP TABLE public.incharges;
       public         heap    postgres    false            �            1259    16615    user_class_details    TABLE     s   CREATE TABLE public.user_class_details (
    regno character(20) NOT NULL,
    classname character(10) NOT NULL
);
 &   DROP TABLE public.user_class_details;
       public         heap    postgres    false            �            1259    16618    user_courses    TABLE     f   CREATE TABLE public.user_courses (
    regno character(20) NOT NULL,
    id character(10) NOT NULL
);
     DROP TABLE public.user_courses;
       public         heap    postgres    false            �            1259    16621    user_details    TABLE     �   CREATE TABLE public.user_details (
    name character(50) NOT NULL,
    username character(20) NOT NULL,
    password character(20) NOT NULL,
    email character(50) NOT NULL,
    phone character(10) NOT NULL
);
     DROP TABLE public.user_details;
       public         heap    postgres    false            �            1259    16624    user_family_details    TABLE     �   CREATE TABLE public.user_family_details (
    rollno character(20) NOT NULL,
    fathersname character(50) NOT NULL,
    mothersname character(50) NOT NULL
);
 '   DROP TABLE public.user_family_details;
       public         heap    postgres    false            �            1259    16627    user_personal_details    TABLE     |  CREATE TABLE public.user_personal_details (
    fname character(50) NOT NULL,
    lname character(50),
    rollno character(20) NOT NULL,
    regno character(20) NOT NULL,
    email character(50) NOT NULL,
    phone character(10) NOT NULL,
    dob date NOT NULL,
    address character(200) NOT NULL,
    bloodgroup character(3) NOT NULL,
    dayorhostel character(20) NOT NULL
);
 )   DROP TABLE public.user_personal_details;
       public         heap    postgres    false            �            1259    16630    user_school_details    TABLE     �   CREATE TABLE public.user_school_details (
    rollno character(50) NOT NULL,
    tenthmark character(5) NOT NULL,
    twelfthmark character(5) NOT NULL
);
 '   DROP TABLE public.user_school_details;
       public         heap    postgres    false            "          0    16592    admin_details 
   TABLE DATA                 public          postgres    false    215   S+       #          0    16595    class_courses 
   TABLE DATA                 public          postgres    false    216   �+       $          0    16598    classes 
   TABLE DATA                 public          postgres    false    217   �,       %          0    16601    courses 
   TABLE DATA                 public          postgres    false    218   -       &          0    16604    exam_schedule 
   TABLE DATA                 public          postgres    false    219   �/       '          0    16609 	   faculties 
   TABLE DATA                 public          postgres    false    220   �/       (          0    16612 	   incharges 
   TABLE DATA                 public          postgres    false    221   �2       )          0    16615    user_class_details 
   TABLE DATA                 public          postgres    false    222   �4       *          0    16618    user_courses 
   TABLE DATA                 public          postgres    false    223   5       +          0    16621    user_details 
   TABLE DATA                 public          postgres    false    224   �5       ,          0    16624    user_family_details 
   TABLE DATA                 public          postgres    false    225   �5       -          0    16627    user_personal_details 
   TABLE DATA                 public          postgres    false    226   66       .          0    16630    user_school_details 
   TABLE DATA                 public          postgres    false    227   a7       �           2606    16634     admin_details admin_details_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.admin_details
    ADD CONSTRAINT admin_details_pkey PRIMARY KEY (username);
 J   ALTER TABLE ONLY public.admin_details DROP CONSTRAINT admin_details_pkey;
       public            postgres    false    215            �           2606    16636    classes classes_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (classname, inchargeid);
 >   ALTER TABLE ONLY public.classes DROP CONSTRAINT classes_pkey;
       public            postgres    false    217    217            �           2606    16638    courses courses_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_pkey;
       public            postgres    false    218            �           2606    16640    faculties faculties_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_pkey PRIMARY KEY (facultyid, email);
 B   ALTER TABLE ONLY public.faculties DROP CONSTRAINT faculties_pkey;
       public            postgres    false    220    220            �           2606    16642    incharges incharges_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.incharges
    ADD CONSTRAINT incharges_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.incharges DROP CONSTRAINT incharges_pkey;
       public            postgres    false    221            �           2606    16644 *   user_class_details user_class_details_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.user_class_details
    ADD CONSTRAINT user_class_details_pkey PRIMARY KEY (regno);
 T   ALTER TABLE ONLY public.user_class_details DROP CONSTRAINT user_class_details_pkey;
       public            postgres    false    222            �           2606    16646    user_details user_details_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.user_details
    ADD CONSTRAINT user_details_pkey PRIMARY KEY (username);
 H   ALTER TABLE ONLY public.user_details DROP CONSTRAINT user_details_pkey;
       public            postgres    false    224            �           2606    16648 ,   user_family_details user_family_details_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.user_family_details
    ADD CONSTRAINT user_family_details_pkey PRIMARY KEY (rollno);
 V   ALTER TABLE ONLY public.user_family_details DROP CONSTRAINT user_family_details_pkey;
       public            postgres    false    225            �           2606    16650 0   user_personal_details user_personal_details_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.user_personal_details
    ADD CONSTRAINT user_personal_details_pkey PRIMARY KEY (rollno, regno);
 Z   ALTER TABLE ONLY public.user_personal_details DROP CONSTRAINT user_personal_details_pkey;
       public            postgres    false    226    226            �           2606    16652 ,   user_school_details user_school_details_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.user_school_details
    ADD CONSTRAINT user_school_details_pkey PRIMARY KEY (rollno);
 V   ALTER TABLE ONLY public.user_school_details DROP CONSTRAINT user_school_details_pkey;
       public            postgres    false    227            "   w   x���v
Q���W((M��L�KL��̋OI-I��)V��K�M�Q(-N-��
����RtRs�*��y��
a�>���
�`�
� u���;TTV�%��m�����)��i��� �9�      #   �   x���v
Q���W((M��L�K�I,.�O�/-*N-V� s�sSu b�):
i�ɥ9%�HL�
M�0G�P�`u#�Gu� �HCC  ���`�����D���Ģ�D����5�'������dC����R�3�Ks��w2 ��^Q      $   v   x���v
Q���W((M��L�K�I,.N-V� 3�sSu2�3��S3St���ӊKJSR�J�5�}B]�4ԍ<C�Ѐ����g�����_����5�'5�w�e�!���r.. ǟC<      %   �  x����o�0���W��U��S�=A��T������d�k��ؑ�@��k'���v�,~K��}���1	�O!O�!/f)g�LJ��c h�Ĩ���R�D|�d��gE��ќ2nV'��#$p�	�_�g]��@'I���g�d��3�>
T��ڇ>�
�v�;�;� zݓ�GQ &7�<��Js����*�Ef�6S(��R�4>0��A��bԟz F����PYMm�t���̀fC�� �l�꿂��j��M聸�c�mF+�f�pV�]`��]�F��`<Oml�[�==D�,���1��=.S�� ���4�'
g���Q2.��b�}�������m�4�����q��H�(�(�e���Q)"��n�Qh�8Y���߹��q����ϡ/�� �[��(��ڤo�Pz��(
'�^��1�HE¥4��ΨU��
�`f��J��*�]2��^tm��vw�<�O��x�"pC\`*�B� ;u_�Mqi�cϾ*����.�kB���
)c܃L�rH"�S�z�m���إ��ݚ%F�THĥ�^�Xs��]�ș��)O�l�p���y�֛f)��1�7gR��^k ��1Fc��' �
e/6
��1u�ভۣj/z��[*��.^��>ڨ{D{ӓ�>"͒*���D����X�.�����W02�5vKoā��{����:{�      &   
   x���          '   �  x�Ř�n�0E��
� ;}��*MںI\�J��lHK����;CbVY�W^� ǃ+^�f��v��f�ǟl߮K��aӖ�5;�������	�<g����m��N�f��F��v����%�k5X�!�:�D}@�K�7��u��d6��t0YXu �K����D��Q)���L�֒��<�`�)^���3��Av#:6~GՎ�[���?��[?�J�=�}�2����S)�����5���?�)މ�����~0YVR5�[�ob�-Q���$��!�4"0>��D�=QI�?&+UX��GU�����Q|GT��O.�;e1�K���SQ�B8���}�ff�bsP��{<�������]�N���p��(�?Q)���wQU;`K�������%*��}��U�{2��4DqMT߿�|�>;���׎�
�$��3��Pe	1�@�������=��
d*�_�&�׿N|�步���m��kG�5RI����Fu����(�ז(^8*��9��� �ڱ/Z	���D�MO�~~�/��~{������o/u��;���߬�U�%mD~�(�8*E~|�΅���籿���}�����;X��O����b^@�����0�1������Ǭ_#���]�op�X�����l\߿9ށ%6@�����"6�q�}����q�A*��g��7���]Kh��H�5Ri��+߿���Y �Z;*f ��������      (   �  x�͗Oo�@��|���"��('���)���3�#�w�~���u)Yyo�<~O?��'�t�\A�X�þ�(��Yg9�98�� 4�4��-�t�}Q�\rz�ۇ���a��Y/y?���@�+x7���v��9*������u'yc���i��kV��m��Qy2��v?K�usV�l��^��-f3�0�1�^	�)��d*�k���P�ì�u�>o�f���s��	VxT&���³� �Ekٵ��I�v�a��s��H����&M}���FW��{��^��&�RL�$_��*7�>o4�RL��XkX�Yv٢ѽ������Q����j���u蓮�>�n�c)՚�EWO^�ZFw(5�-i{���m�+�ڍ����u���]o��p+�Z]������h����L��%��p_�=��t�e"      )   c   x���v
Q���W((M��L�+-N-�O�I,.�OI-I��)V�(JM���Q ��%�j*�9���+h�*�uu#�G(OӚ˓���� e�8^      *   _   x���v
Q���W((M��L�+-N-�O�/-*N-V�(JM���Q�L�Ts�	uV�P7400T@�:
꾎!�uMk.O2�6�f���+��\\ Ei.      +   
   x���          ,      x���v
Q���W((M��L�+-N-�OK��̩�OI-I��)V�(������QHK,�H-*�K�M�Q�͇s4�}B]�4�0����:D+6Y\ �bI�4��<��-#<�#�[$�z�� /
cb      -     x�ՒAk� ����`����2(#t�`�v-��$`4hrط��v��e�����|�,/6o;���+tC)�C<���FI*����V����E+!���+'���t���d�D@���P�UZ�u�ҵ2=k�H��7�B����!�0Yp��(����r��ܒ�ʕT{�+?���G8��{��v9����M�xq1>\-鍗���멽��k����.r�`<�;�03&t��t�I�'��_���du3�N�Aw��F��<]��ֹm�
�o���<      .   �   x���v
Q���W((M��L�+-N-�/N���ωOI-I��)V�(������Q(I�+��M,�2�Ss� M�0G�P�`uCR����������aa�gf��i��Im���03=3�P���0.. ��M&     