Class {
	#name : #ToInfiniteDataSourceItemsSieved,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-InnerInfiniteList'
}

{ #category : #'instance creation' }
ToInfiniteDataSourceItemsSieved class >> position: aPosition itemCount: anItemCount sieve: aSieve [

	^ (self position: aPosition itemCount: anItemCount)
		  sieve: aSieve;
		  yourself
]

{ #category : #sending }
ToInfiniteDataSourceItemsSieved >> sendTo: anObject [

	anObject infiniteDataSourceItemsSieved: self
]

{ #category : #accessing }
ToInfiniteDataSourceItemsSieved >> sieve [

	^ sieve
]

{ #category : #accessing }
ToInfiniteDataSourceItemsSieved >> sieve: aSieve [

	sieve := aSieve
]
