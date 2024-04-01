Class {
	#name : #ToInfiniteDataSourceSieveCommand,
	#superclass : #ToInfiniteDataSourceFilterCommand,
	#instVars : [
		'sieve'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #commands }
ToInfiniteDataSourceSieveCommand >> applyFilterIn: anInfiniteElement [

	anInfiniteElement applyDataSourceSieveCommand: self
]

{ #category : #accessing }
ToInfiniteDataSourceSieveCommand >> sieve [

	^ sieve
]

{ #category : #accessing }
ToInfiniteDataSourceSieveCommand >> sieve: aListElementSieve [

	sieve := aListElementSieve
]
