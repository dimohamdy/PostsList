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

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
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

}
