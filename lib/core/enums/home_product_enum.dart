enum HomeProduct {
  automobile(
    title: 'Seguro Automóvel',
    url: 'https://www.tokiomarine.com.br/seguros-automoveis',
  ),
  residence(
    title: 'Seguro Residencial',
    url: 'https://www.tokiomarine.com.br/seguros-residenciais/seguro-residencial',
  ),
  life(
    title: 'Seguro de Vida',
    url: 'https://www.tokiomarine.com.br/seguros-vida/seguro-vida',
  ),
  personalAccident(
    title: 'Acidentes Pessoais',
    url: 'https://www.tokiomarine.com.br/seguros-acidentes/seguro-acidentes-pessoais-individual',
  );

  const HomeProduct({required this.title, required this.url});

  final String title;
  final String url;
}
