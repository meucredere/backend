Backend Credere test
===

## Getting started

To setup the project you'll need this following technology and version:

- Ruby - 2.7.0

Now you can just clone this project and run:
- `bundle install`
- `rails db:create`
- `rails db:migrate`
- `rails s`

The last command will run the server in: http://localhost:3000

API endpoints
---

**OBS: Remember to always use http://localhost:3000 and the complements below**

### GET /api/v1/probes/current_position

This endpoint will return the probe current position something like that:

    {
        "x": 0,
        "y": 0,
        "face": "D"
    }

This return is an example if you request that endpoint after reseting the probe or just did not move it.

### GET /api/v1/probes/reset

This endpoint will restore back the probe default values and return the current position

    {
        "x": 0,
        "y": 0,
        "face": "D"
    }

### POST /api/v1/probes/move

This endpoint will execute the movements that you requested and return the new positin with a brief description, examples:

If you request:

    {
        "movimentos": ["M", "M", "M", "GE", "M", "M"]
    }
    
Your return will be:

    {
      "x": 3,
      "y": 2,
      "description": "A sonda moveu 3 casa(s) no eixo x, girou para a esquerda 1 veze(s) e moveu 2 casa(s) no eixo y"
    }
    
But if you request the probe to move more than 4 steps or move beyond the limit, you will receive an error:

    {
        "movimentos": ["M", "M", "M", "M", "M"]
    }
    
or

    {
        "movimentos": ["GD", "M"]
    }
    
or

    {
        "movimentos": ["GE", "GE", "M"]
    }

**Obs: These last two examples we are considering the default values (after reset)**

The return will be:

    {
        "erro": "Um movimento inválido foi detectado, infelizmente a sonda não foi capaz de finalizar todos os movimentos"
    }

But the probe will move until the limit it can move, example:

    {
        "movimentos": ["M", "M", "M", "M", "M"]
    }

After that if you request for the current position you will receive:

    {
        "x": 4,
        "y": 0,
        "face": "D"
    }

Unit tests
---

To execute the unit tests just run:
`rspec`

And all specs will be executed automatically.

The specs were made with Rspec gem.
