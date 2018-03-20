import Quick
import Nimble
@testable import MoviesStar

class FilterDataSourceSpec: QuickSpec {
    
    override func spec() {
        
        describe("FilterDataSourceSpec") {
            let item1 = "2018"
            let item2 = "2017"
            let items = [item1, item2]
            var sut = FilterDataSource(items: items)
            
            context("when FilterDataSourceSpec is instantiated", {
                
                it("should not be nil", closure: {
                    expect(sut).toNot(beNil())
                })
            })
            
            context("when tableView is instantiated", {
                
                it("should return number of items ", closure: {
                    expect(sut.numberOfItems()).to(equal(items.count))
                })
                
                it("should return item for a indexPath", closure: {
                    let indexPath = IndexPath(row: 0, section: 0)
                    expect(sut.getItem(byIndexPath: indexPath)).to(equal(item1))
                })
            })
            
            context("when item is selected", {
                it("should set item", closure: {
                    sut.select(item: item1)
                    expect(sut.selectedItem).to(equal(item1))
                })
            })
            
        }
    }
}
