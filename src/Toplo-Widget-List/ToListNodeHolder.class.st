Class {
	#name : 'ToListNodeHolder',
	#superclass : 'BlInfiniteHolder',
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'data',
		'eventDispatcher',
		'clickHandler',
		'deselectHandler',
		'selectHandler'
	],
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'accessing' }
ToListNodeHolder >> data [

	^ data
]

{ #category : 'accessing' }
ToListNodeHolder >> data: aData [ 

	data := aData.
	self node: infiniteElement nodeClass new.
	infiniteElement nodeBuilder value: self node value: self
]

{ #category : 'event management accessing' }
ToListNodeHolder >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : 'initialization' }
ToListNodeHolder >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : 'accessing' }
ToListNodeHolder >> isSelected [

	^ self infiniteElement isSelectedAtIndex: self position
]

{ #category : 'accessing' }
ToListNodeHolder >> node [

	^ self itemElement 
]

{ #category : 'accessing' }
ToListNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : 'accessing' }
ToListNodeHolder >> onAttachedFromDatasource: aDataSource [

	clickHandler := BlEventHandler
		                on: ToClickOnListNodeEvent
		                do: [ :event | infiniteElement whenClickOnNodeEvent: event ].

	deselectHandler := BlEventHandler
		                   on: ToListSelectionModelDeselectEvent
		                   do: [ :event | self whenDeselectEvent: event ].

	selectHandler := BlEventHandler
		                 on: ToListSelectionModelSelectEvent
		                 do: [ :event | self whenSelectEvent: event ].

	self addEventHandler: clickHandler.
	infiniteElement primarySelection addEventHandler: deselectHandler.
	infiniteElement primarySelection addEventHandler: selectHandler.

	" when holder is attached it can be already selected (as an example with a selectAll) "
	"Selection must be preserved "
	self isSelected ifFalse: [ ^ self ].
	self selected: true
]

{ #category : 'accessing' }
ToListNodeHolder >> onDetachedFromDatasource: aDataSource [

	self removeEventHandler: clickHandler.
	infiniteElement primarySelection removeEventHandler: deselectHandler.
	infiniteElement primarySelection removeEventHandler: selectHandler.
	
	clickHandler := nil.
	deselectHandler := nil.
	selectHandler := nil

]

{ #category : 'accessing' }
ToListNodeHolder >> selected: aBoolean [

	aBoolean
		ifTrue: [ self node dispatchEvent: (ToListNodeHolderSelectedEvent new holder: self; yourself) ]
		ifFalse: [ self node dispatchEvent: (ToListNodeHolderDeselectedEvent new holder: self; yourself) ]
]

{ #category : 'selection - handling' }
ToListNodeHolder >> whenDeselectEvent: anEvent [

	(anEvent indexes includes: self position) ifFalse: [ ^ self ].
	self selected: false
]

{ #category : 'selection - handling' }
ToListNodeHolder >> whenSelectEvent: anEvent [

	(anEvent indexes includes: self position) ifFalse: [ ^ self ].
	self selected: true
]
