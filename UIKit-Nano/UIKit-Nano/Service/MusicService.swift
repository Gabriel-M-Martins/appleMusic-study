//
//  MusicService.swift
//  Music
//
//  Created by Marina De Pazzi on 15/04/23.
//

import Foundation
import UIKit

// MARK: - Music
struct Music: Hashable, Decodable {
    let id: String
    
    let title: String
    let artist: String
    let length: TimeInterval
    
    // MARK: Hasher
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//MARK: - MusicCollectionCategory
enum MusicCollectionCategory: CaseIterable {
    case spatialAudio
    case pop
    case metal
    case hits
    case brazillianPop
    
    var description: String {
        switch self {
            case .spatialAudio:
                return "Spatial Audio"
            case .pop:
                return "Pop"
            case .metal:
                return "Metal"
            case .hits:
                return "Hits"
            case .brazillianPop:
                return "Brazillian Pop"
        }
    }
}

// MARK: - MusicCollectionType
enum MusicCollectionType: String, Decodable, CaseIterable {
    /// Music collection types and variations
    case playlist
    case album
    case songs
    case artists
    
    /// Collection SF Symbols mapping
    var icon: String {
        switch self {
            case .playlist:
                return "music.note.list"
            case .album:
                return ""
            case .songs:
                return "music.note"
            case .artists:
                return "music.mic"
        }
    }
    
    /// Music collection string description
    var description: String {
        switch self {
            case .playlist:
                return "Playlists"
            case .album:
                return "Album"
            case .songs:
                return "Songs"
            case .artists:
                return "Artists"
        }
    }
}

// MARK: - MusicCollection
struct MusicCollection: Hashable, Decodable {
    
    let id: String
    
    let title: String
    let mainPerson: String
    let referenceDate: Date
    
    var musics: [Music]
    
    let type: MusicCollectionType
    let albumDescription: String?
    let albumArtistDescription: String?
    
    var supportsEdition: Bool {
        type == .playlist
    }
    
    // MARK: Hasher
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Queue
struct Queue {
    /// Current playing song, if there is any
    var nowPlaying: Music?
    
    /// Current collection being played, if there is any
    var collection: MusicCollection?
    /// The next songs in the collection
    var nextInCollection: [Music]
    
    /// The next suggested songs
    var nextSuggested: [Music]
}

// MARK: - MusicService
final class MusicService {
    //MARK: Variables Setup
    private let allMusics: [Music]
    private var collections: Set<MusicCollection>
    
    /// The queue with the music being played and the next musics.
    private(set) var queue: Queue
    
    /// List of musics the user has favorited, in chronological order of addition to the favorite list.
    private(set) var favoriteMusics: [Music] {
        get {
            let favoriteMusicsIDs = UserDefaults.standard.array(forKey: "favorite-musics-ids") as? [String] ?? []
            return favoriteMusicsIDs.compactMap { musicID in
                allMusics.first { $0.id == musicID }
            }
        }
        set {
            let musicsIDs = newValue.map(\.id)
            UserDefaults.standard.set(musicsIDs, forKey: "favorite-musics-ids")
        }
    }
    
    //MARK: Init
    /// Initializes a new MusicService instance
    ///
    /// Loads data from the json files. Method may `throws` due to I/O errors.
    ///
    init() throws {
        // may the superior entity (if such exists) forgive me for such terrible practice :'//
        let mockDataUrl = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try Data(contentsOf: mockDataUrl)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.collections = try decoder.decode(Set<MusicCollection>.self, from: data)
        self.allMusics = collections.flatMap(\.musics)
        
        self.queue = Queue(nowPlaying: nil, collection: nil, nextInCollection: [], nextSuggested: [])
    }
    
    // MARK: Library
    /// Retrieves all the available music collections
    ///
    /// - Returns: An array of all music collection available
    ///
    func loadLibrary() -> [MusicCollection] {
        collections.sorted { $0.referenceDate > $1.referenceDate }
    }
    
    /// Retrieves a music collection upon a given collection ID
    ///
    /// - Parameters:
    ///     - id: The id of the collection to be retrived
    ///
    /// - Returns: A music collection matching the given ID
    ///
    /// If the ID is invalid or does not match any record, `nil` is returned.
    ///
    func getCollection(id: String) -> MusicCollection? {
        collections.first { $0.id == id }
    }
    
    /// Retrieves all songs available
    ///
    /// - Returns: An array of music contaning all available songs
    ///
    func getAllMusics() -> [Music] {
        return self.allMusics
    }
    
    //MARK: Remove from collection
    /// Removes the given music from the given collection
    ///
    /// - Parameters:
    ///   - music: The music to be removed
    ///   - collection: The collection to be modified
    ///
    func removeMusic(_ music: Music, from collection: MusicCollection) {
        guard collection.supportsEdition else { return }
        
        // since MusicCollection is a value type (i.e. struct),
        // we need to remove the existing value from collections and then insert back the modified one
        collections.remove(collection)
        
        var collectionCopy = collection
        collectionCopy.musics.removeAll { $0.id == music.id }
        collections.insert(collectionCopy)
    }
    
    // MARK: Cover art
    /// Gets the cover art image for a collection or a music.
    ///
    /// - Parameter itemId: ID of a `Music` or `MusicCollection`.
    /// - Returns: Image object representing the item's cover art.
    ///
    func getCoverImage(forItemIded itemId: String) -> UIImage? {
        UIImage(named: itemId)
    }
    
    // MARK: Favorites
    /// Toggles the favorite status of a music.
    ///
    /// - Parameters:
    ///   - music: The music to be added to, or removed from, the list of favorite musics of the user.
    ///   - isFavorite: Whether the music is favorited or not.
    ///
    func toggleFavorite(music: Music, isFavorite: Bool) {
        if isFavorite {
            favoriteMusics.append(music)
        } else {
            favoriteMusics.removeAll { $0 == music }
        }
    }
    
    // MARK: Playing/Queue
    /// Starts playing the given playlist
    ///
    /// - Parameters:
    ///   - collection: The playlist or music collection to be started
    ///
    func startPlaying(collection: MusicCollection) {
        let nonRepeatedMusics = Set(collections.flatMap(\.musics)).subtracting(collection.musics)
        let suggestions = (0..<10).compactMap { _ in nonRepeatedMusics.randomElement() }
        
        queue = Queue(
            nowPlaying: collection.musics.first,
            collection: collection,
            nextInCollection: Array(collection.musics.dropFirst()),
            nextSuggested: suggestions)
    }
    
    /// Starts playing the given music
    ///
    /// - Parameters:
    ///   - music: The music to be played
    ///
    func startPlaying(music: Music) {
        queue = Queue(nowPlaying: music, collection: nil, nextInCollection: [], nextSuggested: [])
    }
    
    /// Removes the given music from the queue
    ///
    /// - Parameters:
    ///   - music: The music to be removed from queue
    ///
    func removeFromQueue(music: Music) {
        queue.nextInCollection.removeAll { $0 == music }
        queue.nextSuggested.removeAll { $0 == music }
    }
}
