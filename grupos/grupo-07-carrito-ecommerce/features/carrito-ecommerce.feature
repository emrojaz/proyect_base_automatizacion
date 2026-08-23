# Grupo 07 — Carrito de Compras / E-commerce
# Módulo: Checkout de un e-commerce
#
# Completar los escenarios BDD de este módulo.
# Ver ENTREGABLES.md: mínimo 3 escenarios (1 happy path, 1 negativo, 1 edge case).

Feature: Carrito de Compras / E-commerce

  Scenario: Calcular el total del carrito con multiples productos
    Given el usuario tiene los siguientes productos en el carrito:
      | producto   | cantidad | precio  |
      | Zapatillas | 1        | 250000  |
      | Medias     | 2        | 15000   |
      | Remera     | 1        | 80000   |
    When el sistema calcula el total del carrito
    Then el total debe ser 360000

  # TODO: Scenario: caso negativo
  # TODO: Scenario: edge case


Feature: Agregar producto en stock al carrito

Como usuario del e-commerce
Quiero agregar productos disponibles al carrito
Para realizar una compra de los productos seleccionados

# Scenario: happy path - Armin Avezada Aquino
Scenario: Agregar producto disponible al carrito
Given el usuario se encuentra en la página de productos
And existe un producto disponible con stock
When selecciona el producto y lo agrega al carrito
Then el producto debe ser agregado correctamente al carrito
And la cantidad del producto en el carrito debe ser 1
And el stock disponible del producto debe actualizarse correctamente

# Scenario: caso negativo - Armin Avezada Aquino
Scenario: Intentar agregar un producto sin stock al carrito
Given el usuario se encuentra en la página de productos
And existe un producto sin stock disponible
When intenta agregar el producto al carrito
Then el producto no debe ser agregado al carrito
And debe visualizar un mensaje indicando que el producto no está disponible

# Scenario: edge case- Armin Avezada Aquino
Scenario: Agregar al carrito la cantidad máxima disponible en stock
Given el usuario se encuentra en la página de productos
And existe un producto con una cantidad limitada de stock
When agrega al carrito una cantidad igual al stock disponible
Then el producto debe ser agregado correctamente al carrito
And la cantidad agregada debe coincidir con el stock disponible
And el producto no debe permitir agregar una cantidad superior al stock disponible


Feature: Eliminar producto del carrito   - Andrea Escurra
  Como cliente del e-commerce
  quiero eliminar productos de mi carrito
  para ajustar mi compra antes del checkout

  Scenario: Eliminar un producto existente del carrito (happy path)   - Andrea Escurra
    Given el carrito contiene "Auriculares Bluetooth" con cantidad 1
    When elimino el producto "Auriculares Bluetooth" del carrito
    Then el producto ya no se lista en el carrito
    And se muestra el mensaje "Tu carrito esta vacio"

  Scenario: Intentar eliminar un producto inexistente en el carrito (caso negativo)   - Andrea Escurra
    Given el carrito contiene solo "Teclado USB"
    When intento eliminar el producto "Mouse Gamer" que no esta en el carrito
    Then el sistema muestra el error "El producto no existe en el carrito"
    And el carrito conserva el producto "Teclado USB"

  Scenario: Doble clic en eliminar sobre un producto ya removido (edge case)   - Andrea Escurra
    Given el carrito contiene solo "Cable HDMI"
    When elimino el producto "Cable HDMI" del carrito
    And hago doble clic sobre el boton eliminar del item ya removido
    Then el sistema no muestra errores
    And el carrito permanece vacio con total 0

Feature: Aplicar cupón de descuento   - Emilio Rojas

  Como cliente del e-commerce
  quiero utilizar cupones de descuento
  para reducir el monto total de mi compra

  Scenario: Aplicar un cupón de descuento válido (happy path)   - Emilio Rojas
    Given el carrito tiene productos por valor de 200000
    And el usuario posee un cupón de descuento válido del 10%
    When aplica el cupón de descuento
    Then el descuento se aplica correctamente
    And el total del carrito se actualiza con el descuento

  Scenario: Intentar aplicar un cupón de descuento vencido (caso negativo)   - Emilio Rojas
    Given el carrito tiene productos por valor de 200000
    And el usuario posee un cupón de descuento vencido
    When aplica el cupón de descuento
    Then el sistema muestra el mensaje "El cupón ha expirado"
    And el total del carrito no se modifica

  Scenario: Aplicar un cupón cuando el monto es exactamente el mínimo requerido (edge case)   - Emilio Rojas
    Given el carrito tiene productos por valor de 300000
    And el usuario posee un cupón de descuento válido
    And el cupón requiere una compra mínima de 300000
    When aplica el descuento
