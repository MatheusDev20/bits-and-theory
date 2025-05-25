class Engine {
  start() {
    console.log('Engine Started')
  }
}

class Wheels {
  rotate() {
    console.log('Wheels Rotating')
  }
}

class Car {
  private engine: Engine;
  private wheels: Wheels

  constructor(engine: Engine, wheels: Wheels) {
    this.engine = engine
    this.wheels = wheels
  }

  drive(): void {
    this.engine.start()
    this.wheels.rotate()
  }
}

const engine = new Engine();
const wheels = new Wheels();
const car = new Car(engine, wheels);
car.drive(); // Output: Engine started, Wheels rolling
