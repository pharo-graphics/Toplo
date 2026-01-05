Class {
	#name : #ToListDataSourceItemsSievedEvent,
	#superclass : #BlInfiniteDataSourceRangeChanged,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #'instance creation' }
ToListDataSourceItemsSievedEvent class >> position: aPosition itemCount: anItemCount sieve: aSieve [

	^ (self position: aPosition itemCount: anItemCount)
		  sieve: aSieve;
		  yourself
]

{ #category : #sending }
ToListDataSourceItemsSievedEvent >> sendTo: anObject [

	anObject listDataSourceItemsSievedEvent: self
]

{ #category : #accessing }
ToListDataSourceItemsSievedEvent >> sieve [

	^ sieve
]

{ #category : #accessing }
ToListDataSourceItemsSievedEvent >> sieve: aSieve [

	sieve := aSieve
]
