Class {
	#name : 'ToListElementSelectionEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Widget-List-core',
	#package : 'Toplo-Widget-List',
	#tag : 'core'
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

	(self selectionElementsIn: anEvent currentTarget) do: [ :d | d blurEvent: anEvent ]
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
		  ToListElementSelectionChangedEvent }
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> focusEvent: anEvent [

	(self selectionElementsIn: anEvent currentTarget) do: [ :d | d focusEvent: anEvent ]
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> listElementSelectionChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : 'selection managing' }
ToListElementSelectionEventHandler >> newPrimarySelectionFromEvent: anEvent [
	" return a collection with instances of ListSelectionDecorationElement "

	^ (self adjacentSelectedNodesGroupsIn: anEvent currentTarget)
		  collect: [ :g |
			  ToListPrimarySelectionElement new
				  listElement: anEvent currentTarget;
				  nodes: g;
				  yourself ]
]

{ #category : 'accessing' }
ToListElementSelectionEventHandler >> primarySelectionElementClass [

	^ ToListPrimarySelectionElement 
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> selectionElementsIn: aListElement [

	^ aListElement allChildrenBreadthFirstSelect: [ :child |
		  child isKindOf: ToListPrimarySelectionElement ]
]

{ #category : 'selection managing' }
ToListElementSelectionEventHandler >> updatePrimarySelectionFromEvent: anEvent [
	"add a ListDecorationElement for each group of adjacent selected nodes "

	(self selectionElementsIn: anEvent currentTarget) do: [ :d | d removeFromParent ].
	anEvent currentTarget addChildren: (self newPrimarySelectionFromEvent: anEvent).
	anEvent currentTarget dispatchEvent: ToListSelectionElementUpdatedEvent new

]
