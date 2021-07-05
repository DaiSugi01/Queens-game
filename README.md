# iOS Game app: Queen's game

keyword: `Swift`, `Realm`, `RxSwift`, `MVVM`, `CoreAnimation`, `UICollectionView`, `diffable data sources`

## Summary

We created an iOS game application with Swift. This app provides a multi-payer game to play between your friends and neighbors. Since this game includes great random factors and customization, each time a player will be provided with variable joys.

This app is has a lot of UI factors and data models with a reactive relationship. Thus, we adopted RxSwift and MVVM design patterns to completely separate views, models, and logic.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-whole-game.webp" alt="Kings game" width=240 />
</div>


## Motivation

### Backgorund

There are enormous unique and awesome games in every country and culture. "King's game" which is called "王様ゲーム" in Japan is also one of them.  This party game is a sort of combination of, "Simon Says" and "truth or dare", but might be more flexible and thralling. We thought it would be great to introduce this game into a mobile application so that all over the people in world can know, play and share its wonderful experience!

<div align="center" >
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/concept-king.webp" alt="Kings game" width=240 />
</div>

### What is "King's game"?

The king's game simply consists of two factors, command and obey.
Participants decide on one "King" and others(citizens). Every citizen is provided a secret index that only him/herself knows.
Then, the King makes a command involving indexes, such as "No. 2 have to make No.3 laugh! 🤣".
Finally, each person reveals their index (number), and those who are targeted have to follow the command!

### Introducing into App

To realize this, we created a game app, which we replace "King" with "Queen" instead. This is because to make this game unique, and there is already a game called "King's cup" in western culture which might cause misunderstanding.

In the app, we randomly select the queen and others(citizens), the same as King's game. What is more, by using the advantage of the application platform, we can also prepare template collections of commands. When a queen chooses the command, targets are randomly selected.

Besides, we can let users edit these commands whatever they want, like a "To-do list" app feature. And of course, those commands are saved permanently in the app so that even after closing the app, users can keep on using their customized commands when restart!

Lastly, we can introduce a lot of fun animation because it's an app and this makes users much more fun!

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/concept-queen.webp" alt="Queen" width=240 />
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/concept-todo.webp" alt="todo" width=240 height="240" />
</div>


## Main spec

- Swift: version 5.4
- iOS: 14.3
- RxSwift, RxCocoa: To realize reactive functions involving UI interaction.
- Realm: To save game data persistently.
- Collection View, diffable data source: To display flexible and beautiful UI connected to data.

## Usage

Once you launch the app, users can select whether to start a new game or modifying game settings. 

### New Game

The basic flow of the game is as follows.

1. Select the number of players
2. Enter user names
3. Choose the queen randomly
4. The queen chooses the command
5. Targets described in the command will be chosen randomly
6. Execute(Obey) the command

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-whole-game.webp" alt="game flow" width=240 />
</div>

### Settings

In the game settings, what we can control is shown below.

- Edit template commands like a ToDO app
- Edit some game configuration
- See play guide (How to play)
- See privacy & policy

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-settings.webp" alt="settings" width=240 />
</div>



## Project management

We used the GitHub project (Kanban feature) for scheduling and followed the agile style. This makes the project complete efficiently with even remote work.

![Schedules](https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/management-kanban.webp)

![Discussion](https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/management-discussion.webp)


## UI Designing

We created a whole UI mockup both considering light and dark mode with Figma. In addition to creating a style guide, We created UI components that are well suitable for implementing with MVVM design pattern. 

### Style Guide

![style-guide](https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/ui-style-guide.webp)

### UI mockup

![UI-mockup](https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/ui-mockup-design.webp)

### UI components

![UI components](https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/ui-mockup-components.webp)





### Dynamic Light and Dark mode.

We also prepared and introduce both light and dark modes to suffice users' demands these days. These light and dark modes correspond to the iOS system's appearance. Thus, as soon as a user switches its app appearance, the app will be reflected without restarting.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animatino-lightmode.webp" alt="dark and light mode" width=240 />
</div>

This feature was realized by using `traitCollection` and `userInterfaceStyle`. We implemented a static custom color wrapped by `struct`.

```swift
/// Custom color set used for this project.
/// - Compatible with dark mode.
struct CustomColor {
  
 /// Used for main text color.
 /// - Light mode -> similar to black color
 /// - Dark mode -> similar to white color
 static var text: UIColor {
  return UIColor { (traitCollection: UITraitCollection) -> UIColor in
   return traitCollection.userInterfaceStyle == .light ?
    UIColor(hex: "#251F1F")! : UIColor(hex: "#E1DFDF")!
  }
 }
```

## Front-end animation

For harmony and consistency of UI, this app has a lot of custom animation and UI functions, such as transition, search bar, and loading screen.

### Custom search bar

Although the existing `UISearchController` embedded in Navigation Controller is useful and well-prepared, it is hard to customize in your way. So this time, we decided not to use any `UISearchController` but only our custom `UISearchBar`.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-search-bar.webp" alt="search bar" width=240 />
</div>

To create a custom `UISearchBar`, some of the basic features have to be implemented by yourself. For example,
- Search bar will be displayed and hidden by the user's scrolling.
- When tapping the search bar, it will focus on it by making other places(views) darker.
- When tapping the search bar, a keyboard is displayed
- If you tap outside the keyboard, the keyboard will be dismissed
- Cancel, enter, and close behavior

It was a bit painstaking to do define, but thankfully, we were able to create our own flexible customized search bar!

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

### pop up transition


The default transition animation is nice but limited. To make the transition more game-like, we created a natural pop-up menu. We used `UIViewControllerAnimatedTransitioning` and `UIViewControllerTransitioningDelegate` for customizing mordal animation.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-pop-menu.webp" alt="pop up menu" width=240 />
</div>

```swift
// The delegatee who will do the transition. We will send this to the delegator.
class PopUpTransitioningDelegatee: NSObject, UIViewControllerTransitioningDelegate { }

extension PopUpTransitioningDelegatee {
  // Tells delegate What kind if animation transitioning do you want to use when presenting ?
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

    PopUpTransitioning.shared.presenting = true
    return PopUpTransitioning.shared
  }

  // Tells delegate What kind of animation transitioning do you want to use when dismissing?
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    PopUpTransitioning.shared.presenting = false
    return PopUpTransitioning.shared
  }
}
```

## Back-end

This app includes many reactive scenes. For instance, when the number of players reaches the maximum, it will auto-disable the plus button. For another example, after a countdown, the app will show a different view on the screen.

Therefore, we adopted a view model (MVVM) pattern and reactive framework which is RxSwift.

### Disabling button depends on user action


We added a feature that a user can choose how many players join the game.  Following the original King's game spec, we wanted to set the maximum and the minimum number of players.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-num-of-players.webp" alt="#plyaers" width=240 />
</div>

So we needed features like as follows,
- When a user tap plus or minus button, it'll also reflect the label soon
- When the number of players (#player) reaches max or min, don't let the user tap anymore

This was the exact opportunity to adopt RXswift.
We made each button, label, and variable for #player reactive as reactive relation.
- When a plus or minus button is tapped, we bind it to #player
- When #player changes, it emits its value and the label subscribes to it.
- When #player reaches max or min, we bind it as boolean to button's enable 



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


### Countdown animation


For another example, we created a countdown screen, in which each second the label changes, and after reaching 0 seconds, the whole view is replaced.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-countdown.webp" alt="countdown" width=240 />
</div>

For this feature, we use `onNext` and `onComplete`.
Each second, we send `onNext` and bind to UILabel. After finishing the countdown, we emit `onComplete`, which triggers a next view replacing.


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

### Todo feature


This game contains initial template command so that users only have to select them. Of course,  a user can add new commands or edit them later. This is a sort of Todo list feature. We realize it by using a `UICollectionView` with difffable datasource, which elegantly displays the differences of items. In addition, Realm was used to keep items as persistence data.

Furthermore, we added a searching(filtering) feature, which leads the user to comfortably find their item.

<div align="center">
<img src="https://raw.githubusercontent.com/cookie777/images/main/works/2021-06-Queens-Game/animation-todo.webp" alt="todo list" width=240 />
</div>

This is an example code. The ViewModel reads stored items considering search text. The viewController subscribes snapshot and it reflects the UI.

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

## Future work

What we're planning to do next is as follows.

- Publish in the app store (Coming soon! We are preparing documents now.)
- Implement authentication by using firebase so that user can store their commands and history to cloud store
- Add play card graphic to select the Queen


## Team member and contribution

### Tak ([cookie777](https://github.com/cookie777))

- UI Designer
  - UI mockup
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

