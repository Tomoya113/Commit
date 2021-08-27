//
//  DeleteSectionInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/07/29.
//

import Foundation

class DeleteSectionInteractor: UseCase {
	let sheetsTodoAttributeRepository = RealmRepository<SheetsTodoAttribute>()
	let presetRepository = RealmRepository<Preset>()
	let sectionRepository = RealmRepository<SectionRealm>()
	let todoRepository = RealmRepository<Todo>()
	
	func execute(_ parameters: SectionRealm, completion: ((Result<Void, Never>) -> Void )?) {
		let todos = parameters.todos
		deletePreset(id: parameters.id)
		todoRepository.delete(entities: Array(todos))
		sectionRepository.delete(entities: [parameters])
		completion?(.success(()))
	}
	
	private func deletePreset(id: String) {
		let predicate = NSPredicate(format: "sectionId = %@", argumentArray: [id])
		presetRepository.find(predicate: predicate) { result in
			switch result {
				case .success(let preset):
					if let preset = preset.first {
						self.deleteSheetAttribute(id: preset.id)
						self.presetRepository.delete(entities: [preset])
					} else {
						print("Not found")
					}
			}
		}
	}
	
	private func deleteSheetAttribute(id: String) {
		let predicate = NSPredicate(format: "presetId = %@", argumentArray: [id])
		sheetsTodoAttributeRepository.find(predicate: predicate) { result in
			switch result {
				case .success(let attributes):
					print(attributes)
					self.sheetsTodoAttributeRepository.delete(entities: attributes)
			}
		}
	}
	
}
