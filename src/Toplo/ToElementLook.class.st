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

	^ anElement privateSkin look borderBuilderFromElement: anElement
]

{ #category : #'event handling' }
ToElementLook >> elementAddedToSceneGraphEvent: anEvent [

	self next ifNil: [ ^ self ].
	self next elementAddedToSceneGraphEvent: anEvent
	
]

{ #category : #'event handling' }
ToElementLook >> elementRemovedFromSceneGraphEvent: anEvent [

	self next ifNil: [ ^ self ].
	self next elementRemovedFromSceneGraphEvent: anEvent

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
