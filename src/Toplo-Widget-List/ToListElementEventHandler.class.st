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

	| target |
	target := anEvent currentTarget.
	self flag: 'Check nodeContainingGlobalPosition: because it seems that the conversion from global to local position is not well computed (try with context menu)'.
	lastClickedNode := target infinite nodeContainingGlobalPosition: anEvent position.
	target selectionMode requestFocusOnMouseDown ifFalse: [ ^ self ].
	lastClickedNode ifNil: [
		target requestFocus.
		^ self ].
	"lastClickedNode dispatchEvent: (ToListClickOnNodeEvent new
			 listElement: target;
			 sourceEvent: anEvent;
			 yourself)"
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
				 listElement: target;
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

		  " data source "
		  BlInfiniteDataSourceItemRangeInserted.
		  BlInfiniteDataSourceItemRangeRemoved.


		  " data events "
		  ToCollectionEmptinessEvent }
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteElementAttachedEvent: anEvent [
	
	| listElement node |
	listElement := anEvent currentTarget.
	node := anEvent element.
	node holder listElement: listElement.
	listElement selectionMode onAddedNode: anEvent element
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteElementDataSourceAttachedEvent: anEvent [


]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteElementDataSourceDetachedEvent: anEvent [


]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> infiniteElementDetachedEvent: anEvent [

	| node listElement |
	node := anEvent element.
	listElement := anEvent currentTarget.
	listElement selectionMode onRemovedNode: node.
	node holder listElement: nil.

]

{ #category : #'mouse handlers' }
ToListElementEventHandler >> mouseDownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target selectionMode requestFocusOnMouseDown ifFalse: [ ^ self ].
	target hasFocus ifTrue: [ ^ self ].
	target requestFocus.
	anEvent consumed: true
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> onItemsInserted: anEvent [

	| target |
	target := anEvent currentTarget.
	target selectionModel shift: anEvent itemCount from: anEvent position.
	target requestLayout.
	target enqueueTask: (BlTaskAction new action: [
			 target dispatchEvent: ToListSelectionDirtyEvent new ])
]

{ #category : #'infinite event handling' }
ToListElementEventHandler >> onItemsRemoved: anEvent [

	| target |
	target := anEvent currentTarget.
	target selectionModel
		deselectIndex: anEvent position
		to: anEvent position + anEvent itemCount - 1.
	target selectionModel shift: anEvent itemCount negated from: anEvent position.
	target requestLayout.
	target enqueueTask: (BlTaskAction new action: [
			 target dispatchEvent: ToListSelectionDirtyEvent new ])
]

{ #category : #'data events handling' }
ToListElementEventHandler >> showHidePlaceholderIn: aListElement [

	aListElement data ifEmpty: [ ^ aListElement showPlaceholder ].
	aListElement hidePlaceholder
]
