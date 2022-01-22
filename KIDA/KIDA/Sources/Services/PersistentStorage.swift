//
//  PersistentStorage.swift
//  KIDA
//
//  Created by Ian on 2022/01/18.
//

import UIKit
import CoreData

final class PersistentStorage {
    // MARK: - Properties
    static let shared = PersistentStorage()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let entityName = "Diary"

    // MARK: - Initializer
    private init() { }

    // MARK: - API
    func getAllDiary() -> [Diary] {
        var diaries: [Diary] = []
        do {
            diaries = try context.fetch(Diary.fetchRequest())
        } catch {
            print(error.localizedDescription)
            diaries = []
        }

        return diaries
    }

    func createDiary(_ diary: Diary,
                     onSuccess: ((Bool) -> Void)? = nil) {
        let newDiary = Diary(context: context)
        newDiary.title = diary.title
        newDiary.content = diary.content
        newDiary.createdAt = diary.createdAt
        newDiary.keyword = diary.keyword

        do {
            try context.save()
            onSuccess?(true)
        } catch {
            print(error.localizedDescription)
            onSuccess?(false)
        }
    }

    func deleteDiary(_ diary: Diary,
                     onSuccess: ((Bool) -> Void)? = nil) {
        context.delete(diary)

        do {
            try context.save()
            onSuccess?(true)
        } catch {
            print(error.localizedDescription)
            onSuccess?(false)
        }
    }

    func updateDairy(before beforeDiary: inout Diary,
                     after afterDiary: Diary,
                     onSuccess: ((Bool) -> Void)? = nil) {
        beforeDiary = afterDiary

        do {
            try context.save()
            onSuccess?(true)
        } catch {
            print(error.localizedDescription)
            onSuccess?(false)
        }
    }
}
