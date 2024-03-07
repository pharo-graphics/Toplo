Class {
	#name : #ToListSecondarySelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'postponedUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> addSecondarySelectionIn: aListElement onNodes: aNodeCollection [
	" update selection decoration to show the secondary selection on which the popup is opened"

	(self
		 newSelectionElementsFromSelectedNodes: aNodeCollection
		 in: aListElement) do: [ :s | aListElement addChild: s ]
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> criticalUpdateSelectionFromEvent: anEvent [

	anEvent currentTarget layoutCritical: [
		self updateSelectionFromEvent: anEvent ]
]

{ #category : #'element handlers' }
ToListSecondarySelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	anEvent currentTarget spaceDo: [ :sp | 
		sp mouseProcessor handleLastMouseMove ].
	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSecondarySelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.
		  ToInfiniteScrollFinishedEvent.
		  ToListSecondarySelectionChangedEvent.
		  BlMouseMoveEvent }
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> infiniteScrollFinishedEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> listSecondarySelectionChangedEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> mouseMoveEvent: anEvent [

	| target infinite globalPosition childNode |
	anEvent anyButtonPressed ifTrue: [ ^ self ].
	target := anEvent currentTarget.
	infinite := target infinite.
	globalPosition := anEvent position.
	target layoutCritical: [
		childNode := infinite children
			             detect: [ :node |
				             node holder isSelectable and: [
					             node containsGlobalPoint: globalPosition ] ]
			             ifNone: [  ] ].
	childNode ifNil: [
		target secondarySelecter deselectAll.
		^ self ].
	target secondarySelecter selectOnlyIndex: childNode holder position
]

{ #category : #'instance creation' }
ToListSecondarySelectionElementEventHandler >> newSelectionElementsFromSelectedNodes: aCollection in: aListElement [
	" return a collection with instances of ToListSecondarySelectionElement "

	| adjacentNodeGroups |
	adjacentNodeGroups := aListElement infinite nodeGroupsSatisfying: [
		                      :n | aCollection includes: n ].
	^ adjacentNodeGroups collect: [ :g |
		  ToListSecondarySelectionElement new
			  listElement: aListElement;
			  nodes: g;
			  yourself ]
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> postponeSelectionElementUpdateFromEvent: anEvent in: anElement [

	postponedUpdateTask ifNotNil: [ ^ self ].
	postponedUpdateTask := BlTaskAction new action: [
		                      anElement dispatchEvent: anEvent.
		                      postponedUpdateTask := nil ].
	anElement enqueueTask: postponedUpdateTask
]

{ #category : #'mouse handlers' }
ToListSecondarySelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	| target infinite childNodes previous |
	target := anEvent currentTarget.

	target isAttachedToSceneGraph ifFalse: [
		self postponeSelectionElementUpdateFromEvent: anEvent in: target.
		^ self ].

	infinite := target infinite.
	previous := target secondarySelectionElements.

	"infinite childrenDo: [ :node |
		| holder |
		holder := infinite elementHolderOf: node.
		holder isTmpDetached ifTrue: [
			self postponeSelectionElementUpdateFromEvent: anEvent in: target.
			^ self ] ]."

"	previous do: [ :s |
		s skinManagerDo: [ :sm |
			sm isInstallingSkin ifTrue: [
				self postponeSelectionElementUpdateFromEvent: anEvent in: target.
				^ self ] ] ]."

	previous do: [ :s | s removeFromParent ].
	target secondarySelectionModel ifEmpty: [ ^ self ].
	childNodes := infinite children select: [ :node |
		              node holder isSelectable and: [
			              target secondarySelectionModel containsIndex:
				              node holder position ] ].
	childNodes ifEmpty: [ ^ self ].
	self addSecondarySelectionIn: target onNodes: childNodes
]
