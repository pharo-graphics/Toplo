Trait {
	#name : #TToLookEventListenerRegistry,
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> addAllLookEventListeners: aListenerCollection [

	self lookEventListeners addAll: aListenerCollection
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> addLookEventListener: aListener [

	self lookEventListeners add: aListener
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> lookEventListeners [

	^ self rawLookEventListeners ifNil: [
		  self rawLookEventListeners: OrderedCollection new.
		  self rawLookEventListeners ]
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> lookEventListeners: aLookEventListenerCollection [

	self removeAllLookEventListeners.
	self addAllLookEventListeners: aLookEventListenerCollection
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> rawLookEventListeners [

	^ self explicitRequirement 
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> rawLookEventListeners: aLookEventListenerCollection [

	self explicitRequirement
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> removeAllLookEventListeners [

	self removeAllLookEventListeners: self lookEventListeners 
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> removeAllLookEventListeners: aListenerCollection [

	self lookEventListeners removeAll: aListenerCollection
]

{ #category : #'t - look event listener registry' }
TToLookEventListenerRegistry >> removeLookEventListener: aListener [

	self lookEventListeners remove: aListener
]
