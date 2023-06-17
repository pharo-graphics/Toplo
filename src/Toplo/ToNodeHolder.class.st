Class {
	#name : #ToNodeHolder,
	#superclass : #OBlInfiniteHolder,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'data',
		'eventDispatcher',
		'clickHandler',
		'deselectHandler',
		'selectHandler'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #accessing }
ToNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToNodeHolder >> data: aData [ 

	data := aData.
	self node: (infiniteElement nodeFactory cull: aData cull: self)
]

{ #category : #'event management accessing' }
ToNodeHolder >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToNodeHolder >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #accessing }
ToNodeHolder >> isSelected [

	^ self infiniteElement isSelectedAtIndex: self position
]

{ #category : #accessing }
ToNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #accessing }
ToNodeHolder >> onAttachedFromDatasource: aDataSource [

	clickHandler := BlEventHandler
		                on: ToClickOnNodeEvent
		                do: [ :event |
		                infiniteElement whenClickOnNodeEvent: event ].

	deselectHandler := BlEventHandler
		                   on: ToSelectionModelDeselectEvent
		                   do: [ :event |
		                   self whenDeselectEvent: event ].

	selectHandler := BlEventHandler
		                 on: ToSelectionModelSelectEvent
		                 do: [ :event | self whenSelectEvent: event ].

	self addEventHandler: clickHandler.
	infiniteElement primarySelection addEventHandler: deselectHandler.
	infiniteElement primarySelection addEventHandler: selectHandler.

	" when holder is attached it can be already selected (as an example with a selectAll) "
	"Selection must be preserved "
	self isSelected ifFalse: [ ^ self ].
	self selected: true
]

{ #category : #accessing }
ToNodeHolder >> onDetachedFromDatasource: aDataSource [

	itemElement undress.	
	self removeEventHandler: clickHandler.
	infiniteElement primarySelection removeEventHandler: deselectHandler.
	infiniteElement primarySelection removeEventHandler: selectHandler.
	
	clickHandler := nil.
	deselectHandler := nil.
	selectHandler := nil

]

{ #category : #accessing }
ToNodeHolder >> selected: aBoolean [

	aBoolean
		ifTrue: [ self node dispatchEvent: (ToNodeHolderSelectedEvent new holder: self; yourself) ]
		ifFalse: [ self node dispatchEvent: (ToNodeHolderDeselectedEvent new holder: self; yourself) ]
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenDeselectEvent: anEvent [

	(anEvent indexes includes: self position) ifFalse: [ ^ self ].
	self selected: false
]

{ #category : #'selection - handling' }
ToNodeHolder >> whenSelectEvent: anEvent [

	(anEvent indexes includes: self position) ifFalse: [ ^ self ].
	self selected: true
]
