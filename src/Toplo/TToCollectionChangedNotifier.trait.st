Trait {
	#name : #TToCollectionChangedNotifier,
	#instVars : [
		'notificationAllowed'
	],
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notificationAllowed [

	^ notificationAllowed ifNil: [ notificationAllowed := true ]
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyAddedInterval: anInterval [

	self notificationAllowed ifFalse: [ ^ self ].
	self dispatchEvent: (ToCollectionAddEvent new interval: anInterval)
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyEmptinessChangeAfter: aBlock [

	| wasEmpty |
	wasEmpty := self collection isEmpty.
	aBlock value.
	self notificationAllowed ifFalse: [ ^ self ].
	wasEmpty = self collection isEmpty ifFalse: [
			self dispatchEvent: (ToCollectionEmptinessEvent new
					 isEmpty: self collection isEmpty;
					 yourself) ]
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyFilteredInterval: anInterval [

	self notificationAllowed ifFalse: [ ^ self ].
	self dispatchEvent:
		(ToCollectionFilteredEvent new interval: anInterval)
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyRemovedInterval: anInterval [

	self notificationAllowed ifFalse: [ ^ self ].
	self dispatchEvent: (ToCollectionRemoveEvent new
			 interval: anInterval;
			 yourself)
]

{ #category : #'t - observable collection - notifications' }
TToCollectionChangedNotifier >> notifySievedWith: aSieve interval: anInterval [

	notificationAllowed ifFalse: [ ^ self ].
	self dispatchEvent: (ToCollectionSievedEvent new
			 interval: anInterval;
			 sieve: aSieve;
			 yourself)
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> notifyUpdatedInterval: anInterval [

	self notificationAllowed ifFalse: [ ^ self ].
	self dispatchEvent: (ToCollectionUpdateEvent new
			 interval: anInterval;
			 yourself)
]

{ #category : #'t - collection changed notifier' }
TToCollectionChangedNotifier >> preventNotificationWhile: aBlock [

	| prev |
	prev := notificationAllowed.
	aBlock value.
	notificationAllowed := prev
]
