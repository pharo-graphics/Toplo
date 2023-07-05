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

	^ anElement privateSkin borderBuilderFromElement: anElement
]

{ #category : #private }
ToElementLook >> decoratedTextAttributeBuilderFromElement: anElement [

	^ anElement privateSkin textAttributeBuilderFromElement: anElement
]

{ #category : #'private event handling' }
ToElementLook >> elementStateEvent: anEvent [

	self next ifNotNil: [ self next elementStateEvent: anEvent ].
	anEvent sendToLook: self.

]

{ #category : #'event handling' }
ToElementLook >> installStateEvent: anEvent [

]

{ #category : #accessing }
ToElementLook >> next [

	^ next
]

{ #category : #accessing }
ToElementLook >> next: aLook [

	next := aLook
]

{ #category : #private }
ToElementLook >> textAttributeBuilderFromElement: anElement [

	^ self next textAttributeBuilderFromElement: anElement
]

{ #category : #'event handling' }
ToElementLook >> uninstallStateEvent: anEvent [

]
