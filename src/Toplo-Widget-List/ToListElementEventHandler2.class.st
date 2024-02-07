Class {
	#name : #ToListElementEventHandler2,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'lastClickedNode'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'mouse handlers' }
ToListElementEventHandler2 >> clickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	lastClickedNode := target infinite nodeContainingGlobalPosition: anEvent position.
	lastClickedNode ifNil: [
		target requestFocus.
		^ self ].
	lastClickedNode dispatchEvent: (ToListClickOnNodeEvent new
			 listElement: target;
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #'data events handling' }
ToListElementEventHandler2 >> collectionEmptinessEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'mouse handlers' }
ToListElementEventHandler2 >> doubleClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	lastClickedNode ifNotNil: [
		lastClickedNode dispatchEvent: (ToListDoubleClickOnNodeEvent new
				 listElement: target;
				 sourceEvent: anEvent;
				 yourself) ].
	anEvent consumed: true
]

{ #category : #'element events handling' }
ToListElementEventHandler2 >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'element handlers' }
ToListElementEventHandler2 >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]

{ #category : #'api - accessing' }
ToListElementEventHandler2 >> eventsToHandle [

	^ {
		  BlElementAddedToSceneGraphEvent.
		  BlElementScrolledEvent.
		  BlInfiniteElementAttachedEvent.
		  BlInfiniteElementDetachedEvent.
		  ToDataSourceAttachedEvent.
		  ToDataSourceDetachedEvent.

		  BlMouseDownEvent.
		  BlPrimaryClickEvent.
		  BlDoubleClickEvent.

		  " data events "
		  ToCollectionEmptinessEvent }
]

{ #category : #'event handling' }
ToListElementEventHandler2 >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget selectionMode onAddedNode: anEvent element
]

{ #category : #'event handling' }
ToListElementEventHandler2 >> infiniteElementDataSourceAttachedEvent: anEvent [


]

{ #category : #'event handling' }
ToListElementEventHandler2 >> infiniteElementDataSourceDetachedEvent: anEvent [


]

{ #category : #'event handling' }
ToListElementEventHandler2 >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget selectionMode onRemovedNode: anEvent element
]

{ #category : #'mouse handlers' }
ToListElementEventHandler2 >> mouseDownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target selectionMode requestFocusOnMouseDown ifFalse: [ ^ self ].
	target hasFocus ifTrue: [ ^ self ].
	target requestFocus.
	anEvent consumed: true
]

{ #category : #'data events handling' }
ToListElementEventHandler2 >> showHidePlaceholderIn: aListElement [

	aListElement data ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]
