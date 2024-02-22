Class {
	#name : #ToListSelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> adjacentSelectedNodesGroupsIn: aListElement [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  aListElement infinite childrenDo: [ :node |
			  node holder isSelected
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> blurEvent: anEvent [

	" Don't update the selection when the element is removed from the scene 
	This is the case if the event reason is for element removal "
	anEvent isDueToRemoval ifTrue: [ ^ self ].
	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> elementScrolledEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlFocusEvent.
		  BlBlurEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.
		  ToListSelectionDirtyEvent.
		  ToListSelectionChangedEvent}
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> focusEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> listSelectionChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> listSelectionDirtyEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> newPrimarySelectionElementsFromEvent: anEvent [
	" return a collection with instances of ToListPrimarySelectionElement "

	| adjacentNodeGroups target |
	target := anEvent currentTarget.
	adjacentNodeGroups := self adjacentSelectedNodesGroupsIn: target.
	^ adjacentNodeGroups collect: [ :g |
		  ToListPrimarySelectionElement new
			  listElement: target;
			  nodes: g;
			  yourself ]
]

{ #category : #'element handlers' }
ToListSelectionElementEventHandler >> onListSelectionElementUpdatedFromEvent: anEvent [

	| target nodesArray selectionModel |
	target := anEvent currentTarget.

	nodesArray := target infinite children asArray.
	selectionModel := target selectionModel.

	" Dispatch the event that is used by the skin state generator to generate the selection state "
	nodesArray do: [ :node |
		node dispatchEvent: (ToListNodeSelectedEvent new
				 listElement: target;
				 selected: (selectionModel containsIndex: node holder position)) ]
]

{ #category : #'selection managing' }
ToListSelectionElementEventHandler >> updatePrimarySelectionFromEvent: anEvent [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	| newSelElements target previous |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [ ^ self ].
	previous := target selectionElements.
	newSelElements := self newPrimarySelectionElementsFromEvent: anEvent.
	previous do: [ :s | s removeFromParent ].
	target addChildren: newSelElements.
	target selectionElements: newSelElements.
	self onListSelectionElementUpdatedFromEvent: anEvent
]
