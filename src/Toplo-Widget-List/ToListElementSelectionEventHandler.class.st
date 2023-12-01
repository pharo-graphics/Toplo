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

	(self selectionElementsIn: anEvent currentTarget) do: [ :d |
		d focused: false.
		d dispatchEvent: (anEvent copy consumed: false) ]
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

	(self selectionElementsIn: anEvent currentTarget) do: [ :d |
		d focused: true.
		d dispatchEvent: (anEvent copy consumed: false) ]
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> listElementSelectionChangedEvent: anEvent [

	self updatePrimarySelectionFromEvent: anEvent
]

{ #category : 'element handlers' }
ToListElementSelectionEventHandler >> listSelectionElementUpdatedEvent: anEvent [

	| target focusEventClass |
	target := anEvent currentTarget.
	focusEventClass := target infinite isFocused
		                   ifTrue: [ BlFocusEvent ]
		                   ifFalse: [ BlBlurEvent ].
	(self selectionElementsIn: target) do: [ :d |
		d focused: target infinite isFocused.
		d dispatchEvent: (focusEventClass new
				 yourself) ]
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

	| prevSelection newSelection background |
	prevSelection := self selectionElementsIn: anEvent currentTarget.
	prevSelection do: [ :d | d removeFromParent ].
	newSelection := self newPrimarySelectionFromEvent: anEvent.
	" optimization: because selection element can be added/removed very intensively 
	one have to anticipate its background to avoid a disturbing flash effect due to 
	separate styling phases "
	anEvent currentTarget installedSkin ifNotNil: [
		background := anEvent currentTarget tokenValueNamed: #'color-primary-selection-focused'.
		newSelection do: [ :sel | sel background: background ] ].
	anEvent currentTarget addChildren: newSelection.
	anEvent currentTarget dispatchEvent:
		ToListSelectionElementUpdatedEvent new
]
