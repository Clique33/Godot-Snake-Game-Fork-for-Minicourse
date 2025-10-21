# 🎮 Plano de Aula do Minicurso: Desenvolvimento de Jogo 2D com Godot

## 🎯 Objetivo Geral
Apresentar, de forma prática e progressiva, os principais conceitos e ferramentas da **Godot Engine** através do desenvolvimento completo de um jogo 2D no estilo *Classic Snake*, baseado no projeto anterior de **Awfyboy** - [Awfyboy/Godot-Snake-Game](https://github.com/Awfyboy/Godot-Snake-Game) (de onde este projeto fez fork).  
O foco é compreender as principais estruturas de nós (*Nodes*), o uso de scripts em GDScript e a lógica de construção de cenas interativas.

O projeto deve ser iniciado a partir do [commit inicial](https://github.com/Clique33/Godot-Snake-Game-Fork-for-Minicourse/commit/b63e0034496f845ebc79e29c6d22d172f49d161e)

---

## 🧩 Módulo 1 — Mecânicas Básicas do Jogo

### 🧠 Cena da Cabeça (*Head*)

1. **Introdução ao conceito de Node**
   - Explicar o que é um **Node** e as diferenças entre `Node`, `Node2D`, `Node3D` e `Control`.
   - Criar uma nova cena chamada **Head**, utilizando um `Node2D` como nó raiz, dentro da pasta `scenes`.

2. **Explorando o Transform e o Sprite**
   - Adicionar um nó `Sprite` à cena **Head**.
   - Demonstrar como manipular o *transform* de um `Node2D` (posição, rotação e escala).

3. **Funções Built-in**
   - Apresentar as principais funções de ciclo de vida:  
     `_ready()`, `_process()`, `_physics_process()`, `_input()` e `_unhandled_input()`.  
   - Utilizar `print()` para ilustrar a execução dessas funções durante o jogo.

4. **Movimentação**
   - Criar uma cena de teste na pasta `scenes/test` para experimentar a movimentação da cabeça.  
   - Alterar o nó raiz de **Head** para `CharacterBody2D`, permitindo o uso de `move_and_slide()`.  
   - Explicar o uso de `Vector2`, da variável `velocity` e do método `move_and_slide()`.

5. **Mapeamento de Input**
   - Introduzir o *Input Map* do Godot.  
   - Implementar movimentação em quatro direções, inicialmente com a possibilidade de ir para direções opostas (erro intencional para posterior correção).
   - Demonstrar o uso de `_unhandled_input()` sem `get_vector()` e, em seguida, com `get_vector()`.  
   - Aplicar multiplicação por `speed` e `delta` para controlar a velocidade.  
   - Finalizar impedindo movimentações em direções opostas.

#### Estado final:

1. **Cenas**
    - head.tscn:
       - Raíz `CharacterBody2D` e um `Sprite2D` como filho
    - test_head.tscn:
       - Raíz `Node2D` e um `Head` como filho
      
2. **Atributos**
    - head.gd:
       - `possible_directions`: um vetor com as quatro direções básicas de Vector2
       - `speed`: um float a ser multiplicado pela direção para alterar a velocidade do movimento
       - `direction_of_movement`: `Vector2` usado para indicar a direção atual do movimento
      
3. **Métodos**
    - head.gd:
       - `_process` setando `velocity` e chamando `move_and_slide`
       - `_unhandled_input` usando `get_vector` para setar direção do movimento    

---

### 🍎 Cena da Comida (*Food*)

1. Criar a cena **Food** como `Node2D`.  
2. Adicionar uma cena de teste em `scenes/test`, contendo **Head** e **Food**.  
3. Introduzir o conceito de **colisões**:
   - Adicionar um `Area2D` e um `CollisionShape2D` em **Food** e um `CollisionShape2D` em **Head**.
4. Explicar o uso de **sinais** (*Signals*) no Godot.
5. Criar o script de **Food** e associá-lo à cena.
6. Demonstrar a detecção de colisão entre `Area2D` e `CharacterBody2D`.
7. Implementar o consumo da comida ao colidir, emitindo o sinal `food_eaten(Food)`.

---

### 🧺 Cena do Spawner de Comida (*FoodSpawner*)

1. Criar a cena **FoodSpawner** como um `Node` simples e associar um script.  
2. Explicar o conceito de *Spawner* (gerador de objetos).  
3. Criar uma cena de teste em `scenes/test` para o spawner.  
4. Implementar a lógica de:
   - Escolher um local aleatório dentro de limites definidos (`limit_minimum` e `limit_maximum`);
   - Instanciar **Food** no local (`global_position`) e conectar seus sinais;
   - Continuar gerando até o número máximo especificado.
5. Introduzir o uso de **variáveis exportadas** (`@export`) para permitir ajustes no editor:
   - `Head.speed`
   - `FoodSpawner.maximum_concurrent_foods`
   - `FoodSpawner.limit_minimum`
   - `FoodSpawner.limit_maximum`

---

### 🏞️ Cena do Campo (*Field*)

1. Criar a cena **Field** como `Node2D`.  
2. Desenvolver uma cena de teste em `scenes/test`.  
3. Explicar o uso de **TileMapLayer** e a criação de um **TileSet** a partir do ícone do Godot.  
4. Demonstrar a pintura de tiles e o uso de *patterns*.  
5. Criar bordas no mapa e definir colisões.  
6. Implementar a condição de derrota ao bater nas laterais:
   - Conectar sinais de colisão para reiniciar a cena de teste.
7. Explicar a noção de `call_deferred` e alterar add_child do spawner e reload para utilizá-la. 

---

### 🕹️ Cena Principal do Jogo (*Main*)

1. Criar a cena **Main** como `Node` e defini-la como cena principal do projeto.  
2. Adicionar **Field**, **Head** e **FoodSpawner**:
   - Ajustar tamanho e posição da cabeça.
   - Configurar variáveis do spawner.
   - Ligar o sinal de **Field** para reiniciar ao morrer.
3. Implementar o **sistema de pontuação (score)**:
   - Conectar o sinal de **FoodSpawner** para atualizar o score sempre que uma comida é consumida.
   - Printar no console a cada atualização 
4. Implementar o **sistema de tempo (timer)**:
   - Exibir o tempo total ao morrer e durante o jogo.
   - Utilizar `Timer` e, se possível, um `TimeManager` para obter timestamps.
5. Exibir **tempo e pontuação** através de `Label`s (introdução à criação da interface gráfica).

---

## 🧱 Módulo 2 — Interface do Usuário (UI)

### 💡 Cena da HUD (*Heads-Up Display*)

1. Criar a cena **Hud** como `Control` e introduzir brevemente esse tipo de nó.  
2. Criar bordas utilizando `ColorRect`.  
3. Estruturar a interface com `HSplitContainer` e `HBoxContainer` para organizar elementos.  
4. Adicionar `Labels` de pontuação e tempo.  
5. Transferir o código de exibição de tempo e pontuação da **Main** para a **Hud**.  
6. Reorganizar as bordas de **Field** para acomodar a HUD.  
7. Explicar o conceito de **CanvasLayer** e adicioná-lo para separar visualmente o jogo e a interface.

---

### 🕯️ Cena de Fim de Jogo (*EndScreen*)

1. Criar a cena **EndScreen** como `Control`.  
2. Criar um fundo escurecido com `ColorRect` (preto, semitransparente).  
3. Adicionar um `VBoxContainer` com `Labels` para:
   - Game Over
   - Pontuação final
   - Tempo total
   - Mensagem para reiniciar
4. Criar um script com uma função para ser chamada ao mostrar a tela, setando as labels e tornando a tela visível.  
5. Introduzir o uso do **modo de pausa** e dos **modos de processo** (`Node.process_mode`).

---

## 🎨 Módulo 3 — Experiência do Usuário (UX)

1. Adicionar uma pasta com **assets** visuais e sonoros.  
2. Personalizar a interface e o jogo:
   - Adicionar fontes aos `Labels`.
   - Adicionar efeitos sonoros:
     - Som “Turn” na **Head**;
     - Som “Eat” na **Main**;
     - Som “Lose” na **EndScreen**.
   - Adicionar sprites para a cabeça e a maçã.
   - Rotacionar o sprite da cabeça.
   - Alterar o **Field** com um sprite de piso (*Floor*).
   - Personalizar o fundo da HUD com `ColorPicker`.
   - Exibir o ícone da maçã na HUD.

---

## 🐍 Próximas Features — Etapa 1

### 📏 Movimentação e Spawn Alinhados à Grade

1. Definir **vetores de offset inicial** e **grid_size** para alinhar os elementos à grade do jogo.  
2. Ajustar o spawner para gerar posições *snapadas* (`snapped()`) com base na grade.  
3. Alterar `move_and_slide()` para atualizar manualmente a `position`.  
4. Criar uma propriedade para armazenar a **próxima direção**.  
5. Permitir mudança de direção apenas quando a cabeça estiver alinhada à grade.

---

## 🧬 Próximas Features — Etapa 2

### 🪱 Implementação da Cobra com Segmentos

1. Criar a cena **Segment** como `Node2D` contendo `Sprite` e `Area2D` (para *hitbox*).  
2. Adicionar um `Timer` com `AutoStart` e `one_shot` em **Segment**.  
3. Criar script que:
   - Habilita o segmento a ser atingido pela cabeça após o *timeout* (`is_hittable_by_head`);
   - Emite o sinal `head_hit` se a cabeça colidir após o tempo limite;
   - Ignora colisão com os três primeiros segmentos.  
4. Criar a cena **Snake** com um `Node2D` de segmentos e a **Head**.  
5. Implementar funções para:
   - Adicionar novos segmentos;
   - Conectar sinais de colisão;
   - Atualizar posições dos segmentos com base na cabeça.  
6. Conectar o sinal de mudança de direção da cabeça para atualizar os segmentos.  
7. Adicionar derrota ao colidir com os segmentos na cena **Main**.

---

## 🚫 Próximas Features — Etapa 3

### 🧭 Prevenção de Spawn Dentro da Cobra
- Impedir que **Food** seja criada em posições ocupadas pelos segmentos da cobra.

### 🎛️ Display de Input
- Exibir visualmente as direções de entrada do jogador (setas, teclas ou toques).

---

## 🧠 Encerramento

O minicurso culmina na criação de um jogo funcional e extensível, oferecendo uma visão abrangente do ciclo de desenvolvimento em Godot — desde a estrutura de nós até a integração de interface, áudio e lógica de jogo.  
A estrutura modular permite que os alunos compreendam os conceitos de forma incremental e apliquem o aprendizado em projetos próprios.
