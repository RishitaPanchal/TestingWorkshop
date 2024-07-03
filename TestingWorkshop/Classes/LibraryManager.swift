//
//  LibraryManager.swift
//  TestingWorkshop
//
//  Created by Rishita Panchal on 03/07/24.
//

import Foundation

// Define the Library class
class Library {
    static let shared = Library()

    // MARK: - Enumeration
    enum BookGenre {
        case fiction
        case nonFiction
        case fantasy
        case mystery
    }

    // MARK: - Struct
    struct Book {
        let title: String
        let author: String
        let genre: BookGenre
        var isBorrowed: Bool
    }

    // MARK: - Private variables
    private var catalog: [Book]
    private var borrowedBooks: [Book]

    // MARK: - Initialiser
    init() {
        self.catalog = [
            Book(
                title: "1984",
                author: "George Orwell",
                genre: .fiction,
                isBorrowed: false
            ),
            Book(
                title: "Sapiens",
                author: "Yuval Noah Harari",
                genre: .nonFiction,
                isBorrowed: false
            ),
            Book(
                title: "Harry Potter and the Philosopher's Stone",
                author: "J.K. Rowling",
                genre: .fantasy,
                isBorrowed: false
            ),
            Book(
                title: "The Da Vinci Code",
                author: "Dan Brown",
                genre: .mystery,
                isBorrowed: false
            )
        ]
        self.borrowedBooks = []
    }
}

// MARK: - Functions
extension Library {
    // Function to borrow a book
    func borrowBook(title: String) {
        guard let index = catalog.firstIndex(where: { $0.title == title && !$0.isBorrowed }) else {
            print("Book \(title) is not available for borrowing.")
            return
        }
        print("Borrowing book: \(title) by \(catalog[index].author)")
        catalog[index].isBorrowed = true
        borrowedBooks.append(catalog[index])
    }

    // Function to return a book
    func returnBook(title: String) {
        guard let index = borrowedBooks.firstIndex(where: { $0.title == title }) else {
            print("Book \(title) was not borrowed from this library.")
            return
        }
        print("Returning book: \(title) by \(borrowedBooks[index].author)")
        borrowedBooks.remove(at: index)

        if let catalogIndex = catalog.firstIndex(where: { $0.title == title }) {
            catalog[catalogIndex].isBorrowed = false
        }
    }

    // Function to search for books by genre
    func searchBooks(by genre: BookGenre) -> [Book] {
        let books = catalog.filter { $0.genre == genre && !$0.isBorrowed }
        return books
    }

    // Function to list all borrowed books
    func listBorrowedBooks() -> [Book] {
        return borrowedBooks
    }

    // Function to list all books in the catalog
    func listAllBooks() -> [Book] {
        return catalog
    }

    // Function to add a new book to the library
    func addBook(title: String, author: String, genre: BookGenre) {
        let newBook = Book(title: title, author: author, genre: genre, isBorrowed: false)
        catalog.append(newBook)
    }

    // Function to remove a book from the library
    func removeBook(title: String) {
        guard let index = catalog.firstIndex(where: { $0.title == title }) else {
            print("Book \(title) is not in the library's catalog.")
            return
        }
        catalog.remove(at: index)
        borrowedBooks.removeAll { $0.title == title }
        print("Removed book: \(title)")
    }

    // Function to check if a specific book is available for borrowing
    func isBookAvailable(title: String) -> Bool {
        return catalog.contains { $0.title == title && !$0.isBorrowed }
    }

    // Function to count total number of books in the library
    func countTotalBooks() -> Int {
        return catalog.count
    }

    // Function to count total number of borrowed books
    func countBorrowedBooks() -> Int {
        return borrowedBooks.count
    }

    // Function to sort books in the catalog by title
    func sortBooksByTitle() {
        catalog.sort { $0.title < $1.title }
    }

    // Function to sort books in the catalog by author
    func sortBooksByAuthor() {
        catalog.sort { $0.author < $1.author }
    }

    // Function to reset the library by clearing all books
    func resetLibrary() {
        catalog.removeAll()
        borrowedBooks.removeAll()
    }
}
