Class {
	#name : #ToListElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'lastClickedNode'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'mouse handlers' }
ToListElementEventHandler >> clickEvent: anEvent [

	| infiniteElement target |
	target := anEvent currentTarget.
	lastClickedNode := target infinite nodeContainingGlobalPosition: anEvent position.
	lastClickedNode ifNil: [
		target requestFocus.
		^ self ].
	lastClickedNode dispatchEvent: (ToListClickOnNodeEvent new
			 sourceEvent: anEvent;
			 yourself)
]

{ #category : #'data events handling' }
ToListElementEventHandler >> collectionEmptinessEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> doubleClickEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	lastClickedNode ifNotNil: [
		lastClickedNode dispatchEvent: (ToListDoubleClickOnNodeEvent new
				 sourceEvent: anEvent;
				 yourself) ].
	anEvent consumed: true
]

{ #category : #'element events handling' }
ToListElementEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self showHidePlaceholderIn: target
]

{ #category : #'element handlers' }
ToListElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]

{ #category : #'api - accessing' }
ToListElementEventHandler >> eventsToHandle [

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
ToListElementEventHandler >> infiniteElementAttachedEvent: anEvent [

	anEvent currentTarget selectionStrategy onAddedNode: anEvent element
]

{ #category : #'event handling' }
ToListElementEventHandler >> infiniteElementDataSourceAttachedEvent: anEvent [


]

{ #category : #'event handling' }
ToListElementEventHandler >> infiniteElementDataSourceDetachedEvent: anEvent [


]

{ #category : #'event handling' }
ToListElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	anEvent currentTarget selectionStrategy onRemovedNode: anEvent element
]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target requestFocusOnMouseDown ifFalse: [ ^ self ].
	target hasFocus ifTrue: [ ^ self ].
	target requestFocus.
	anEvent consumed: true
]

{ #category : #'data events handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement data ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]
