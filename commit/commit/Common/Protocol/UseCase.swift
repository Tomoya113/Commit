//
//  UseCase.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/06/21.
//

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

// AnyUseCaseさえ知っていればいい女王なためprivate extensionとしている
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
