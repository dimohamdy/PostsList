//
//  UserDefault+LocalPostRepository.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

final class UserDefaultLocalPostRepository: LocalPostRepository {

    weak var delegate: LocalPostRepositoryUpdate?

    private var posts: [Post] = [] {
        didSet {
            delegate?.updated(localPosts: posts)
        }
    }

    static let shared = UserDefaultLocalPostRepository()
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        posts = getPosts()
    }

    func clearPosts() -> [String] {
        // userDefaults.removeObject(forKey: UserDefaultsKey.posts.rawValue)
        return []
    }

    func save(post: Post) {
        posts.append(post)
        save()
    }

    func remove(post: Post) {
        /*posts.removeAll(where: {
            $0.name == post.name
        })*/
    }

    func getPosts() -> [Post] {
        load()
        return posts
    }

    private func load() {
        /*guard let data = userDefaults.data(forKey: UserDefaultsKey.posts.rawValue),
              let savedPosts = try? JSONDecoder().decode([Post].self, from: data) else { posts = []; return }
        posts = savedPosts*/
    }

    private func save() {
        /*do {
            let data = try JSONEncoder().encode(posts)
            userDefaults.set(data, forKey: UserDefaultsKey.posts.rawValue)
        } catch {
            print(error) // remove the print 
        }*/
    }
}
