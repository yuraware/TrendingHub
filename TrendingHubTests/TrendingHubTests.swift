//
//  TrendingHubTests.swift
//  TrendingHubTests
//
//  Created by Yurii Kobets on 9/21/20.
//  Copyright © 2020 Helloworld Association. All rights reserved.
//

import XCTest
import RxTest
import RxBlocking

@testable import TrendingHub

class TrendingHubTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class MockAPIRepository: APIRepository {
        var shouldFail: Bool = false
        
        func createMockRepositories() -> [Repository] {
            return [
                Repository(stars: 100, name: "hello-world", description: "some description", url: "https://github.com/huggingface/datasets", builtBy: [
                    User(username: "John", href: URL(string: "https://github.com/huggingface/datasets")!, avatar: "https://github.com/huggingface/datasets")
                ]),
                Repository(stars: 101, name: "c++ rules", description: "some description", url: "https://github.com/huggingface/datasets", builtBy: [
                    User(username: "John", href: URL(string: "https://github.com/huggingface/datasets")!, avatar: "https://github.com/huggingface/datasets")
                ])
            ]
        }
        
        func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void) -> CancellableTask {
            let mocks = createMockRepositories()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1000)) {
                if self.shouldFail {
                    completion(.failure(.invalidJSON))
                } else {
                    completion(.success(mocks))
                }
            }
            let task = URLSession.shared.dataTask(with: URL(string: mocks.first!.url)!) { (_, _, _) in }
            return task
        }
    }
    
    func testAPIFetchRepositoriesUseCase() {
        let mockRepository = MockAPIRepository()
        let useCase = APIFetchRepositoriesUseCase(apiRepository: mockRepository)
        
        let expectFetchRepositories = expectation(description: "UseCase should fetch repositories")
        useCase.fetch { (result) in
            let repositories = try? result.get()
            XCTAssertNotNil(repositories)
            XCTAssertEqual(repositories?.count, 2)
            expectFetchRepositories.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func testAPIFetchRepositoriesUseCaseFailure() {
        let mockRepository = MockAPIRepository()
        mockRepository.shouldFail = true
        let useCase = APIFetchRepositoriesUseCase(apiRepository: mockRepository)
        
        let expectFetchRepositories = expectation(description: "UseCase should fetch repositories")
        useCase.fetch { (result) in
            let repositories = try? result.get()
            XCTAssertNil(repositories)
            
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            
            expectFetchRepositories.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func testRepositoryListViewModel() {
        let mockRepository = MockAPIRepository()
        let useCase = APIFetchRepositoriesUseCase(apiRepository: mockRepository)
        let viewModel = RepositoryListViewModelImpl(fetchUseCase: useCase, didSelect: didSelect(item:))
        viewModel.viewWillAppear()
        _ = try? viewModel.itemsRelay.toBlocking(timeout: 2).last()
        let viewModels = viewModel.itemsRelay.value
        XCTAssertNotNil(viewModels)
        XCTAssertEqual(viewModels.count, 2)
    }
    
    func testRepositoryListViewModelStartSearch() {
        let mockRepository = MockAPIRepository()
        let useCase = APIFetchRepositoriesUseCase(apiRepository: mockRepository)
        let viewModel = RepositoryListViewModelImpl(fetchUseCase: useCase, didSelect: didSelect(item:))
        viewModel.viewWillAppear()
        _ = try? viewModel.itemsRelay.toBlocking(timeout: 2).last()
        viewModel.startSearch(searchTerm: "c++")
        _ = try? viewModel.itemsRelay.toBlocking(timeout: 2).last()
        let viewModels = viewModel.itemsRelay.value
        XCTAssertNotNil(viewModels)
        XCTAssertEqual(viewModels.count, 1)
        if let filteredViewModel = viewModels.first {
            XCTAssertTrue(filteredViewModel.projectName.contains("c++"))
        } else {
            XCTFail()
        }
    }
    
    func didSelect(item: Repository) {}
}
