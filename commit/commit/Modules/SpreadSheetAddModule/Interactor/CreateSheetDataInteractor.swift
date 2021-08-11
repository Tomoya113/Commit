//
//  CreateSheetDataInteractor.swift
//  commit
//
//  Created by Tomoya Tanaka on 2021/08/11.
//

import Foundation

struct CreateSheetDataQuery {
	var preset: Preset
	var section: SectionRealm
	var sheetAttributes: [SpreadSheetTodoAttribute]
}

class CreateSheetDataInteractor: UseCase {
	let sheetAttributeRepository = RealmRepository<SpreadSheetTodoAttribute>()
	let presetRepository = RealmRepository<Preset>()
	let listRepository = RealmRepository<ListRealm>()
	
	func execute(_ parameters: CreateSheetDataQuery, completion: ((Result<Void, Error>) -> Void )?) {
		let preset = parameters.preset
		let section = parameters.section
		let sheetAtrributes = parameters.sheetAttributes
		let currentList = listRepository.findAll()[0]
		sheetAttributeRepository.add(entities: sheetAtrributes)
		presetRepository.add(entities: [preset])
		listRepository.transaction {
			currentList.sections.append(section)
		}
	}
	
	func cancel() {
		
	}
}
