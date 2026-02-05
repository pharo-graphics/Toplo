Trait {
	#name : #TToCollectionChangedNotifier,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyAddedInterval: anInterval [

	self dispatchEvent: (ToCollectionAddEvent new interval: anInterval)
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyEmptinessChangeAfter: aBlock [

	| wasEmpty |
	wasEmpty := self collection isEmpty.
	aBlock value.
	wasEmpty = self collection isEmpty ifFalse: [
			self dispatchEvent: (ToCollectionEmptinessEvent new
					 isEmpty: self collection isEmpty;
					 yourself) ]
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyFilteredInterval: anInterval [

	self dispatchEvent:
		(ToCollectionFilteredEvent new interval: anInterval)
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyRemovedInterval: anInterval [

	self dispatchEvent: (ToCollectionRemoveEvent new
			 interval: anInterval;
			 yourself)
]

{ #category : #'t - observable collection - notifications' }
TToCollectionChangedNotifier >> notifySievedWith: aSieve interval: anInterval [

	self dispatchEvent: (ToCollectionSievedEvent new
			 interval: anInterval;
			 sieve: aSieve;
			 yourself)
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyUpdatedInterval: anInterval [

	self dispatchEvent: (ToCollectionUpdateEvent new
			 interval: anInterval;
			 yourself)
]
