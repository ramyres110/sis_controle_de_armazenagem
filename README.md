# Sistema de Controle de Armazenagem de Grãos

## Caso de Uso
Uma determinada empresa de armazenagem, precisa desenvolver uma ferramenta para gestão de grãos armazenados em seus silos. Basicamente os produtores rurais enviam seus grãos para serem armazenados, e vendidos posteriormente.

O funcionamento do processo de armazenagem é simples:
1. inicialmente o caminhão com o grão entra dentro do armazém e para sobre a primeira balança de pesagem, onde um funcionário verifica seu peso bruto com a carga presente e informa no sistema. 
2. Depois o caminhão vai para a área de avaliação de umidade do grão onde outro funcionário coleta amostras da carga e calcula o percentual de umidade desta.
3. Por fim o caminhão descarrega os grãos no silo e segue para a última balança onde é realizado a pesagem sem o grão e assim efetuar a diferença de peso para saber quantos quilos de grãos foram depositados no armazém.

Com base na descrição do processo acima será necessário criar um sistema que controle este processo de pesagem, amostras e pesagem tudo isso registrado por meio de contrato. 

Também será necessário disponibilizar uma API onde terceiros poderão consultar a lista de contratos bem como permitir que um contrato seja validado.

## Regra de pesagem
Esta regra será utilizada para calcular o peso final do grão armazenado e seu valor. 

Considere:
- PF (Peso final), 
- PI (Peso inicial), 
- PH (Percentual de umidade), 
- PA (Peso final de armazenagem), 
- VT (Valor total) e 
- PQ (Preço do quilo do Grão informado no cadastro). 

Segue abaixo regra de cálculo dos valores: 
- PA = (PF – PI) * (1 – (PH / 100) 
- VT = PA * PQ

## Pesquisa 
- Terminologia utilizada pelo INMETRO
    - **Amostra**: porção representativa de um lote ou do volume do qual foi retirada
    - **Conteúdo de umidade (U)**: massa de água contida na massa original de uma amostra. 
    - **Percentual do conteúdo de umidade (% U)**: refere-se ao percentual de massa de água na amostra em relação à massa total da amostra.
- Unidade de Medida de Aparelhos  
    - A medição do **conteúdo de umidade** de grãos e sementes deve ser indicada por uso do **percentual do conteúdo de umidade (% U)**.


## Referências
1. 
1. INMETRO. **Portaria Inmetro nº 217, de 26 de abril de 2012**. Disponível em <<http://www.inmetro.gov.br/legislacao/rtac/pdf/RTAC001817.pdf>>. Acessado em 20 de maio de 2020.
1. Charles R. Hurburgh, Jr.**Soybean Drying and Storage**. IOWA State University. Disponível em <<https://www.extension.iastate.edu/grain/files/Migrated/soybeandryingandstorage.pdf>>. Acessado em 20 de maio de 2020.
1.