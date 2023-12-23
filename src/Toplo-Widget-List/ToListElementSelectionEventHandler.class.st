Class {
	#name : 'ToListElementSelectionEventHandler',
	#superclass : 'BlCustomEventHandler',
	#instVars : [
		'previousNodesArray',
		'previousSelectedIndexes',
		'wasFocused'
	],
	#category : 'Toplo-Widget-List-Selection',
	#package : 'Toplo-Widget-List',
	#tag : 'Selection'
}

{ #category : 'selection managing' }
ToListElementSelectionEventHandler >> adjacentSelectedNodesGroupsIn: aListElement [
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

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> blurEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> elementExtentChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> elementScrolledEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : 'api - accessing' }
ToListElementSelectionEventHandler >> eventsToHandle [

	^ {
		  BlFocusEvent.
		  BlBlurEvent.
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.
		  ToListElementSelectionChangedEvent.
		  ToListSelectionElementUpdatedEvent }
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> focusEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> listElementSelectionChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> listSelectionElementUpdatedEvent: anEvent [

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
		node dispatchEvent: (ToListNodeSelectionEvent new
				 listElement: target;
				 selected: (selectedIndexes includes: node holder position)) ]
]

{ #category : 'selection managing' }
ToListElementSelectionEventHandler >> newPrimarySelectionElementsFromEvent: anEvent [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: anEvent currentTarget)
		  collect: [ :g |
			  ToListPrimarySelectionElement new
				  listElement: anEvent currentTarget;
				  nodes: g;
				  yourself ]
]

{ #category : 'selection managing' }
ToListElementSelectionEventHandler >> updatePrimarySelectionFromEvent: anEvent [
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
