Class {
	#name : #ToListDataSourceSieveCommand,
	#superclass : #ToListDataSourceFilterCommand,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceSieveCommand >> applyIn: anInfiniteElement [

	anInfiniteElement onAppliedDataSourceSieveCommand: self
]

{ #category : #accessing }
ToListDataSourceSieveCommand >> sieve [

	^ sieve
]

{ #category : #accessing }
ToListDataSourceSieveCommand >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
