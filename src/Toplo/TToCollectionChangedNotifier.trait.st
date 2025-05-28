Trait {
	#name : #TToCollectionChangedNotifier,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - observable collection - notifications' }
TToCollectionChangedNotifier >> notifyAddedInterval: anInterval [

	self dispatchEvent: (ToCollectionAddEvent new interval: anInterval)
]

{ #category : #'t - observable collection - notifications' }
TToCollectionChangedNotifier >> notifyEmptinessChangeAfter: aBlock [

	| wasEmpty |
	wasEmpty := self collection isEmpty.
	aBlock value.
	wasEmpty = self collection isEmpty ifFalse: [
		self dispatchEvent: ToCollectionEmptinessEvent new ]
]

{ #category : #'t - observable collection - notifications' }
TToCollectionChangedNotifier >> notifyFilteredInterval: anInterval [

	self dispatchEvent:
		(ToCollectionFilteredEvent new interval: anInterval)
]

{ #category : #'t - observable collection - notifications' }
TToCollectionChangedNotifier >> notifyRemoved: aCollection interval: anInterval [

	self dispatchEvent: (ToCollectionRemoveEvent new
			 interval: anInterval;
			 removed: aCollection;
			 yourself)
]

{ #category : #'t - observable collection - notifications' }
TToCollectionChangedNotifier >> notifySievedWith: aSieve interval: anInterval [

	self dispatchEvent: (ToCollectionSievedEvent new
			 interval: anInterval;
			 sieve: aSieve;
			 yourself)
]
