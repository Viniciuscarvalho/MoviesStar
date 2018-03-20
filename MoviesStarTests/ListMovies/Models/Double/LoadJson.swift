import Foundation

import Quick
import Nimble
@testable import MoviesStar

class LoadJson {
        
    static func emptyJsonString()->String{
        let emptyJsonString =
        """
{
    "page": 1,
    "results": [],
    "total_results": 19629,
    "total_pages": 982
}
"""
        return emptyJsonString
    }
    
    
    static func jsonString()->String{
        let jsonString =
        """
{
    "page": 1,
    "results": [
                {
                "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
                "adult": false,
                "overview": "From DC Comics comes the Suicide Squad an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
                "release_date": "2016-08-03",
                "genre_ids": [
                              14,
                              28,
                              80
                              ],
                "id": 297761,
                "original_title": "Suicide Squad",
                "original_language": "en",
                "title": "Suicide Squad",
                "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
                "popularity": 48.261451,
                "vote_count": 1466,
                "video": false,
                "vote_average": 5.91
                },
                {
                "poster_path": "/lFSSLTlFozwpaGlO31OoUeirBgQ.jpg",
                "adult": false,
                "overview": "The most dangerous former operative of the CIA is drawn out of hiding to uncover hidden truths about his past.",
                "release_date": "2016-07-27",
                "genre_ids": [
                              28,
                              53
                              ],
                "id": 324668,
                "original_title": "Jason Bourne",
                "original_language": "en",
                "title": "Jason Bourne",
                "backdrop_path": "/AoT2YrJUJlg5vKE3iMOLvHlTd3m.jpg",
                "popularity": 30.690177,
                "vote_count": 649,
                "video": false,
                "vote_average": 5.25
                },
                {
                "poster_path": "/hU0E130tsGdsYa4K9lc3Xrn5Wyt.jpg",
                "adult": false,
                "overview": "One year after outwitting the FBI and winning the public’s adulation with their mind-bending spectacles, the Four Horsemen resurface only to find themselves face to face with a new enemy who enlists them to pull off their most dangerous heist yet.",
                "release_date": "2016-06-02",
                "genre_ids": [
                              28,
                              12,
                              35,
                              80,
                              9648,
                              53
                              ],
                "id": 291805,
                "original_title": "Now You See Me 2",
                "original_language": "en",
                "title": "Now You See Me 2",
                "backdrop_path": "/zrAO2OOa6s6dQMQ7zsUbDyIBrAP.jpg",
                "popularity": 29.737342,
                "vote_count": 684,
                "video": false,
                "vote_average": 6.64
                }
                ],
    "total_results": 19629,
    "total_pages": 982
}
"""
        return jsonString
    }
    
    
    static func loadListResultJson() -> Data {
        return Data(LoadJson.jsonString().utf8)
    }
    
    static func loadEmptyListResultJson() -> Data {
        return Data(LoadJson.emptyJsonString().utf8)
    }
    
    static func loadGenreListResultString() -> String{
        let jsonString =
        """
{
  "genres": [
    {
      "id": 28,
      "name": "Action"
    },
    {
      "id": 12,
      "name": "Adventure"
    },
    {
      "id": 16,
      "name": "Animation"
    }
  ]
}
"""
        return jsonString
    }
    
    static func loadEmptyGenreListResultString() -> String{
        let jsonString =
        """
            {
  "genres": []
}
"""
    return jsonString
    }
    
    static func loadInvalidResultString()-> String{
        
        let jsonString =
        """
  "genres": []
}
"""
        return jsonString
    }
    
    
    static func loadGenreListResultData() -> Data {
        return Data(LoadJson.loadGenreListResultString().utf8)
    }
    
    static func loadEmptyGenreListResultData() -> Data{
        return Data(LoadJson.loadEmptyGenreListResultString().utf8)
    }

    static func loadInvalidResultData() -> Data{
        return Data(LoadJson.loadInvalidResultString().utf8)
    }
    
}
