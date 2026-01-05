Class {
	#name : #ToInfiniteDataSourceItemsFiltered,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#category : #'Toplo-Widget-List-InnerInfiniteList'
}

{ #category : #'instance creation' }
ToInfiniteDataSourceItemsFiltered class >> position: aPosition itemCount: anItemCount sieve: aSieve [

	^ (self position: aPosition itemCount: anItemCount)
		  sieve: aSieve;
		  yourself
]

{ #category : #sending }
ToInfiniteDataSourceItemsFiltered >> sendTo: anObject [

	anObject infiniteDataSourceItemsFiltered: self
]
