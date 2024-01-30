Class {
	#name : #ToListSelectionEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'previousNodesArray',
		'previousSelectedIndexes',
		'wasFocused',
		'previousAdjacentNodeGroups'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #'selection managing' }
ToListSelectionEventHandler >> adjacentSelectedNodesGroupsIn: aListElement [
	" return an array of collection. Each collection contains a list of adjacent selected nodes "

	| computed |
	computed := Array streamContents: [ :stream |
		            | g |
		            g := OrderedCollection new.
		            aListElement infinite childrenDo: [ :node |
			            node holder isSelected
				            ifTrue: [ g add: node ]
				            ifFalse: [
					            g ifNotEmpty: [
						            stream nextPut: g.
						            g := OrderedCollection new ] ] ].
		            g ifNotEmpty: [ stream nextPut: g ] ].

	" compare with the previous result. 
		if different, then return the new one (computed). 
		If equals, then return the previous one"

	(previousAdjacentNodeGroups notNil and: [
		 previousAdjacentNodeGroups size = computed ]) ifFalse: [
		^ computed ].
	previousAdjacentNodeGroups with: computed do: [ :pg :g |
		pg size = g size ifFalse: [ ^ computed ].
		pg with: g do: [ :pn :n | pn = n ifFalse: [ ^ computed ] ] ].
	^ previousAdjacentNodeGroups
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
		  ToListSelectionDirtyEvent.
		  ToListSelectionChangedEvent.
		  ToListSelectionElementUpdatedEvent }
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> focusEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> listSelectionChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> listSelectionDirtyEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListSelectionEventHandler >> listSelectionElementUpdatedEvent: anEvent [

	| target nodesArray selectedIndexes focused |
	target := anEvent currentTarget.

	nodesArray := target infinite children asArray.
	selectedIndexes := target infinite selectionStrategy selectedIndexes.
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

	| adjacentNodeGroups target |
	target := anEvent currentTarget.
	adjacentNodeGroups := self adjacentSelectedNodesGroupsIn: target.
	adjacentNodeGroups = previousAdjacentNodeGroups ifTrue: [
		^ nil ].
	previousAdjacentNodeGroups := adjacentNodeGroups.
	^ adjacentNodeGroups collect: [ :g |
		  ToListPrimarySelectionElement new
			  listElement: anEvent currentTarget;
			  nodes: g;
			  yourself ]
]

{ #category : #'selection managing' }
ToListSelectionEventHandler >> updatePrimarySelectionFromEvent: anEvent [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	| newSelElements target previous |
	target := anEvent currentTarget.
	previous := target selectionElements copy.
	newSelElements := self newPrimarySelectionElementsFromEvent: anEvent.
	newSelElements
		ifNil: [ previous do: [ :s | s computeBounds ] ]
		ifNotNil: [
			previous do: [ :s | s removeFromParent ].
			target addChildren: newSelElements.
			target selectionElements: newSelElements ].
	target dispatchEvent: ToListSelectionElementUpdatedEvent new
]
