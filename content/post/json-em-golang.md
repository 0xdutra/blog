---
author: Gabriel Dutra
title: Como codificar e codificar objetos JSON em Golang 
date: "2021-02-07"
tags: [
    "Golang"
]
categories: [
    "Programação"
]

archives: "02/2021"
---

Como utilizar JSON em Golang de forma nátiva e fácil.
<!--more-->

## JSON

JSON, um acrônimo de JavaScript Object Notation, é um formato compacto, de padrão aberto independente, de troca de dados simples e rápida entre sistemas, especificado por Douglas Crockford em 2000, que utiliza texto legível a humanos, no formato atributo-valor.

Fonte: Wikipédia

## Utilizando em Go

O pacote `encoding/json` permite codificarmos e decoficarmos um JSON, utilizando as funções `Marshal` e `Unmarshal`.

### Convertendo struct para JSON

Go é uma linguagem extremamente simplista e para trabalhar com JSON não é uma excesão, podemos utilizar structs para definir a estrutura do JSON.

### Exemplo

```go
package main

import (
    "fmt"
    "encoding/json"
)

type Person struct {
    Name string `json:"name"`
    Age  int    `json:"age"`
}

func main() {
    ...    
}
```

Note os valores entre crases, eles serão as chaves do JSON. Continuando com o exemplo, vamos utilizar a função `Marshal` para criarmos o JSON.

```go
package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
)

type Person struct {
	Name string `json:"name"`
	Age  int    `json:"age"`
}

func main() {
	p := Person{"Gabriel Dutra", 21}

	personJSON, err := json.Marshal(p)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(bytes.NewBuffer(personJSON))
}
```

Outro ponto, a função `Marshal` retorna um array de bytes, para podermos printar os valores na tela é necessário utilizarmos a função `NewBuffer` do pacote `bytes`.

## Decodificando um JSON

Na decodificação de um JSON, precisamos criar um `struct` que irá armazenar os dados que estão contidos
no JSON.

```go
package main

import (
	"encoding/json"
	"fmt"
	"log"
)

type Person struct {
	Name string `json:"name"`
	Age  int    `json:"age"`
}

func main() {
	personJSON := `
    {
        "name":"Gabriel Dutra",
        "age":21
    }`

	var person Person

	err := json.Unmarshal([]byte(personJSON), &person)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(person.Name)
	fmt.Println(person.Age)
}
```

As chaves `name` e `age` são imputados nas variáveis `Name` e `Age` da struct Person. As variáveis devem
sempre ficar com a primeira letra em maiúsculo, essa é a forma do Go criar variáveis globais.
