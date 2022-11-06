Trait {
	#name : #TToObservable,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Observable'
}

{ #category : #events }
TToObservable >> property: aName whenChangedSend: aSelector to: anObject [
	 
	"Obtain the raw value.
	We need to access the underlying value holder to subscribe to it"
	(self observablePropertyNamed: aName) whenChangedDo: ((MessageSend receiver: anObject selector: aSelector))
]
