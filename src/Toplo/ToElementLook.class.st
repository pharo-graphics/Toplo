Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractElementLook,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #accessing }
ToElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #private }
ToElementLook >> borderBuilderFromElement: anElement [

	^ self next borderBuilderFromElement: anElement
]

{ #category : #private }
ToElementLook >> decoratedBorderBuilderFromElement: anElement [

	^ self first borderBuilderFromElement: anElement
]

{ #category : #private }
ToElementLook >> decoratedTextAttributeBuilderFromElement: anElement [

	^ self first textAttributeBuilderFromElement: anElement
]

{ #category : #'private event handling' }
ToElementLook >> elementStateEvent: anEvent [

	self next ifNotNil: [ self next elementStateEvent: anEvent ].
	anEvent sendToLook: self.

]

{ #category : #testing }
ToElementLook >> hasBackground [

	^ self next hasBackground
]

{ #category : #'event handling' }
ToElementLook >> hoverStateEvent: anEvent [


]

{ #category : #testing }
ToElementLook >> ifBackgoundUpdated: aBlock [

	self isBackgoundUpdater ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #'event handling' }
ToElementLook >> initialStateEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> installStateEvent: anEvent [

]

{ #category : #testing }
ToElementLook >> isBackgoundUpdater [

	^ self first hasBackground 
]

{ #category : #accessing }
ToElementLook >> next [

	^ next
]

{ #category : #accessing }
ToElementLook >> next: aLook [

	next := aLook
]

{ #category : #'event handling' }
ToElementLook >> pressedStateEvent: anEvent [


]

{ #category : #private }
ToElementLook >> textAttributeBuilderFromElement: anElement [

	^ self next textAttributeBuilderFromElement: anElement
]

{ #category : #'event handling' }
ToElementLook >> uninstallStateEvent: anEvent [

]

{ #category : #accessing }
ToElementLook >> updateFirstWith: aLook [

	super updateFirstWith: aLook.
	self next updateFirstWith: aLook
]
