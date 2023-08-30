Class {
	#name : #ToElementState,
	#superclass : #Object,
	#category : #'Toplo-Core-Theme-States'
}

{ #category : #'look event sending' }
ToElementState >> applyOn: anElement [

	self subclassResponsibility 
]

{ #category : #testing }
ToElementState >> isCloseState [

	^ false
]

{ #category : #testing }
ToElementState >> isDisabledState [

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
ToElementState >> isOpenState [

	^ false
]

{ #category : #testing }
ToElementState >> isPressedState [

	^ false
]

{ #category : #testing }
ToElementState >> isSelectedState [

	^ false
]
