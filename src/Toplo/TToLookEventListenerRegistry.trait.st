Trait {
	#name : #TToLookEventListenerRegistry,
	#instVars : [
		'skinEventListeners'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'t - skin event listener registry' }
TToLookEventListenerRegistry >> addAllSkinEventListeners: aListenerCollection [

	self skinEventListeners addAll: aListenerCollection
]

{ #category : #'t - skin event listener registry' }
TToLookEventListenerRegistry >> addSkinEventListener: aListener [

	self skinEventListeners add: aListener
]

{ #category : #'t - skin event listener registry' }
TToLookEventListenerRegistry >> removeAllSkinEventListeners [

	self removeAllSkinEventListeners: self skinEventListeners 
]

{ #category : #'t - skin event listener registry' }
TToLookEventListenerRegistry >> removeAllSkinEventListeners: aListenerCollection [

	self skinEventListeners removeAll: aListenerCollection
]

{ #category : #'t - skin event listener registry' }
TToLookEventListenerRegistry >> removeSkinEventListener: aListener [

	self skinEventListeners remove: aListener
]

{ #category : #'t - skin event listener registry' }
TToLookEventListenerRegistry >> skinEventListeners [

	^ skinEventListeners ifNil: [
		  skinEventListeners := OrderedCollection new ]
]

{ #category : #'t - skin event listener registry' }
TToLookEventListenerRegistry >> skinEventListeners: anEventListenerCollection [

	self removeAllSkinEventListeners.
	self addAllSkinEventListeners: anEventListenerCollection
]
