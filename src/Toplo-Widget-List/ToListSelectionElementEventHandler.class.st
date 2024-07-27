Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> differUpdateSelectionFrom: target [

]

{ #category : #'api - accessing' }
ToListSelectionElementEventHandler >> eventsToHandle [

	^ {  }
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> refreshSelectionFromEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	anEvent groupHolder ifNotNil: [:gh | gh refreshSelectionIn: target ]
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updateSelectionFromEvent: anEvent [
	" the selection has changed but the touched indexes is empty means 
	that a selection element remains for removed indexes"

	| target |
	target := anEvent currentTarget.
	anEvent touchedIndexes ifEmpty: [
		self refreshSelectionFromEvent: anEvent.
		^ self ].

	target isAttachedToSceneGraph ifFalse: [
		self differUpdateSelectionFrom: target.
		^ self ].

	anEvent groupHolder updateSelectionIn: target
]
