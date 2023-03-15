//
//  CoreDataPostsRepository.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 11/03/2023.
//

import Foundation
import CoreData

final class CoreDataPostsRepository: PostsRepository, LocalPostsRepository {

    let managedObjectContext: NSManagedObjectContext
    let logger: LoggerProtocol

    init(managedObjectContext: NSManagedObjectContext, logger: LoggerProtocol) {
        self.managedObjectContext = managedObjectContext
        self.logger = logger
    }

    func getPosts() async throws -> [Post] {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()

        do {
            // Perform Fetch Request
            let posts = try managedObjectContext.fetch(fetchRequest)
            return posts
        } catch {
            return []
        }
    }

    func getPost(by postID: Int) async throws -> Post? {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.fetchLimit = 1

        fetchRequest.predicate = NSPredicate(
            format: "id = %i", postID
        )

        // Fetch a single object. If the object does not exist,
        // nil is returned
        let post = try? managedObjectContext.fetch(fetchRequest).first
        return post
    }

    func savePosts() throws {
        try managedObjectContext.save()
    }

    func deletePosts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Post.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch let nserror as NSError {
            logger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
        }
    }
}
