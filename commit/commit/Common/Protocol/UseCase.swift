//
//  UseCase.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

// 1. associatedtypeのあるprotocolに準拠した変数を定義or仮引数にできない(コンパイルエラーになる)
// 2. 具象型を宣言する必要がある(具象型はprotocolのassociatedtypeを確定させることができるから)
// 3. 抽象型を扱う型(AnyUseCase)を定義する
// AnyUseCase:
//	- Interactorを利用する際のインターフェース
//	- 内部にはAnyUseCaseBoxに保持してインターフェース経由で利用する
// AnyUseCaseBox: 型パラメータ Parameters, SuccessをUseCaseプロトコルのassociatedtypeと合わせるために用いる
// UseCaseBox: 内部にUseCaseプロトコルを具象化したインスタンスを保持して実行させる

// UseCaseBoxの型の決定→AnyUseCaseBoxの連想型決定→AnyUseCaseの連想型決定

import Foundation

protocol UseCase where Failure: Error {
	associatedtype Parameters
	associatedtype Success
	associatedtype Failure
	
	func execute(
		_ parameters: Parameters,
		completion: ( (Result<Success, Failure>) -> Void )?
	)
	
	func cancel()
}

final class AnyUseCase<Parameters, Success, Failure: Error>: UseCase {
	// UseCaseを保持するboxを保持する
	private let box: AnyUseCaseBox<Parameters, Success, Failure>
	
	// boxはAnyUseCaseBoxを待ち受けてるけど、実際にはUseCaseBoxを代入している
	init<T: UseCase>(_ base: T) where T.Parameters == Parameters,
									  T.Success == Success,
									  T.Failure == Failure {
		box = UseCaseBox<T>(base)
	}
	
	func execute(_ parameters: Parameters, completion: ((Result<Success, Failure>) -> Void )?) {
		box.execute(parameters, completion: completion)
	}
	
	func cancel() {
		box.cancel()
	}
}

// AnyUseCaseさえ知っていればいい情報なためprivate extensionとしている
private extension AnyUseCase {
	
	// ジェネリクスの型パラメータParameters, Success, Failureを用いて、メソッドをUseCaseと合わせる。
	// UseCaseBoxに継承させて型パラメータの決定を行う
	class AnyUseCaseBox<Parameters, Success, Failure: Error> {
		func execute(
			_ parameters: Parameters,
			completion: (( Result<Success, Failure> ) -> Void )? ) {
			fatalError()
		}
		
		func cancel() {
			fatalError()
		}
	}
	
	// ジェネリクスの型パラメータとしてT: UseCaseを持つクラスとして定義。
	// AnyUseCaseBoxを継承してAnyUseCaseBoxのパラメータとUseCaseの型をあわせる
	// generic型はwhereとかできないので、AnyUseCaseBoxが必要(?)
	final class UseCaseBox<T: UseCase>: AnyUseCaseBox<T.Parameters, T.Success, T.Failure> {
		private let base: T
		
		init(_ base: T) {
			self.base = base
		}
		
		override func execute(_ parameters: T.Parameters, completion: ((Result<T.Success, T.Failure>) -> Void )?) {
			base.execute(parameters, completion: completion)
		}
		
		override func cancel() {
			base.cancel()
		}
		
	}
	
}
