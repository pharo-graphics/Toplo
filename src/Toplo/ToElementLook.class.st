Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractElementLook,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Theme-Skins'
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
ToElementLook >> decoratedTextAttributesBuilderFromElement: anElement [

	^ self first textAttributesBuilderFromElement: anElement
]

{ #category : #'private event handling' }
ToElementLook >> elementLookEvent: anEvent [

	self next ifNotNil: [ self next elementLookEvent: anEvent ].
	anEvent sendToLook: self.

]

{ #category : #testing }
ToElementLook >> hasBackground [

	^ self next hasBackground
]

{ #category : #'event handling' }
ToElementLook >> hoverLookEvent: anEvent [


]

{ #category : #testing }
ToElementLook >> ifBackgoundUpdated: aBlock [

	self isBackgoundUpdater ifFalse: [ ^ self ].
	aBlock value
]

{ #category : #'event handling' }
ToElementLook >> initialLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> installLookEvent: anEvent [

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
ToElementLook >> pressedLookEvent: anEvent [


]

{ #category : #private }
ToElementLook >> textAttributesBuilderFromElement: anElement [

	^ self next textAttributesBuilderFromElement: anElement
]

{ #category : #'event handling' }
ToElementLook >> uninstallLookEvent: anEvent [

]

{ #category : #accessing }
ToElementLook >> updateFirstWith: aLook [

	super updateFirstWith: aLook.
	self next updateFirstWith: aLook
]
