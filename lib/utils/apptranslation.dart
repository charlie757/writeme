import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "oops": "Oops",
          "success": "Success",
          "please_wait": "Please wait",
          "logout_message": "Do you want to logout?",
          "yes": "YES",
          "no": "NO",
          "cancel": "Cancel",
          "done": "Done",
          "continue": "Continue",
          "logged_in_successfully": "Logged in successfully",

          "no_message_yet": "No Message yet!",

          "choose_img_source": "Choose Image Source",
          "camera": "Camera",
          "gallery": "Gallery",

          //Placeholder
          "select_language": "Select Language",
          "english": "English",
          "german": "German",
          "submit": "Submit",

          //login
          "welcome_back": "Welcome Back!",
          "enter_your_mobile_no_to_continue":
              "Enter your mobile number to continue",
          "login": "Login",
          "mobile_number": "Mobile Number with Country Code",

          //Verify OTP
          "otp_top_code_sent":
              "Code is sent. If you still don't get the code, please make sure you've filled your phone number correctly.",
          "fill_the_otp": "Fill the OTP",
          "dont_get_code": "Don't get the code?",
          "resend": "Resend",
          "verify_otp": "Verify OTP",
          "update_profile": "Update Profile",
          "invalid_otp": "Invalid OTP, Please enter correct OTP",

          //Update Profile
          "name": "Name",
          "email": "Email",
          "message": "Message",
          "profile": "Profile",

          //Dashboard
          "all_chats": "All Chats",
          "search": "Search",

          //Settings
          "settings": "Settings",
          "edit_profile": "Edit Profile",
          "my_profile": "My Profile",
          "language": "Language",
          "faq": "FAQs",
          "help": "Help",
          "privacy_policy": "Privacy & Policy",
          "contact_us": "Contact Us",
          "about_us": "About Us",
          "logout": "Logout",
          "delete_account": "Delete Account",
          'termscondition': "Terms & Condition",
          "delete_account_message": "Do you want to delete the account?",

          //Contact listing
          "contacts": "Contacts",

          //Create Group
          "create_group": "Create Group",
          "enter_group_name": "Enter Group Name",
          "people_in_group": "People In Group",

          //Edit Profile
          "profile_updated_successfully": "Profile updated successfully",

          //ERROR ALERT
          "enter_name": "Please enter name",
          "enter_email": "Please enter email",
          "enter_mobileno": "Please enter valid phone number",
          "enter_otp": "Please enter valid OTP",
          "enter_message": "Please enter message",
          "something_went_wrong":
              "Something went wrong, Please try again after sometime.",
          "invalid_mobile_no": "The provided phone number is not valid..",

          "logout": "Logout",
          "logout_message": "Do you want to logout?",

          "type_a_message": "Type a message",
          "take_photo_camera": "Take Photo From Camera",
          "take_photo_gallery": "Take Photo From Gallery",
          "take_video_camera": "Take Video From Camera",
          "take_vidoe_gallery": "Take Video From Gallery",
          "doc": "Document",

          "big_file_size": "Please upload less than 10 mb file",

          //create Group
          "group_created_successfully": "Group Created Successfully",
          "enter_group_name": "Please enter group name",
          "select_group_image": "Please select group image",
          "select_group_members": "Please select group members",
          "no_groups_chat": "No Group Chat Yet!",
          "exit_group": "Exit Group",
          "are_you_sure": "Are you sure?",
          "do_wanna_exit_group": " Do you wanna exit from this group",
          "do_wanna_delete_group": " Do you wanna delete this group",
          "removed_from_group": "Removed from group successfully",
          "delete_group": "Delete Group",
          "group_deleted_successfully": "Group Deleted Successfully",
          "contact_info_send_successfully": "Contact Info Send Successfully",

          "change_language": "Change Language",
          "change": "Change",
          "chats": "Chats",
          "groups": "Groups"
        },
        "ar_AR": {
          "oops": "أُووبس",
          "success": "نجاح",
          "please_wait": "يرجى الانتظار",
          "logout_message": "هل ترغب بالخروج",
          "yes": "نعم",
          "no": "لا",
          "cancel": "يقطع",
          "done": "مكتمل",
          "continue": "يستمر في التقدم",
          "logged_in_successfully": "تم تسجيل الدخول بنجاح",

          "my_profile": "ملفي",
          "no_message_yet": "لا توجد رسالة بعد!",

          "choose_img_source": "اختر مصدر الصورة",
          "camera": "آلة تصوير",
          "gallery": "صالة عرض",

          //Placeholder

          "select_language": "اختر لغة",
          "english": "إنجليزي",
          "german": "ألماني",
          "submit": "يُقدِّم",

          //login
          "welcome_back": "مرحبًا بعودتك!",
          "enter_your_mobile_no_to_continue": "أدخل رقم هاتفك المحمول للمتابعة",
          "login": "تسجيل",
          "mobile_number": "رقم الهاتف الخليوي مع رمز الدولة",

          //Verify OTP
          "otp_top_code_sent":
              "سيتم إرسال الرمز. إذا كنت لا تزال لا تتلقى الرمز ، فيرجى التأكد من إدخال رقم هاتفك بشكل صحيح.",
          "fill_the_otp": "أكمل كلمة المرور لمرة واحدة",
          "dont_get_code": "لا تحصل على الرمز؟",
          "resend": "أعد الإرسال",
          "verify_otp": "تحقق من OTP",
          "update_profile": "تحديث الملف",
          "invalid_otp": "OTP غير صحيح ، يرجى إدخال OTP الصحيح",

          //Update Profile
          "name": "اسم العائلة",
          "email": "بريد إلكتروني",
          "message": "أخبار",
          "profile": "حساب تعريفي",

          //Dashboard
          "all_chats": "كل الدردشات",
          "search": "يطلب",

          //Settings
          "settings": "الأفكار",
          "edit_profile": "تعديل الملف الشخصي",
          "language": "لغة",
          "faq": "الأسئلة المتداولة",
          "help": "يساعد",
          "privacy_policy": "سياسة الخصوصية",
          "contact_us": "اتصل بنا",
          "about_us": "عننا",
          "logout": "تسجيل خروج",
          "delete_account": "حذف الحساب",
          'termscondition': "الشروط  &الحالة",
          "delete_account_message": "هل تريد حذف الحساب؟",

          //Contact listing
          "contacts": "جهات الاتصال",

          //Create Group
          "create_group": "إنشاء مجموعة",
          "enter_group_name": "أدخل اسم المجموعة",
          "people_in_group": "الناس في المجموعة",

          //Edit Profile
          "profile_updated_successfully": "تم تحديث الملف الشخصي بنجاح",

          //ERROR ALERT
          "enter_name": "الرجاء إدخال الاسم",
          "enter_email": "الرجاء إدخال البريد الإلكتروني",
          "enter_mobileno": "يرجى إدخال رقم هاتف صالح",
          "enter_otp": "الرجاء إدخال OTP صالح",
          "enter_message": "الرجاء إدخال الرسالة",
          "something_went_wrong":
              "حدث خطأ ما ، يرجى المحاولة مرة أخرى بعد قليل.",
          "invalid_mobile_no": "رقم الهاتف المقدم غير صالح ..",

          "logout": "تسجيل خروج",
          "logout_message": "هل ترغب بالخروج؟",

          "type_a_message": "اكتب رسالة",
          "take_photo_camera": "التقط صورة من الكاميرا",
          "take_photo_gallery": "التقط صورة من المعرض",
          "take_video_camera": "تسجيل الفيديو من الكاميرا",
          "take_vidoe_gallery": "سجل فيديو من المعرض",
          "doc": "وثيقة",

          "big_file_size": "يرجى تحميل ملف أقل من 10 ميغا بايت",

          //create Group
          "group_created_successfully": "تم إنشاء المجموعة بنجاح",
          "enter_group_name": "الرجاء إدخال اسم المجموعة",
          "select_group_image": "الرجاء تحديد صورة جماعية",
          "select_group_members": "الرجاء تحديد أعضاء المجموعة",
          "no_groups_chat": "لا توجد دردشة جماعية حتى الآن!",
          "exit_group": "اترك المجموعة",
          "are_you_sure": "هل انت متاكد؟",
          "do_wanna_exit_group": "هل تريد مغادرة هذه المجموعة؟",
          "do_wanna_delete_group": "هل تريد حذف هذه المجموعة؟",
          "removed_from_group": "تمت الإزالة بنجاح من المجموعة",
          "delete_group": "حذف المجموعة",
          "group_deleted_successfully": "تم حذف المجموعة بنجاح",
          "contact_info_send_successfully": "تم إرسال معلومات الاتصال بنجاح",

          "change_language": "تغيير اللغة",
          "change": "يتغير",
        },
        'hi_HI': {
          "oops": "उफ़",
          "success": "सफलता",
          "please_wait": "कृपया प्रतीक्षा करें",
          "logout_message": "क्या आप लॉग आउट करना चाहते हैं",
          "yes": "हाँ",
          "no": "नहीं",
          "cancel": "बाधा डालना",
          "done": "पुरा होना।",
          "continue": "जाता रहना",
          "logged_in_successfully": "सफलतापूर्वक लॉग इन किया",

          "my_profile": "मेरी प्रोफाइल",
          "no_message_yet": "अभी तक कोई संदेश नहीं!",

          "choose_img_source": "छवि स्रोत चुनें",
          "camera": "कैमरा",
          "gallery": "गेलरी",

          //Placeholder

          "select_language": "एक भाषा चुनें",
          "english": "अंग्रेज़ी",
          "german": "जर्मन",
          "submit": "जमा करना",

          //login
          "welcome_back": "वापसी पर स्वागत है!",
          "enter_your_mobile_no_to_continue":
              "जारी रखने के लिए अपना मोबाइल नंबर दर्ज करें",
          "login": "पंजीकरण",
          "mobile_number": "देश कोड के साथ सेल फोन नंबर",

          //Verify OTP
          "otp_top_code_sent":
              "कोड भेजा जाएगा। यदि आपको अभी भी कोड प्राप्त नहीं हुआ है, तो कृपया सुनिश्चित करें कि आपने अपना फ़ोन नंबर सही दर्ज किया है।",
          "fill_the_otp": "ओटीपी को पूरा करें",
          "dont_get_code": "कोड नहीं मिला?",
          "resend": "पुनः भेजें",
          "verify_otp": "ओटीपी चेक करें",
          "update_profile": "प्रोफ़ाइल अपडेट करें",
          "invalid_otp": "अमान्य ओटीपी, कृपया सही ओटीपी दर्ज करें",

          //Update Profile
          "name": "उपनाम",
          "email": "ईमेल",
          "message": "समाचार",
          "profile": "प्रोफ़ाइल",

          //Dashboard
          "all_chats": "सभी चैट",
          "search": "खोज",

          //Settings
          "settings": "विचारों",
          "edit_profile": "प्रोफ़ाइल संपादित करें",
          "language": "भाषा",
          "faq": "अक्सर पूछे जाने वाले प्रश्नों",
          "help": "मदद",
          "privacy_policy": "गोपनीयता नीति",
          "contact_us": "संपर्क करें",
          "about_us": "हमारे बारे में",
          "logout": "लॉग आउट",
          "delete_account": "खाता हटा दो",
          'termscondition': "शर्तें & शर्तें",
          "delete_account_message": "क्या आप खाता हटाना चाहते हैं?",

          //Contact listing
          "contacts": "संपर्क",

          //Create Group
          "create_group": "समूह बनाना",
          "enter_group_name": "समूह का नाम दर्ज करें",
          "people_in_group": "समूह में लोग",

          //Edit Profile
          "profile_updated_successfully":
              "प्रोफाइल को सफलतापूर्वक अपडेट किया गया",

          //ERROR ALERT
          "enter_name": "कृपया नाम दर्ज करें",
          "enter_email": "कृपया ईमेल दर्ज करें",
          "enter_mobileno": "कृपया मान्य टेलीफ़ोन नंबर दर्ज करें",
          "enter_otp": "कृपया एक मान्य ओटीपी दर्ज करें",
          "enter_message": "कृपया संदेश दर्ज करें",
          "something_went_wrong":
              "कुछ गलत हो गया, कृपया कुछ समय बाद पुन: प्रयास करें।",
          "invalid_mobile_no": "प्रदान किया गया फ़ोन नंबर अमान्य है..",

          "logout": "लॉग आउट",
          "logout_message": "क्या आप लॉग आउट करना चाहते हैं?",

          "type_a_message": "एक संदेश लिखें",
          "take_photo_camera": "कैमरे से फोटो लें",
          "take_photo_gallery": "गैलरी से एक फोटो लें",
          "take_video_camera": "कैमरे से वीडियो रिकॉर्ड करें",
          "take_vidoe_gallery": "गैलरी से एक वीडियो रिकॉर्ड करें",
          "doc": "दस्तावेज़",

          "big_file_size": "कृपया 10MB से कम की फ़ाइल अपलोड करें",

          //create Group
          "group_created_successfully": "समूह सफलतापूर्वक बनाया गया",
          "enter_group_name": "कृपया समूह का नाम दर्ज करें",
          "select_group_image": "कृपया एक समूह फोटो चुनें",
          "select_group_members": "कृपया समूह के सदस्यों का चयन करें",
          "no_groups_chat": "अभी तक कोई समूह चैट नहीं!",
          "exit_group": "समूह छोड़ दो",
          "are_you_sure": "क्या आपको यकीन है?",
          "do_wanna_exit_group": "क्या आप इस समूह को छोड़ना चाहते हैं?",
          "do_wanna_delete_group": "क्या आप इस समूह को हटाना चाहते हैं?",
          "removed_from_group": "समूह से सफलतापूर्वक निकाला गया",
          "delete_group": "समूह हटाएं",
          "group_deleted_successfully": "समूह सफलतापूर्वक हटाया गया",
          "contact_info_send_successfully":
              "संपर्क जानकारी सफलतापूर्वक भेजी गई",

          "change_language": "भाषा बदलें",
          "change": "परिवर्तन",
          "chats": "चैट",
          "groups": "समूह"
        },
        'ru_RU': {
          "oops": "Упс",
          "success": "Успех",
          "please_wait": "Пожалуйста, подождите",
          "logout_message": "Вы хотите выйти из системы?",
          "yes": "Да",
          "no": "Нет",
          "cancel": "Прерывать",
          "done": "Завершенный",
          "continue": "Продолжать идти",
          "logged_in_successfully": "успешно авторизовался",

          "my_profile": "Мой профайл",
          "no_message_yet": "Пока нет сообщений!",

          "choose_img_source": "Выберите источник изображения",
          "camera": "камера",
          "gallery": "галерея",

          //Placeholder

          "select_language": "Выберите язык",
          "english": "Английский",
          "german": "Немецкий",
          "submit": "Представлять на рассмотрение",

          //login
          "welcome_back": "Добро пожаловать обратно!",
          "enter_your_mobile_no_to_continue":
              "Введите номер своего мобильного телефона, чтобы продолжить",
          "login": "Постановка на учет",
          "mobile_number": "Номер мобильного телефона с кодом страны",

          //Verify OTP
          "otp_top_code_sent":
              "Код будет отправлен. Если вы все еще не получили код, убедитесь, что вы правильно ввели свой номер телефона.",
          "fill_the_otp": "Заполните одноразовый пароль",
          "dont_get_code": "Не получили код?",
          "resend": "Отправь еще раз",
          "verify_otp": "Проверить одноразовый пароль",
          "update_profile": "обновить профиль",
          "invalid_otp": "Неверный OTP, введите правильный OTP",

          //Update Profile
          "name": "Фамилия",
          "email": "Электронная почта",
          "message": "Новости",
          "profile": "профиль",

          //Dashboard
          "all_chats": "Все чаты",
          "search": "Искать",

          //Settings
          "settings": "Идеи",
          "edit_profile": "редактировать профиль",
          "language": "Язык",
          "faq": "Часто задаваемые вопросы",
          "help": "Помощь",
          "privacy_policy": "политика конфиденциальности",
          "contact_us": "Связаться с нами",
          "about_us": "о нас",
          "logout": "выйти",
          "delete_account": "Удалить аккаунт",
          'termscondition': "Условия & Условия",
          "delete_account_message": "क्Вы хотите удалить учетную запись?",

          //Contact listing
          "contacts": "контакты",

          //Create Group
          "create_group": "создать группу",
          "enter_group_name": "Введите название группы",
          "people_in_group": "люди в группе",

          //Edit Profile
          "profile_updated_successfully": "Профиль успешно обновлен",

          //ERROR ALERT
          "enter_name": "Пожалуйста, введите имя",
          "enter_email": "Пожалуйста, введите адрес электронной почты",
          "enter_mobileno": "Пожалуйста, введите действительный номер телефона",
          "enter_otp": "Пожалуйста, введите действительный OTP",
          "enter_message": "Пожалуйста, введите сообщение",
          "something_went_wrong":
              "Что-то пошло не так, повторите попытку через некоторое время.",
          "invalid_mobile_no": "Указанный номер телефона недействителен..",

          "logout": "выйти",
          "logout_message": "Вы хотите выйти из системы?",

          "type_a_message": "Введите сообщение",
          "take_photo_camera": "Сделать фото с камеры",
          "take_photo_gallery": "Сделать фото из галереи",
          "take_video_camera": "Запись видео с камеры",
          "take_vidoe_gallery": "Запись видео из галереи",
          "doc": "документ",

          "big_file_size": "Загрузите файл размером менее 10 МБ.",

          //create Group
          "group_created_successfully": "Группа успешно создана",
          "enter_group_name": "Пожалуйста, введите название группы",
          "select_group_image": "Пожалуйста, выберите групповое фото",
          "select_group_members": "Пожалуйста, выберите участников группы",
          "no_groups_chat": "Группового чата пока нет!",
          "exit_group": "покинуть группу",
          "are_you_sure": "Ты уверен?",
          "do_wanna_exit_group": "Вы хотите покинуть эту группу?",
          "do_wanna_delete_group": "Вы хотите удалить эту группу?",
          "removed_from_group": "Успешно удален из группы",
          "delete_group": "Удалить группу",
          "group_deleted_successfully": "Группа успешно удалена",
          "contact_info_send_successfully":
              "Контактная информация успешно отправлена",

          "change_language": "Изменить язык",
          "change": "Изменять",
          "chats": "Чаты",
          "groups": "Группы"
        },
        'sp_SP': {
          "oops": "Ups",
          "success": "Éxito",
          "please_wait": "Espere por favor",
          "logout_message": "¿Quieres cerrar sesión?",
          "yes": "Sí",
          "no": "No",
          "cancel": "Interrumpir",
          "done": "Terminado",
          "continue": "Sigue adelante",
          "logged_in_successfully": "iniciado sesión con éxito",

          "my_profile": "Mi perfil",
          "no_message_yet": "¡Ningún mensaje todavía!",

          "choose_img_source": "Elija la fuente de la imagen",
          "camera": "cámara",
          "gallery": "galería",

          //Placeholder

          "select_language": "Elige un idioma",
          "english": "Inglés",
          "german": "Alemán",
          "submit": "Entregar",

          //login
          "welcome_back": "¡Bienvenido de nuevo!",
          "enter_your_mobile_no_to_continue":
              "Introduce tu número de móvil para continuar",
          "login": "Registro",
          "mobile_number": "Número de celular con código de país",

          //Verify OTP
          "otp_top_code_sent":
              "Se enviará el código. Si aún no recibe el código, asegúrese de haber ingresado su número de teléfono correctamente.",
          "fill_the_otp": "Completar la OTP",
          "dont_get_code": "¿No consigues el código?",
          "resend": "Enviar de nuevo",
          "verify_otp": "Comprobar OTP",
          "update_profile": "actualización del perfil",
          "invalid_otp": "OTP inválida, ingrese la OTP correcta",

          //Update Profile
          "name": "Apellido",
          "email": "Correo electrónico",
          "message": "Noticias",
          "profile": "perfil",

          //Dashboard
          "all_chats": "Todos los chats",
          "search": "Buscar",

          //Settings
          "settings": "Ideas",
          "edit_profile": "Editar perfil",
          "language": "Idioma",
          "faq": "preguntas frecuentes",
          "help": "Ayuda",
          "privacy_policy": "política de privacidad",
          "contact_us": "Contáctenos",
          "about_us": "Sobre nosotros",
          "logout": "cerrar sesión",
          "delete_account": "Borrar cuenta",
          'termscondition': "Términos & Condiciones",
          "delete_account_message": "¿Quieres eliminar la cuenta?",

          //Contact listing
          "contacts": "contactos",

          //Create Group
          "create_group": "crea un grupo",
          "enter_group_name": "Ingrese el nombre del grupo",
          "people_in_group": "gente en el grupo",

          //Edit Profile
          "profile_updated_successfully": "perfil actualizado con éxito",

          //ERROR ALERT
          "enter_name": "Por favor ingrese el nombre",
          "enter_email": "Por favor ingrese el correo electrónico",
          "enter_mobileno": "Por favor introduce un número de teléfono válido",
          "enter_otp": "Ingrese una OTP válida",
          "enter_message": "Por favor ingrese el mensaje",
          "something_went_wrong":
              "Algo salió mal, inténtalo de nuevo después de un tiempo.",
          "invalid_mobile_no":
              "El número de teléfono proporcionado no es válido..",

          "logout": "cerrar sesión",
          "logout_message": "¿quieres cerrar sesión?",

          "type_a_message": "Escriba un mensaje",
          "take_photo_camera": "Tomar foto de la cámara",
          "take_photo_gallery": "Toma una foto de la galería.",
          "take_video_camera": "Grabar video desde la cámara",
          "take_vidoe_gallery": "Grabar un video de la galería",
          "doc": "documento",

          "big_file_size": "Cargue un archivo de menos de 10 MB",

          //create Group
          "group_created_successfully": "Grupo creado con éxito",
          "enter_group_name": "Por favor ingrese el nombre del grupo",
          "select_group_image": "Por favor seleccione una foto de grupo",
          "select_group_members": "Por favor seleccione miembros del grupo",
          "no_groups_chat": "¡Todavía no hay chat grupal!",
          "exit_group": "dejar el grupo",
          "are_you_sure": "¿Está seguro?",
          "do_wanna_exit_group": "¿Quieres dejar este grupo?",
          "do_wanna_delete_group": "¿Quieres eliminar este grupo?",
          "removed_from_group": "Eliminado con éxito del grupo",
          "delete_group": "Eliminar grupo",
          "group_deleted_successfully": "Grupo eliminado con éxito",
          "contact_info_send_successfully":
              "Información de contacto enviada con éxito",

          "change_language": "cambiar idioma",
          "change": "Cambiar",
          "chats": "charlas",
          "groups": "Grupos"
        },
        'de_DE': {
          "oops": "Hoppla",
          "success": "Erfolg",
          "please_wait": "Bitte Warten",
          "logout_message": "Möchten Sie sich abmelden",
          "yes": "Ja",
          "no": "Nein",
          "cancel": "Abbrechen",
          "done": "Erledigt",
          "continue": "Weitermachen",
          "logged_in_successfully": "Erfolgreich eingeloggt",

          "my_profile": "Mein Profil",
          "no_message_yet": "Noch keine Nachricht!",

          "choose_img_source": "Wählen Sie Bildquelle",
          "camera": "Kamera",
          "gallery": "Galerie",

          //Placeholder
          "select_language": "Sprache auswählen",
          "english": "Englisch",
          "german": "Deutsch",
          "submit": "Einreichen",

          //login
          "welcome_back": "Willkommen zurück!",
          "enter_your_mobile_no_to_continue":
              "Geben Sie Ihre Handynummer ein, um fortzufahren",
          "login": "Anmeldung",
          "mobile_number": "Handynummer mit Ländervorwahl",

          //Verify OTP
          "otp_top_code_sent":
              "Code wird gesendet. Wenn Sie den Code immer noch nicht erhalten, vergewissern Sie sich bitte, dass Sie Ihre Telefonnummer richtig eingegeben haben.",
          "fill_the_otp": "Füllen Sie das OTP aus",
          "dont_get_code": "Erhalten Sie den Code nicht?",
          "resend": "Erneut senden",
          "verify_otp": "Überprüfen Sie OTP",
          "update_profile": "Profil aktualisieren",
          "invalid_otp": "Ungültiges OTP, bitte korrektes OTP eingeben",

          //Update Profile								Name
          "name": "Email",
          "email": "Nachricht",
          "message": "Message",
          "profile": "Profil",

          //Dashboard
          "all_chats": "Alle Chats",
          "search": "Suchen",

          //Settings
          "settings": "Einstellungen",
          "edit_profile": "Profil bearbeiten",
          "language": "Sprache",
          "faq": "Häufig gestellte Fragen",
          "help": "Hilfe",
          "privacy_policy": "Datenschutzbestimmungen",
          "contact_us": "Kontaktiere uns",
          "about_us": "Über uns",
          "logout": "Ausloggen",
          "delete_account": "Konto löschen",
          'termscondition': "Allgemeine Geschäftsbedingungen",
          "delete_account_message": "Möchten Sie das Konto löschen?",

          //Contact listing
          "contacts": "Kontakte",

          //Create Group
          "create_group": "Gruppe erstellen",
          "enter_group_name": "Gruppennamen eingeben",
          "people_in_group": "Menschen in der Gruppe",

          //Edit Profile
          "profile_updated_successfully": "Profil erfolgreich aktualisiert",

          //ERROR ALERT
          "enter_name": "Bitte Namen eingeben",
          "enter_email": "Bitte E-Mail eingeben",
          "enter_mobileno": "Bitte geben Sie eine gültige Telefonnummer ein",
          "enter_otp": "Bitte geben Sie ein gültiges OTP ein",
          "enter_message": "Bitte Nachricht eingeben",
          "something_went_wrong":
              "Etwas ist schief gelaufen, bitte versuchen Sie es nach einiger Zeit erneut.",
          "invalid_mobile_no": "Die angegebene Telefonnummer ist ungültig..",

          "logout": "Ausloggen",
          "logout_message": "Möchten Sie sich abmelden?",

          "type_a_message": "Geben Sie eine Nachricht ein",
          "take_photo_camera": "Foto von der Kamera aufnehmen",
          "take_photo_gallery": "Nehmen Sie ein Foto aus der Galerie",
          "take_video_camera": "Nehmen Sie ein Video von der Kamera auf",
          "take_vidoe_gallery": "Nehmen Sie ein Video aus der Galerie auf",
          "doc": "Dokument",

          "big_file_size":
              "Bitte laden Sie eine Datei mit weniger als 10 MB hoch",

          //create Group
          "group_created_successfully": "Gruppe erfolgreich erstellt",
          "enter_group_name": "Bitte Gruppennamen eingeben",
          "select_group_image": "Bitte Gruppenbild auswählen",
          "select_group_members": "Bitte Gruppenmitglieder auswählen",
          "no_groups_chat": "Noch kein Gruppenchat!",
          "exit_group": "Gruppe verlassen",
          "are_you_sure": "Bist du dir sicher?",
          "do_wanna_exit_group": "Möchtest du diese Gruppe verlassen",
          "do_wanna_delete_group": "Möchten Sie diese Gruppe löschen?",
          "removed_from_group": "Erfolgreich aus der Gruppe entfernt",
          "delete_group": "Gruppe löschen",
          "group_deleted_successfully": "Gruppe erfolgreich gelöscht",
          "contact_info_send_successfully":
              "Kontaktinformationen erfolgreich gesendet",

          "change_language": "Sprache ändern",
          "change": "Ändern",
          "chats": "Chats",
          "groups": "Gruppen"
        },
        'fr_FR': {
          "oops": "Oops",
          "success": "Succès",
          "please_wait": "S'il vous plaît, attendez",
          "logout_message": "Voulez-vous vous désabonner",
          "yes": "Oui",
          "no": "Non",
          "cancel": "Avorter",
          "done": "Fait",
          "continue": "Continuer",
          "logged_in_successfully": "connecté avec succès",

          "my_profile": "Mon profil",
          "no_message_yet": "Pas encore de message !",

          "choose_img_source": "Choisissez la source de l'image",
          "camera": "caméra",
          "gallery": "Galerie",

          //Placeholder

          "select_language": "Choisissez une langue",
          "english": "Anglais",
          "german": "Allemand",
          "submit": "Soumettre",

          //login
          "welcome_back": "Content de te revoir!",
          "enter_your_mobile_no_to_continue":
              "Entrez votre numéro de portable pour continuer",
          "login": "Inscription",
          "mobile_number": "Numéro de téléphone portable avec code pays",

          //Verify OTP
          "otp_top_code_sent":
              "Le code sera envoyé. Si vous ne recevez toujours pas le code, assurez-vous d'avoir correctement saisi votre numéro de téléphone.",
          "fill_the_otp": "Remplir l'OTP",
          "dont_get_code": "Vous ne recevez pas le code ?",
          "resend": "Envoyer à nouveau",
          "verify_otp": "Vérifier OTP",
          "update_profile": "mettre à jour le profil",
          "invalid_otp": "OTP invalide, veuillez entrer le bon OTP",

          //Update Profile
          "name": "Nom de famille",
          "email": "E-mail",
          "message": "Nouvelles",
          "profile": "profil",

          //Dashboard
          "all_chats": "Tous les chats",
          "search": "Chercher",

          //Settings
          "settings": "Idées",
          "edit_profile": "Editer le profil",
          "language": "Langue",
          "faq": "Questions fréquemment posées",
          "help": "Aider",
          "privacy_policy": "politique de confidentialité",
          "contact_us": "Contactez-nous",
          "about_us": "À propos de nous",
          "logout": "Se déconnecter",
          "delete_account": "Supprimer le compte",
          'termscondition': "Conditions & Conditions",
          "delete_account_message": "Voulez-vous supprimer le compte ?",

          //Contact listing
          "contacts": "Contacts",

          //Create Group
          "create_group": "créer un groupe",
          "enter_group_name": "Entrez le nom du groupe",
          "people_in_group": "personnes du groupe",

          //Edit Profile
          "profile_updated_successfully": "Mise à jour du profil réussie",

          //ERROR ALERT
          "enter_name": "Veuillez entrer le nom",
          "enter_email": "Veuillez saisir un e-mail",
          "enter_mobileno": "Veuillez saisir un numéro de téléphone valide",
          "enter_otp": "Veuillez entrer un OTP valide",
          "enter_message": "Veuillez entrer un message",
          "something_went_wrong":
              "Quelque chose s'est mal passé, veuillez réessayer après un certain temps.",
          "invalid_mobile_no": "Le numéro de téléphone fourni est invalide..",

          "logout": "Se déconnecter",
          "logout_message": "voulez-vous vous déconnecter ?",

          "type_a_message": "Tapez un message",
          "take_photo_camera": "Prendre une photo de l'appareil photo",
          "take_photo_gallery": "Prendre une photo de la galerie",
          "take_video_camera": "Enregistrer la vidéo de la caméra",
          "take_vidoe_gallery": "Enregistrer une vidéo de la galerie",
          "doc": "document",

          "big_file_size": "Veuillez télécharger un fichier de moins de 10 Mo",

          //create Group
          "group_created_successfully": "Groupe créé avec succès",
          "enter_group_name": "Veuillez entrer le nom du groupe",
          "select_group_image": "Veuillez sélectionner une photo de groupe",
          "select_group_members": "Veuillez sélectionner les membres du groupe",
          "no_groups_chat": "Pas encore de chat de groupe !",
          "exit_group": "quitter le groupe",
          "are_you_sure": "Es-tu sûr?",
          "do_wanna_exit_group": "Voulez-vous quitter ce groupe ?",
          "do_wanna_delete_group": "Voulez-vous supprimer ce groupe ?",
          "removed_from_group": "Retiré du groupe avec succès",
          "delete_group": "Supprimer le groupe",
          "group_deleted_successfully": "Groupe supprimé avec succès",
          "contact_info_send_successfully": "Coordonnées envoyées avec succès",

          "change_language": "changer de langue",
          "change": "Changement",
          "chats": "Chats",
          "groups": "Groupes"
        },
        //chinese
        'zh_ZH': {
          "oops": "糟糕",
          "success": "成功",
          "please_wait": "请稍等",
          "logout_message": "你想退出吗",
          "yes": "是的",
          "no": "不",
          "cancel": "打断",
          "done": "完全的",
          "continue": "继续前进",
          "logged_in_successfully": "登录成功",

          "my_profile": "我的简历",
          "no_message_yet": "还没有留言！",

          "choose_img_source": "选择图片来源",
          "camera": "相机",
          "gallery": "画廊",

          //Placeholder
          "select_language": "选择语言",
          "english": "英语",
          "german": "德语",
          "submit": "提交",

          //login
          "welcome_back": "欢迎回来！",
          "enter_your_mobile_no_to_continue": "输入您的手机号码以继续",
          "login": "登记",
          "mobile_number": "带国家代码的手机号码",

          //Verify OTP
          "otp_top_code_sent": "代码将被发送。如果您仍然没有收到验证码，请确保您输入的电话号码正确无误。",
          "fill_the_otp": "完成一次性密码",
          "dont_get_code": "没有得到代码？",
          "resend": "重新发送",
          "verify_otp": "检查一次性密码",
          "update_profile": "更新个人信息",
          "invalid_otp": "无效，请输入正确的 OTP",

          //Update Profile								Name					姓
          "name": "电子邮件",
          "email": "消息",
          "message": "轮廓",
          "profile": "Profile",

          //Dashboard
          "all_chats": "所有聊天记录",
          "search": "寻找",

          //Settings
          "settings": "想法",
          "edit_profile": "编辑个人资料",
          "language": "语言",
          "faq": "经常问的问题",
          "help": "帮助",
          "privacy_policy": "隐私政策",
          "contact_us": "联系我们",
          "about_us": "关于我们",
          "logout": "登出",
          "delete_account": "删除帐户",
          'termscondition': "条款 & 条件",
          "delete_account_message": "您想删除该帐户吗？",

          //Contact listing
          "contacts": "联系人",

          //Create Group
          "create_group": "创建组",
          "enter_group_name": "输入群组名称",
          "people_in_group": "组里的人",

          //Edit Profile
          "profile_updated_successfully": "配置文件更新成功",

          //ERROR ALERT
          "enter_name": "请输入姓名",
          "enter_email": "请输入邮箱",
          "enter_mobileno": "请输入有效的电话号码",
          "enter_otp": "请输入有效的一次性密码",
          "enter_message": "请输入留言",
          "something_went_wrong": "出了点问题，请稍后重试。",
          "invalid_mobile_no": "提供的电话号码无效..",

          "logout": "登出",
          "logout_message": "你想退出吗？",

          "type_a_message": "输入消息",
          "take_photo_camera": "从相机拍照",
          "take_photo_gallery": "从画廊拍一张照片",
          "take_video_camera": "从相机录制视频",
          "take_vidoe_gallery": "从画廊录制视频",
          "doc": "文档",

          "big_file_size": "请上传小于 10MB 的文件",

          //create Group
          "group_created_successfully": "群组创建成功",
          "enter_group_name": "请输入群组名称",
          "select_group_image": "请选择合影",
          "select_group_members": "请选择群组成员",
          "no_groups_chat": "还没有群聊！",
          "exit_group": "退群",
          "are_you_sure": "你确定吗？",
          "do_wanna_exit_group": "你想离开这个群吗？",
          "do_wanna_delete_group": "你想删除这个组吗？",
          "removed_from_group": "已成功从群组中移除",
          "delete_group": "删除群组",
          "group_deleted_successfully": "组已成功删除",
          "contact_info_send_successfully": "联系方式发送成功",

          "change_language": "改变语言",
          "change": "改变",
          "chats": "聊天记录",
          "groups": "团体"
        }
      };
}
