Class {
	#name : 'ToListElementSelectionEventHandler',
	#superclass : 'BlCustomEventHandler',
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

	anEvent currentTarget selectionElements do: [ :d |
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

	anEvent currentTarget selectionElements do: [ :d |
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
	target selectionElements do: [ :d |
		d focused: target infinite isFocused.
		d dispatchEvent: (focusEventClass new
				 yourself) ]
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
	target selectionElements do: [ :d | d removeFromParent ].
	newSelectionElements := self newPrimarySelectionElementsFromEvent: anEvent.
	target addChildren: newSelectionElements.
	target selectionElements: newSelectionElements.
	target dispatchEvent: ToListSelectionElementUpdatedEvent new
]
