Class {
	#name : #ToElementLook,
	#superclass : #ToAbstractElementLook,
	#instVars : [
		'next'
	],
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #accessing }
ToElementLook class >> next: aLook [

	^ self new next: aLook
]

{ #category : #private }
ToElementLook >> addedInSkin: aSkin [

	self isMain
		ifTrue: [ aSkin setMainLook: self ]
		ifFalse: [ aSkin addLookDecorator: self ]
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

	"anEvent backgoundUpdater: self hasBackground."
	self next ifNotNil: [ self next elementLookEvent: anEvent ].
	anEvent sendToLook: self.

]

{ #category : #'event handling' }
ToElementLook >> initialLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> installLookEvent: anEvent [

]

{ #category : #testing }
ToElementLook >> isMain [

	^ false
]

{ #category : #testing }
ToElementLook >> isNull [

	^ false
]

{ #category : #'event handling' }
ToElementLook >> mouseHoverLookEvent: anEvent [


]

{ #category : #'event handling' }
ToElementLook >> mouseLeavedLookEvent: anEvent [

	anEvent target dispatchEvent: (ToInitialLookEvent new copyFrom: anEvent)


]

{ #category : #'event handling' }
ToElementLook >> mousePressedLookEvent: anEvent [


]

{ #category : #accessing }
ToElementLook >> next [

	^ next
]

{ #category : #accessing }
ToElementLook >> next: aLook [

	next := aLook
]

{ #category : #removing }
ToElementLook >> removeLook: aLook previous: previousLook [

	previousLook ifNotNil: [
		self = aLook ifTrue: [
			previousLook next: self next.
			^ self ] ].
	self next removeLook: aLook previous: self
]

{ #category : #private }
ToElementLook >> setAsMainLookIn: aSkin current: currentLook previous: previousLook [

	currentLook isMain ifFalse: [
		^ self
			  setAsMainLookIn: aSkin
			  current: currentLook next
			  previous: currentLook ].
	self next: currentLook next.
	previousLook isNil
		ifTrue: [ aSkin privateLook: self ]
		ifFalse: [ previousLook next: self ]
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
