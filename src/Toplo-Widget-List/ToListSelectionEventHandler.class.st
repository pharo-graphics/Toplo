Class {
	#name : #ToListSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousNodesArray',
		'previousSelectedIndexes',
		'wasFocused'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'selection managing' }
ToListSelectionEventHandler >> adjacentSelectedNodesGroupsIn: aListElement [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	^ Array streamContents: [ :stream |
		  | g |
		  g := OrderedCollection new.
		  aListElement infinite childrenDo: [ :node |
			  (node holder isSelected)
				  ifTrue: [ g add: node ]
				  ifFalse: [
					  g ifNotEmpty: [
						  stream nextPut: g.
						  g := OrderedCollection new ] ] ].
		  g ifNotEmpty: [ stream nextPut: g ] ]
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> blurEvent: anEvent [

	" Don't update the selection when the element is removed from the scene 
	This is the case if the event reason is for element removal "
	anEvent isDueToRemoval ifTrue: [ ^ self ].
	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> elementExtentChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> elementScrolledEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToListSelectionEventHandler >> eventsToHandle [

	^ {
		  BlFocusEvent.
		  BlBlurEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.
		  ToInfiniteSelectionDirtyEvent.
		  ToListSelectionChangedEvent.
		  ToListSelectionElementUpdatedEvent }
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> focusEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> infiniteSelectionDirtyEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> listSelectionChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> listSelectionElementUpdatedEvent: anEvent [

	| target nodesArray selectedIndexes focused |
	target := anEvent currentTarget.

	nodesArray := target infinite children asArray.
	selectedIndexes := target infinite selectedIndexes.
	focused := target infinite isFocused.
	
	" ** important note **
	do not send unnecessary event here. 
	If not then the consequence is an infinite layout request loop. 
	(which would be normal since dispatching a node change event 
	implies the skin application which implies a layout request somewhere... ) "
	
	(previousNodesArray = nodesArray and: [
		 previousSelectedIndexes = selectedIndexes and: [
			 wasFocused = focused ] ]) ifTrue: [ ^ self ].
	wasFocused := focused.
	previousNodesArray := nodesArray.
	previousSelectedIndexes := selectedIndexes.
	
	" Ok, the state of the infinite has changed "
	
	nodesArray do: [ :node |
		node dispatchEvent: (ToNodeSelectionEvent new
				 infiniteElement: target;
				 selected: (selectedIndexes includes: node holder position)) ]
]

{ #category : #'selection managing' }
ToListSelectionEventHandler >> newPrimarySelectionElementsFromEvent: anEvent [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: anEvent currentTarget)
		  collect: [ :g |
			  ToListPrimarySelectionElement new
				  listElement: anEvent currentTarget;
				  nodes: g;
				  yourself ]
]

{ #category : #'selection managing' }
ToListSelectionEventHandler >> updatePrimarySelectionFromEvent: anEvent [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	| newSelectionElements target |
	target := anEvent currentTarget.
	target selectionElements do: [ :s |
		s removeFromParent ].
	newSelectionElements := self newPrimarySelectionElementsFromEvent: anEvent.
	target addChildren: newSelectionElements.
	target selectionElements: newSelectionElements.
	target dispatchEvent: ToListSelectionElementUpdatedEvent new
]
