Class {
	#name : #ToElementState,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #testing }
ToElementState >> isDisabledState [

	^ false
]

{ #category : #testing }
ToElementState >> isEnabledState [

	^ false
]

{ #category : #testing }
ToElementState >> isFocusedState [

	^ false
]

{ #category : #testing }
ToElementState >> isHoveredState [

	^ false
]

{ #category : #testing }
ToElementState >> isInitialState [

	^ false
]

{ #category : #testing }
ToElementState >> isPressedState [

	^ false
]

{ #category : #'look event sending' }
ToElementState >> sendEvent: anEvent toLook: aLook [

	self subclassResponsibility 
]
