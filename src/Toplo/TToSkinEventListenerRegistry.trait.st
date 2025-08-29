Trait {
	#name : #TToSkinEventListenerRegistry,
	#instVars : [
		'skinEventListeners'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'t - skin event listener registry' }
TToSkinEventListenerRegistry >> addAllSkinEventListeners: aListenerCollection [

	self skinEventListeners addAll: aListenerCollection
]

{ #category : #'t - skin event listener registry' }
TToSkinEventListenerRegistry >> addSkinEventListener: aListener [

	self skinEventListeners add: aListener
]

{ #category : #'t - skin event listener registry' }
TToSkinEventListenerRegistry >> removeAllSkinEventListeners [

	self removeAllSkinEventListeners: self skinEventListeners 
]

{ #category : #'t - skin event listener registry' }
TToSkinEventListenerRegistry >> removeAllSkinEventListeners: aListenerCollection [

	self skinEventListeners removeAll: aListenerCollection
]

{ #category : #'t - skin event listener registry' }
TToSkinEventListenerRegistry >> removeSkinEventListener: aListener [

	self skinEventListeners remove: aListener
]

{ #category : #'t - skin event listener registry' }
TToSkinEventListenerRegistry >> skinEventListeners [

	^ skinEventListeners ifNil: [
		  skinEventListeners := OrderedCollection new ]
]

{ #category : #'t - skin event listener registry' }
TToSkinEventListenerRegistry >> skinEventListeners: anEventListenerCollection [

	self removeAllSkinEventListeners.
	self addAllSkinEventListeners: anEventListenerCollection
]
