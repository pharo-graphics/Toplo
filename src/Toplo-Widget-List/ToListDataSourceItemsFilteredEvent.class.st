Class {
	#name : #ToListDataSourceItemsFilteredEvent,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #'instance creation' }
ToListDataSourceItemsFilteredEvent class >> position: aPosition itemCount: anItemCount sieve: aSieve [

	^ (self position: aPosition itemCount: anItemCount)
		  sieve: aSieve;
		  yourself
]

{ #category : #sending }
ToListDataSourceItemsFilteredEvent >> sendTo: anObject [

	anObject infiniteDataSourceItemsFilteredEvent: self
]
