//: Playground - noun: a place where people can play

import UIKit
import RxSwiftExercises
import RxSwift


let disposeBag = DisposeBag()

// MARK: - Exercício 01
Observable.just("🦋")
    .subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)


// MARK: - Exercício 02
Observable.from(["🐶", "🐱", "🐭", "🐹"])
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)


// MARK: - Exercício 03
func consumeWithObservers() {
    let sequence = { (element: String) -> Observable<String> in
        return Observable.create { observer in
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        }
    }
    
    sequence("🔴")
        .subscribe { print($0) }
        .disposed(by: disposeBag)
}

func consumeWithActions() {
    Observable.just("🔵")
        .subscribe { event in
            print(event)
        }
        .disposed(by: disposeBag)
}

consumeWithObservers()
consumeWithActions()


// MARK: - Exercício 04
Observable.range(start: 1, count: 5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)


// MARK: - Exercício 05
Observable.of(0, 1, 2, 3)
    .map { $0 * $0 }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)


// MARK: - Exercício 06
Observable.of(
    "❌", "⭕️", "❌",
    "❌", "❌", "⭕️",
    "⭕️", "⭕️", "❌")
    .filter {
        $0 == "❌"
    }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)


// MARK: - Exercício 07
Observable.of(10, 100, 1000)
    .reduce(15, accumulator: +)
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)


// MARK: - Exercício 08
//There is no collect() in RxSwift


// MARK: - Exercício 09
let fruitList = BehaviorSubject(value: "🍎")

fruitList.asObservable()
    .concat(fruitList)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

fruitList.onNext("🍐")
fruitList.onNext("🍊")

// MARK: - Exercício 10
struct Player {
    var score: Variable<Int>
}

let 👦🏻 = Player(score: Variable(80))
let 👧🏼 = Player(score: Variable(90))

let player = PublishSubject<Player>()

player.asObservable()
    .flatMap { $0.score.asObservable() }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

player.onNext(👦🏻)
👦🏻.score.value = 85
player.onNext(👧🏼)
👦🏻.score.value = 95
👧🏼.score.value = 100

// MARK: - Exercício 11
//There is no groupBy() in RxSwift


// MARK: - Exercício 12 e 13
Observable<Int>.create { observer in
    observer.onNext(1)
    sleep(1)
    observer.onNext(2)
    return Disposables.create()
    }
    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { el in
        print(Thread.isMainThread)
    })
    .disposed(by: disposeBag)


// MARK: - Exercício 15
let random = Array(1...10)
//let randomIndex = Int(arc4random_uniform(UInt32(random.count)))
let animals = PublishSubject<String>()
let fruits = PublishSubject<String>()

Observable.of(animals, fruits)
    .merge()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

animals.onNext("🐶")
let randomIndex1 = Int(arc4random_uniform(UInt32(random.count)))
sleep(UInt32(random[randomIndex1]))
animals.onNext("🐱")
let randomIndex2 = Int(arc4random_uniform(UInt32(random.count)))
sleep(UInt32(random[randomIndex2]))
fruits.onNext("🍏")
let randomIndex3 = Int(arc4random_uniform(UInt32(random.count)))
sleep(UInt32(random[randomIndex3]))
fruits.onNext("🍒")
let randomIndex4 = Int(arc4random_uniform(UInt32(random.count)))
sleep(UInt32(random[randomIndex4]))
animals.onNext("🐨")
let randomIndex5 = Int(arc4random_uniform(UInt32(random.count)))
sleep(UInt32(random[randomIndex5]))
fruits.onNext("🥝")
