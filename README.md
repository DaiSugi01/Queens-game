# iOS Game app: Queens game

keyword: Swift, Realm, RxSwift, MVVM, CoreAnimation, collection view, diffable data sources

## Summary

We created an iOS game application with Swift. This app provides a multi payer game to play between your friends and neighbors. Because this games includes great random factors and customization, each time it will provides you a variable joys.

This is has a lot of UI factors and models with reactive relationship.
Thus, we adopted RxSwift and MVVM design pattern to completely separate views, models and logics.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-05-Queens-Game/animation-whole-game.webp" alt="Kings game" width=240 />
</div>


## Motivation

### Backgorund

There are a lot of unique and awesome games in every countries and cultures.
Three is a game called "Kings game(王様ゲーム)" in Japan, which is kind a "truth or dare", but might be more flexible and thralling. We thought it would be great to introduce the game in mobile application so that all over the people in the world can know, play and share its wonderful experience!

<div align="center" >
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-05-Queens-Game/concept-king.webp" alt="Kings game" width=240 />
</div>

### What is Kings game?

The kings game is a simple game consists of command and obey.
We decide one "King" and others(citizens) providing secret index.
Then, the King makes a command, such as "No. 2 have to make No.3 laugh!".
Finally each person reveals their own index (number), and those who becomes the targets have to follow the command!


### Introducing into App

To realize this, we created a game app which we replace "King" to "Queen" instead. This is because to make it unique, and there is already a game called "Kings cup" which might be a bit.

In the app, we randomly select the queen and others(citizens).
What is more, by using the advantage of app, we can also prepare template collections of commands, and then only targets can be randomly selected.

Besides, we can let users to edit these commands what ever they want, like a "To do" app feature. And of course, those commands are saved permanently in the app so that even after closing the app, users can keep on using their customized commands!

Lastly, we can included a lot of fun animation because it's a app and this makes users much fun!

<div style="
  display: inline-flex;
  gap: 16px;
  align-items: center;
  justify-content: center;
">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-05-Queens-Game/concept-queen.webp" alt="Queen" width=240 />
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-05-Queens-Game/concept-todo.webp" alt="todo" width=240 height="240" />
</div>


## Spec

- Swift: version 5.4
- iOS: 14.3
- RxSwift, RxCocoa: To realize reactive functions involving UI interaction.
- Realm: To save game data persistently.
- Collection View, diffable data source: To display flexible and beautiful UI connected to data.

## Usage

Once you launch the app, users can select weather starting a new game or modifying game settings. 

### New Game

The basic flow of the game is as follows.

1. Select the number of players
2. Enter user names
3. Choose the queen randomly
4. The queen choose the command
5. Targets written in the command will be chosen randomly
6. Execute(Obey) the command

[each sene animation]

### Settings

At the game setting we can do is shown below.

- Edit template commands like a ToDO app
- Edit some game configuration
- See play guide
- See policy

[each sene animation]

<div align="center" style="
  display: inline-flex;
  gap: 16px;
">
  <img class="app-screen-capture" src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-01-Hang-Out-Planner/animation-todo.webp" alt="todo"  width=240 style="border: 2px solid #021a40; background-color: #ff0;border-radius: 6px;"/>

  <img class="app-screen-capture" src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-01-Hang-Out-Planner/animation-planner.webp" alt="planner" width=240 style="border: 2px solid #021a40; background-color: #ff0;border-radius: 6px;"/>

  <img class="app-screen-capture"  src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-01-Hang-Out-Planner/animation-location-manager.webp"  alt="location-manager" width=240 style="border: 2px solid #021a40; background-color: #ff0;border-radius: 6px;" />
</div>


## Project management

We used github project (Kanban) for scheduling and used the agile style. This makes the project complete efficently and remote work.

![Schedules](https://raw.githubusercontent.com/cookie777/images/main/works/2021-01-Hang-Out-Planner/manager-schedule.webp)
![Docs](https://raw.githubusercontent.com/cookie777/images/main/works/2021-01-Hang-Out-Planner/manager-docs.webp)
![Tasks](https://raw.githubusercontent.com/cookie777/images/main/works/2021-01-Hang-Out-Planner/manager-requirements.webp)


## UI Designing

We created a whole UI mock using Figma including Dark Mode. In addition to creating a style guide, We created design components that are well suitable for implementing swift codes.

![UI mock 1](https://github.com/cookie777/images/blob/main/works/2021-01-Hang-Out-Planner/ui-mock1.webp?raw=true)
![UI mock 2](https://raw.githubusercontent.com/cookie777/images/main/works/2021-01-Hang-Out-Planner/ui-mock2.webp)


## Front-end animation

To harmonize and unify the UI, this app has a lot of custom animation and functions, such as transition, search bar, loading screen.

### Custom search bar

Although existing search controller embedded in Navigation Controller is useful and well-prepared, it is hard to customize on you own way. So this time, we created our own custom search controller.
To do this, we implement on only UI but 

- Search bar will be displayed and hidden by user's scrolling.
- When tap search bar, it will focus, make other places dark
- If you tap outside the keyboard, the keyboard will be dismissed

```swift
extension CommonCommandViewController: UISearchBarDelegate {
  
  // Whenever Text is changed
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchText = searchText
    viewModel.readItems()
    
    // If text is empty -> This is executed when "x" button is click. We want to stop focus.
    if searchText.isEmpty {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            searchBar.resignFirstResponder()
        }
    }
  }
```
[animation of search bar]

### pop up transition

The default transition animation is nice but limited. To make it more game like, we created a natural pop up revealing game menu. We used `UIViewControllerAnimatedTransitioning` and `UIViewControllerTransitioningDelegate` to customize present animation.

```swift
// The delegatee who will do the transition. We will send this to the delegator.
class PopUpTransitioningDelegatee: NSObject, UIViewControllerTransitioningDelegate { }

extension PopUpTransitioningDelegatee {
  // Tells delegate What kind if animation transitioning do you want to use when presenting ?
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    PopUpTransitioning.shared.presenting = true
    return PopUpTransitioning.shared
  }

  // Tells delegate What kind if animation transitioning do you want to use when dismissing ?
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    PopUpTransitioning.shared.presenting = false
    return PopUpTransitioning.shared
  }
}
```

## Back-end

This app includes many reactive scenes. For instance, when user decides the max number players, it will auto disable the positive button. For another example after countdown, the app will show different view on it.

To realize theses features, we adopted View model (MVVM) pattern, and reactive frame work which is RxSwift.

### Disabling button depends on user action

```swift
// View model
  let numOfPlayers: BehaviorRelay = BehaviorRelay(value: 5)
```

```swift
let vm = ViewModel()

// when button tapped -> increment #player
plusButton.rx.tap
  .subscribe { [weak self] _ in
    self?.vm.numOfPlayers.accept((self?.vm.numOfPlayers.value)! + 1)
  }
  .disposed(by: vm.disposeBag)

// when #player changes -> bind to UI (label)
vm.numOfPlayers
  .map{String($0)}
  .bind(to: playerCountLabel.rx.text)
  .disposed(by: vm.disposeBag)

// when #player changes and reach to limit, -> bind to UI (disable the button)
vm.numOfPlayers
  .map {$0 < 9}
  .bind(to: plusButton.rx.isEnabled)
  .disposed(by: vm.disposeBag)

```

[photo of]

### Countdown animation

For another example, we created a countdown screen, which each second the label changes, and after reaching to 0 seconds, the while view is replaced.

For this feature, we use `onNext` and `oncomplete`.
Each seconds, we do `onNext` and bind to UILabel. After finish countdown, we emit `onComplete`, which trigger a next view replacing.


```swift

  // View model
  
  var timer = Timer()
  var countdownTime = Int(Settings.shared.queenWaitingSeconds) // Singleton

  // Subject
  let rxCountdownTime = PublishSubject<Int?>()
  
  func countdown() {
    self.timer = Timer.scheduledTimer(
      withTimeInterval: 1,
      repeats: true,
      block: { [weak self] timer in
        self?.countdownTime -= 1
        // Each second, send time
        self?.rxCountdownTime.onNext(self?.countdownTime)
        if self?.countdownTime == -1 {
          // When it's 0, send finish.
          self?.rxCountdownTime.onCompleted()
        }
      })
  }


```

```swift

// view controller

  self.viewModel.countdown()
  self.viewModel.rxCountdownTime
    .subscribe(onNext: { [weak self] time in
      guard let time = time else { return }
      DispatchQueue.main.async {
        self?.countdownStackView.countdownLabel.text = String(time)
      }
    },
    onCompleted: {
      self.replaceView() // after count down, replace view
    })
    .disposed(by: disposeBag)

```

[photo of ]

### Todo feature

This game contains initial template items (commands) so that users only have to select them. Of course, later user can add new command or edit them. This is a sort of Todo feature. We realize it by using collection view with difffable datasource, which elegantly displays the differences of items. In addition, RxSwift, MVVM pattern, and Real to keep as persistance data are used.

Furthermore, we added a custom searching feature, which leads user to comfortably find their item.

This is a one example code. The ViewModel reads stored items considering search text. The viewController subscribes snapshot and reflect to the UI.

```swift
  // View model

  /// Read items from realm and update snapshot (and update UI)
  func readItems() {
    let items: [Command]
    
    if searchText == "" {
      items = Array(
        realm.objects(Command.self)
          .sorted(byKeyPath: "detail", ascending: true)
      )
    } else {
      items = Array(
        realm.objects(Command.self)
          .filter("detail CONTAINS[c] %@", searchText)
          .sorted(byKeyPath: "detail", ascending: true)
      )
    }
    
    updateSnapshot(newItems: items)
  }
```

```swift
    // view controller
    viewModel.snapshotSubject
      .subscribe (onNext: { [unowned self] snapshot in
        self.dataSource.apply(snapshot, animatingDifferences: true)
      })
      .disposed(by: viewModel.disposeBag)
```

[photo]



## Future work

What we're planning to do next is as follows.

- Publish in the app store (coming soon! we've preparing documents now.)
- Implement authentication by using firebase so that user can store their commands and history to cloud store
- Add play card graphic to select the Queen


## Team member and contribution

### Tak ([cookie777](https://github.com/cookie777))

- UI Designer
  - UI mock up
  - Basic All UI Components
- Developer
  - Command Todo feature
  - transition animation
  - Custom Search bar


### Daiki ([DaiSugi01](https://github.com/DaiSugi01))



### Takayasu ([TakayasuNasu](https://github.com/TakayasuNasu))





<!-- 1. Start game with more than three people.
1. allocate index(number) to other randmamly by using lottery.
  1. ex user a is 3, user b is King, user c is 0 , user d is 2
  2. But Each person knows his/her onw number but not others
2. Firslty, No.0 will be the King and shows the result to others
   1. At this moment, The king don't know who has specific index and so do others.
3. The king gives a order(command) involing others user
   1. ex,King says "No. 2 have to make lought No.3!"
4. Fun time, -->

