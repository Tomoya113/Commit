# commit

Commit!のリポジトリ

## どういうアプリ？

スプシのセルを取得してTODOリストを作るアプリ。(未完成)

## 何で作ったの？

某会社で一人ひとりに割り振られているTODO をスプシで管理しているけど、スマホ版のスプシのアプリが使いにくすぎてしんどい。
タスク終わったらいちいちPC開いてタスクの達成状況を更新するのが面倒。
スプシと紐付いたTODOがあったら便利

## 使っている技術

- SwiftUI
- Realm
- Google OAuth
- Combine

## アーキテクチャ

- VIPER + Repositoryパターン

## 大変だった所

### アーキテクチャに沿ってアプリを作ること

アーキテクチャに沿ってアプリを作るのがほぼ初めてだったのでどの層に処理を書くべきか、どういうふうに書けば

### Google OAuth の審査

「この画面は確認されていません」という表示を消すためにGoogle OAuthの審査が必要。
そのために[簡単なLP](https://www.commit-dev.site/)作りました。
わざわざ英語で利用規約とプライバシーポリシーを作ってドメイン取ったりして大変でした。

### SwiftUI のプレビュー

SwiftUIのプレビューが全然安定しない。動かない時に直接的なエラーを吐いてくれないので難しかった。

## 改善したい所

### コンポーネントを抽象化出来ていない

- もっとクラスをprotocolに準拠させたい。protocolはドキュメントになるので。

### スプシ周りの命名

スプシ関連のモジュールにはSpreadSheet...と付けていたけど、長すぎるのでSheetsに変更した
(海外だとスプシはGoogle Sheetsというらしいので)
スプシ周りのモジュールの名前が表記ゆれしている。

## 参考文献

VIPER アーキテクチャの参考文献

- [Getting Started with the VIPER Architecture Pattern | raywenderlich.com](https://www.raywenderlich.com/8440907-getting-started-with-the-viper-architecture-pattern)
- [【全文書き起こしてみた】Developers.IO 2020 CONNECT「VIPER で作ろう! 実践 iOS アプリ開発 〜録画したライブコーディングを添えて〜」 | DevelopersIO](https://dev.classmethod.jp/articles/developers-io-2020-viper-architecture/)
- [VIPER 研究読本 1 クリーンアーキテクチャ解説編 - キュリオシティソフトウェア書店 - BOOTH](https://booth.pm/ja/items/1758609)
