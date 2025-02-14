import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'pt'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? ptText = '',
  }) =>
      [enText, ptText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Splash
  {
    'ftlk10x5': {
      'en': 'C',
      'pt': 'D',
    },
    'xhhiwnms': {
      'en': 'hallenge',
      'pt': 'esafio',
    },
    '31v5xhd9': {
      'en': 'Get Started',
      'pt': 'Comece',
    },
    '4wjpihri': {
      'en': 'Already a member?  ',
      'pt': 'Já é membro? ',
    },
    '8lsxlbi9': {
      'en': 'Sign In',
      'pt': 'Entre',
    },
    '98afmct9': {
      'en': 'Home',
      'pt': 'Home',
    },
  },
  // SignIn
  {
    'fktpejcr': {
      'en': 'Welcome Back!',
      'pt': 'Bem vindo de volta!',
    },
    'umn275r3': {
      'en': 'Sign in to continue your journey',
      'pt': 'Faça login para continuar sua jornada',
    },
    'zz420rc0': {
      'en': 'Email Address',
      'pt': 'Endereço de email',
    },
    'fg7n0u26': {
      'en': 'Password',
      'pt': 'Senha',
    },
    'es0qok0p': {
      'en': 'Sign In',
      'pt': 'Entrar',
    },
    '2zlcyxop': {
      'en': 'Forgot Password?',
      'pt': 'Esqueceu sua senha?',
    },
    'rziymeyh': {
      'en': 'Or continue with',
      'pt': 'Ou continue com',
    },
    'jb6zwrtz': {
      'en': 'Google',
      'pt': 'Google',
    },
    '9r6qad8r': {
      'en': 'Apple',
      'pt': 'Apple',
    },
    '9qrauf69': {
      'en': 'Don\'t have an account?',
      'pt': 'Não tem uma conta?',
    },
    's1v8y4za': {
      'en': 'Sign Up',
      'pt': 'Inscrever-se',
    },
    'nnh5sv0f': {
      'en': 'Home',
      'pt': 'Home',
    },
  },
  // Onboarding_Slideshow
  {
    'qaffj8g9': {
      'en': 'Welcome to the Challenge',
      'pt': 'Bem-vindo ao Desafio',
    },
    'dvq8k6lg': {
      'en':
          'Your destination for quality organic food. Here, each product is handpicked to ensure you have access to the best of nature. Accept the challenge of healthier and more sustainable eating!',
      'pt':
          'Seu destino para alimentos orgânicos de qualidade. Aqui, cada produto é escolhido a dedo para garantir que você tenha acesso ao melhor da natureza. Aceite o desafio de uma alimentação mais saudável e sustentável!',
    },
    'lt12kdpa': {
      'en':
          'No Desafio, acreditamos que a alimentação saudável e sustentável é um compromisso com o nosso corpo e o planeta',
      'pt':
          'No Desafio, acreditamos que a alimentação saudável e sustentável é um compromisso com o nosso corpo e o planeta',
    },
    'afqq2gek': {
      'en':
          'Nossa missão é conectar produtores locais com consumidores conscientes, oferecendo produtos frescos, orgânicos e de alta qualidade.',
      'pt':
          'Nossa missão é conectar produtores locais com consumidores conscientes, oferecendo produtos frescos, orgânicos e de alta qualidade.',
    },
    'tmze9jvy': {
      'en': 'Desafie-se a escolher o melhor para você e sua família.',
      'pt': 'Desafie-se a escolher o melhor para você e sua família.',
    },
    '9yy6vzec': {
      'en':
          'Explore agora nosso catálogo de produtos orgânicos e descubra como é fácil comer bem e fazer a diferença!',
      'pt':
          'Explore agora nosso catálogo de produtos orgânicos e descubra como é fácil comer bem e fazer a diferença!',
    },
    'ad9tk3z8': {
      'en': 'Continue',
      'pt': 'Continue',
    },
    '6drb072m': {
      'en': 'Home',
      'pt': 'Home',
    },
  },
  // Onboarding_CreateAccount
  {
    'd9kxnl4m': {
      'en': 'Create an account',
      'pt': 'Crie uma conta',
    },
    'k6wsfs66': {
      'en': 'Full Name',
      'pt': 'Nome completo',
    },
    'ts1baqq2': {
      'en': 'Email',
      'pt': 'E-mail',
    },
    'm7u735dt': {
      'en': 'Password',
      'pt': 'Senha',
    },
    '8lj5610x': {
      'en': 'Confirm password',
      'pt': 'Confirmar senha ',
    },
    'dq9psavc': {
      'en': 'Create Account',
      'pt': 'Criar uma conta',
    },
    'neaawrot': {
      'en': 'Or continue with',
      'pt': 'Ou continue com',
    },
    '05x8r64n': {
      'en': 'Google',
      'pt': 'Google',
    },
    '7j40tyay': {
      'en': 'Apple',
      'pt': 'Apple',
    },
    'rx71348a': {
      'en': 'Already a member?  ',
      'pt': 'Já é membro? ',
    },
    '83ys5mhe': {
      'en': 'Sign In',
      'pt': 'Entre',
    },
    'm4lppm7g': {
      'en': 'Full name is required.',
      'pt': 'O nome completo é obrigatório.',
    },
    'lk9f96e1': {
      'en': 'Please choose an option from the dropdown',
      'pt': 'Escolha uma opção no menu suspenso',
    },
    'iyd781wa': {
      'en': 'Email is required.',
      'pt': 'O e-mail é obrigatório.',
    },
    '3b93m7va': {
      'en': 'Please choose an option from the dropdown',
      'pt': 'Escolha uma opção no menu suspenso',
    },
    'dtyrqbhc': {
      'en': 'Password is required.',
      'pt': 'A senha é obrigatória.',
    },
    '1woik12o': {
      'en': 'Please choose an option from the dropdown',
      'pt': 'Escolha uma opção no menu suspenso',
    },
    '2doh9ka4': {
      'en': 'Confirm password is required',
      'pt': '',
    },
    'z2rj35nk': {
      'en': 'Please choose an option from the dropdown',
      'pt': '',
    },
    'v86fzc5i': {
      'en': 'Home',
      'pt': 'Home',
    },
  },
  // Profile
  {
    'c3kv9o0d': {
      'en': 'Thank you for supporting us!',
      'pt': 'Obrigado por nos apoiar!',
    },
    'kgh51cuf': {
      'en':
          'As a local business, we thank you for supporting us and hope you enjoy.',
      'pt':
          'Como empresa local, agradecemos por nos apoiar e esperamos que goste.',
    },
    'ircptpp9': {
      'en': 'Edit Profile',
      'pt': 'Editar perfil',
    },
    '57x88ouh': {
      'en': 'Sell here',
      'pt': 'Venda aqui',
    },
    '0ncruabu': {
      'en': 'About Us',
      'pt': 'Sobre nós',
    },
    'lij60voe': {
      'en': 'Support Center',
      'pt': 'Centro de suporte',
    },
    '46uk37z7': {
      'en': 'Contact Us',
      'pt': 'Contate-nos',
    },
    'bwl07a9y': {
      'en': 'Share Challege App',
      'pt': 'Compartilhar aplicativo de desafio',
    },
    'gv8a91o1': {
      'en': 'Log out',
      'pt': 'Sair',
    },
    'upjxgphb': {
      'en': 'Profile',
      'pt': 'Perfil',
    },
  },
  // ForgotPassword
  {
    'cm13q2us': {
      'en': 'Forgot password',
      'pt': 'Forgot password',
    },
    'dg7yzmtl': {
      'en': 'We\'ll send you an email to reset your password.',
      'pt': 'Enviaremos um e-mail para você redefinir sua senha.',
    },
    '4clpr9je': {
      'en': 'Email',
      'pt': '\nE-mail',
    },
    'avd910a8': {
      'en': '',
      'pt': '',
    },
    'ngnxh2hm': {
      'en': '',
      'pt': '',
    },
    '6pzz9d4w': {
      'en': 'Email is required.',
      'pt': 'O e-mail é obrigatório.',
    },
    'sctqhtpn': {
      'en': 'Please choose an option from the dropdown',
      'pt': 'Escolha uma opção no menu suspenso',
    },
    '41xxuolz': {
      'en': 'Reset Password',
      'pt': 'Redefinir senhaRedefinir senha',
    },
    'qoxde1fc': {
      'en': 'Home',
      'pt': 'Home',
    },
  },
  // Home
  {
    'txayw2lr': {
      'en': 'Organic Market',
      'pt': 'Mercado  Produtos Orgânico',
    },
    'oacwhof7': {
      'en': 'Search organic products...',
      'pt': 'Pesquisar produtos orgânicos..',
    },
    '6jggbv89': {
      'en': 'Categories',
      'pt': 'Categorias',
    },
    '0fw9n62j': {
      'en': 'Fruits',
      'pt': 'Frutas',
    },
    '754c06t7': {
      'en': 'Vegetables',
      'pt': 'Vegetais',
    },
    'k5y9j0er': {
      'en': 'Dairy',
      'pt': 'Laticínios',
    },
    'u08cjlq4': {
      'en': 'Grains',
      'pt': 'Grãos',
    },
    'g1inj4jo': {
      'en': 'Fruits',
      'pt': 'Frutas',
    },
    '9s18zbzf': {
      'en': 'Filtrar por valor R\$',
      'pt': 'Filtrar por valor R\$',
    },
    'rxi1ipsc': {
      'en': 'MIN',
      'pt': 'MIN',
    },
    'dli5s8ym': {
      'en': 'MAX',
      'pt': 'MAX',
    },
    'segqb6ao': {
      'en': 'Featured Products',
      'pt': 'Produtos em destaque',
    },
    'pel74iko': {
      'en': 'Home',
      'pt': 'Home',
    },
  },
  // Cart
  {
    '11v20y2y': {
      'en': 'Shopping Cart',
      'pt': 'Carrinho de compras',
    },
    'u0a7ya72': {
      'en': 'Review your items',
      'pt': 'Revise seus itens',
    },
    '16j4v45z': {
      'en': 'Add your CEP ',
      'pt': 'Adicione seu CEP',
    },
    'zx1aburi': {
      'en': 'CEP',
      'pt': 'CEP',
    },
    'd30uago4': {
      'en': '0',
      'pt': '0',
    },
    'ejsah2dw': {
      'en': 'Proceed to Checkout',
      'pt': 'Finalizar a compra',
    },
    'ozoj8ug7': {
      'en': 'Continue Shopping',
      'pt': 'Continuar comprando',
    },
    'ee9f7azi': {
      'en': 'Cart',
      'pt': 'Carrinho',
    },
  },
  // NewCard
  {
    'g9u2xpku': {
      'en': 'Payment Method',
      'pt': 'Método de pagamento',
    },
    'snwqgt9z': {
      'en': 'Add your payment details',
      'pt': 'Adicione seus detalhes de pagamento',
    },
    'kizap2r5': {
      'en': 'Credit Card Information',
      'pt': 'Informações do cartão de crédito',
    },
    '3gboegb8': {
      'en': '•••• •••• •••• 4242',
      'pt': '•••• •••• •••• 4242',
    },
    'wtokmh4w': {
      'en': 'Card Holder',
      'pt': 'Titular do cartão',
    },
    '28rzi7fr': {
      'en': 'JOHN DOE',
      'pt': 'JOHN DOE',
    },
    'sqfmh203': {
      'en': 'Expires',
      'pt': 'Expira',
    },
    'rcaxcwwi': {
      'en': '12/25',
      'pt': '12/25',
    },
    'eqvqevxj': {
      'en': 'Card Number',
      'pt': 'Número do cartão',
    },
    '15anhpqc': {
      'en': 'Expiration Date',
      'pt': 'Expiration Date',
    },
    'z0ivtxnw': {
      'en': 'CVV',
      'pt': 'CVV',
    },
    '78i4bpl9': {
      'en': 'Card Holder Name',
      'pt': 'Nome do Titular',
    },
    'dufs10on': {
      'en': 'Pay Now',
      'pt': 'Pay Now',
    },
  },
  // Checkout
  {
    '4226nr7f': {
      'en': 'Checkout',
      'pt': 'Confira',
    },
    'fg0g5u5u': {
      'en': 'Complete your order',
      'pt': 'Conclua seu pedido',
    },
    'r153cop7': {
      'en': 'Delivery Address',
      'pt': 'Delivery Address',
    },
    'hl0oddk7': {
      'en': 'Street Address',
      'pt': 'Endereço da Rua',
    },
    'hr3h49lt': {
      'en': 'Neighborhood',
      'pt': 'Bairro',
    },
    'qq9uv4ow': {
      'en': 'City',
      'pt': 'Cidade',
    },
    '1wef24cy': {
      'en': 'Postal Code',
      'pt': 'CEP',
    },
    '3u8euuhj': {
      'en': ' Number',
      'pt': 'Número',
    },
    '2gyuntvd': {
      'en': 'Complement',
      'pt': 'Complemento',
    },
    'fswd2gwp': {
      'en': ' ',
      'pt': '',
    },
    '7mpq1uy0': {
      'en': 'Payment Method',
      'pt': 'Payment Method',
    },
    'mwexoeio': {
      'en': 'Credit Card',
      'pt': 'Cartão de crédito',
    },
    'kg0rsicn': {
      'en': 'Pix',
      'pt': 'Pix',
    },
    '1mbr7mup': {
      'en': 'Add bank account',
      'pt': 'Adicionar conta bancária',
    },
    'n7kv0r57': {
      'en': 'Place Order',
      'pt': 'Fazer pedido',
    },
  },
  // PaymentConfirmation
  {
    'kdgl544k': {
      'en': 'Payment Successful!',
      'pt': 'Pagamento realizado com sucesso!',
    },
    'lroux9kj': {
      'en': 'Your order has been confirmed',
      'pt': 'Seu pedido foi confirmado',
    },
    'un8mii59': {
      'en': 'Order Details',
      'pt': 'Detalhes do pedido',
    },
    '22bbgse2': {
      'en': 'Order Number:',
      'pt': 'Número do pedido:',
    },
    'maj91pxy': {
      'en': '#ORD-2023-1234',
      'pt': '#ORD-2023-1234',
    },
    'sq0vnm5e': {
      'en': 'Amount Paid:',
      'pt': 'Valor pago:',
    },
    'ye08mstg': {
      'en': 'Payment Method:',
      'pt': 'Método pagamento:',
    },
    'fbi7jtsw': {
      'en': ' Card ****1234',
      'pt': ' Card ****4242',
    },
    'veo22az1': {
      'en':
          'A confirmation email has been sent to your registered email address',
      'pt':
          'Um e-mail de confirmação foi enviado para o seu endereço de e-mail cadastrado',
    },
    'qb0sleez': {
      'en': 'View Order Details',
      'pt': 'Ver detalhes do pedido',
    },
    'ppc6l0p4': {
      'en': 'Continue Shopping',
      'pt': 'Continuar comprando',
    },
  },
  // EditProfile
  {
    'kwzamqwr': {
      'en': 'Edit Profile',
      'pt': 'Editar perfil',
    },
    'rmr3br9s': {
      'en': 'Personal Information',
      'pt': 'Informações pessoais',
    },
    'gtx3654c': {
      'en': 'Full Name',
      'pt': 'Nome completo',
    },
    '5zt5h7oh': {
      'en': 'Email',
      'pt': 'E-mail',
    },
    'mcrfcz3p': {
      'en': 'Phone Number',
      'pt': 'Número de telefone',
    },
    'w2w1l3mb': {
      'en': 'Address Information',
      'pt': 'Informações de endereço',
    },
    '9o3yx17g': {
      'en': 'Street Address',
      'pt': 'Endereço da Rua',
    },
    '3v1avinz': {
      'en': 'City',
      'pt': 'Cidade',
    },
    'ys4gck2h': {
      'en': 'State',
      'pt': 'Estado',
    },
    'w72haaxm': {
      'en': 'CEP Code',
      'pt': 'CEP',
    },
    '3zifmq9k': {
      'en': 'Preferences',
      'pt': 'Preferências',
    },
    '5w07f9gg': {
      'en': 'Enable Notifications',
      'pt': 'Habilitar notificações',
    },
    'pyqqehae': {
      'en': 'Dark Mode',
      'pt': 'Modo escuro',
    },
    'dn4qniko': {
      'en': 'Save Changes',
      'pt': 'Salvar alterações',
    },
  },
  // SellHere
  {
    '672wwy5x': {
      'en': 'Business Center',
      'pt': 'Centro de Negócios',
    },
    'ka5ydqs3': {
      'en': 'Business Information',
      'pt': 'Informações comerciais',
    },
    't7n2388q': {
      'en': 'Business Name',
      'pt': 'Nome comercial',
    },
    'ekugbqjs': {
      'en': 'Business Description',
      'pt': 'Descrição do negócio',
    },
    'vgi3w078': {
      'en': 'Phone',
      'pt': 'Telefone',
    },
    'wy9jj9sz': {
      'en': 'Email',
      'pt': 'E-mail',
    },
    'yq8gnzkj': {
      'en': 'Street Address',
      'pt': 'Endereço da Rua',
    },
    'odkptgwm': {
      'en': 'Neighborhood',
      'pt': 'Bairro',
    },
    'keygg7z0': {
      'en': 'City',
      'pt': 'Cidade',
    },
    '3o69fcku': {
      'en': 'Postal Code',
      'pt': 'CEP',
    },
    'xanbzhvx': {
      'en': 'Upload Business Logo',
      'pt': 'Carregar logotipo comercial',
    },
    'gzeoh59a': {
      'en': 'Products',
      'pt': 'Produtos',
    },
    'r8e93ggp': {
      'en': 'Add Product',
      'pt': 'Adicionar produto',
    },
    'aia8aq5c': {
      'en': 'Artisanal Sourdough Bread',
      'pt': 'Pão Fermentado Artesanal',
    },
    'ow9hd3fb': {
      'en': '\$8.99',
      'pt': '\$8.99',
    },
    's76foxl4': {
      'en': 'Butter Croissant',
      'pt': 'Croissant De Manteiga',
    },
    '156f6uyy': {
      'en': '\$4.99',
      'pt': '\$4.99',
    },
    '79zqzrp6': {
      'en': 'Save Changes',
      'pt': 'Salvar alterações',
    },
  },
  // AddProduct
  {
    '052vm4qf': {
      'en': 'Add Product',
      'pt': 'Adicionar produto',
    },
    'z9ft6rdr': {
      'en': 'Add Product Images',
      'pt': 'Adicionar imagens de produtos',
    },
    '0ce5r1tg': {
      'en': 'Product Details',
      'pt': 'Detalhes do produto',
    },
    'v24fml3q': {
      'en': 'Product Name',
      'pt': 'Nome do produto',
    },
    'tgch167f': {
      'en': 'Description',
      'pt': 'Descrição',
    },
    'prh1xzol': {
      'en': 'Price',
      'pt': 'Preço',
    },
    'rb5c8lbn': {
      'en': 'Quantity',
      'pt': 'Quantidade',
    },
    'beesmh1f': {
      'en': 'Category',
      'pt': 'Categoria',
    },
    'f4nhlbeh': {
      'en': 'Select...',
      'pt': '',
    },
    'ufyyv4e7': {
      'en': 'Search...',
      'pt': '',
    },
    'vdq05ivr': {
      'en': 'Add Product',
      'pt': 'Adicionar produto',
    },
  },
  // DashbordSell
  {
    'ra5y5dvs': {
      'en': 'Total de Vendas',
      'pt': 'Total de Vendas',
    },
    '1fnz3ga9': {
      'en': 'R\$ 87.532,19',
      'pt': 'R\$ 87.532,19',
    },
    'a4apeal7': {
      'en': 'Meta Mensal: R\$ 100.000,00',
      'pt': 'Meta Mensal: R\$ 100.000,00',
    },
    '3oyr6xmf': {
      'en': '+12% este mês',
      'pt': '+12% este mês',
    },
    'r2tnxo2h': {
      'en': 'Produtos',
      'pt': 'Produtos',
    },
    'djsvycpq': {
      'en': 'Estoque',
      'pt': 'Estoque',
    },
    'pxm5au4t': {
      'en': 'Relatórios',
      'pt': 'Relatórios',
    },
    '7umnrqtj': {
      'en': 'Vendas Recentes',
      'pt': 'Vendas Recentes',
    },
    'umi8dap1': {
      'en': 'Ver Todas',
      'pt': 'Ver Todas',
    },
    'd8hftg2w': {
      'en': 'Smartphone XYZ',
      'pt': '',
    },
    '2h8nowk9': {
      'en': '15 Mai 2023',
      'pt': '',
    },
    'sbswhm51': {
      'en': 'R\$ 2.499,00',
      'pt': '',
    },
    'lb5wjnb2': {
      'en': 'Desempenho por Categoria',
      'pt': '',
    },
    'hqeb4xh8': {
      'en': 'Eletrônicos',
      'pt': '',
    },
    '8s876l93': {
      'en': '45% das vendas',
      'pt': '',
    },
    'hgsazars': {
      'en': 'Acessórios',
      'pt': '',
    },
    'wu6xq44s': {
      'en': '30% das vendas',
      'pt': '',
    },
    'tqku1ij3': {
      'en': 'Games',
      'pt': '',
    },
    'mbnn1xw1': {
      'en': '25% das vendas',
      'pt': '',
    },
  },
  // Costs
  {
    '3akoz3rx': {
      'en': 'Order Summary',
      'pt': 'Resumo do pedido',
    },
    '6g8bk1ie': {
      'en': 'Subtotal',
      'pt': 'Subtotal',
    },
    'iw9wwb13': {
      'en': 'Delivery Fee',
      'pt': 'Taxa de entrega',
    },
    'p03g1qgi': {
      'en': 'Total',
      'pt': 'Total',
    },
  },
  // Menu
  {
    'iapewf6y': {
      'en': 'Home',
      'pt': 'Home',
    },
    'uh90w98b': {
      'en': 'Cart',
      'pt': 'Carrinho',
    },
    'giz4z43q': {
      'en': 'Profile',
      'pt': 'Prefil',
    },
  },
  // productDetails
  {
    'q3mgt85v': {
      'en': 'Premium Collection',
      'pt': 'Coleção Premium',
    },
    's0kuwvi9': {
      'en': 'Availability: ',
      'pt': 'Disponibilidade: ',
    },
    'g5mptq0g': {
      'en': '100KG',
      'pt': '100KG',
    },
    'agyaxnfe': {
      'en': 'Description',
      'pt': 'Description',
    },
    'mqnigf21': {
      'en':
          'Crafted with genuine Italian leather and Swiss movement, this elegant timepiece combines classic design with modern functionality. Features include water resistance up to 50m, sapphire crystal glass, and a 5-year warranty.',
      'pt':
          'Crafted with genuine Italian leather and Swiss movement, this elegant timepiece combines classic design with modern functionality. Features include water resistance up to 50m, sapphire crystal glass, and a 5-year warrant',
    },
    'nppn783t': {
      'en': 'Add to Cart',
      'pt': 'Add to Cart',
    },
    'r1aiiyvl': {
      'en': '♡',
      'pt': '♡',
    },
  },
  // Miscellaneous
  {
    '6206abr1': {
      'en': '',
      'pt': '',
    },
    'r1nvfjgp': {
      'en':
          'MealPlanner needs to send you notifications about meal updates and other important messages.',
      'pt': '',
    },
    'nomyccrb': {
      'en': 'obrigado',
      'pt': '',
    },
    'sgqqgscx': {
      'en': '',
      'pt': '',
    },
    'n92be62l': {
      'en': '',
      'pt': '',
    },
    '1ecm4fwf': {
      'en': '',
      'pt': '',
    },
    'qsk3eku9': {
      'en': '',
      'pt': '',
    },
    'q8rm2xva': {
      'en': '',
      'pt': '',
    },
    'uzlgqtgw': {
      'en': '',
      'pt': '',
    },
    's9jc94lf': {
      'en': '',
      'pt': '',
    },
    'ch4pfpm9': {
      'en': '',
      'pt': '',
    },
    'avz1nxja': {
      'en': '',
      'pt': '',
    },
    'b881mhco': {
      'en': '',
      'pt': '',
    },
    'vkcf4922': {
      'en': '',
      'pt': '',
    },
    'ehkwxexf': {
      'en': '',
      'pt': '',
    },
    'qhs01vlu': {
      'en': '',
      'pt': '',
    },
    'alnuvjrk': {
      'en': '',
      'pt': '',
    },
    'g9d4iu6q': {
      'en': '',
      'pt': '',
    },
    'kr9uvcb1': {
      'en': '',
      'pt': '',
    },
    '0waui4s1': {
      'en': '',
      'pt': '',
    },
    'tkveptrz': {
      'en': '',
      'pt': '',
    },
    '598ndygu': {
      'en': '',
      'pt': '',
    },
    'c5ztd9b8': {
      'en': '',
      'pt': '',
    },
    'zkrbpdro': {
      'en': '',
      'pt': '',
    },
    'jd2pv8zc': {
      'en': '',
      'pt': '',
    },
    'oy9r5abg': {
      'en': '',
      'pt': '',
    },
    'hmzlukad': {
      'en': '',
      'pt': '',
    },
    'ymqqblgd': {
      'en': '',
      'pt': '',
    },
  },
].reduce((a, b) => a..addAll(b));
