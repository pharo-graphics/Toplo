Class {
	#name : #ToTreeDataSource,
	#superclass : #ToInfiniteCollectionDataSource,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - observable collection - initialization' }
ToTreeDataSource >> onSievedWith: aSieve [

	| interval roots |
	interval := 1 to: aSieve currentData size.
	roots := aSieve currentData select: [:w | w isRoot ].
	roots do: [ :r | r collapse ].
	self notifyEmptinessChangeAfter: [
			self initializeWith: (roots).
			self notifySievedWith: aSieve interval: interval ]
]
