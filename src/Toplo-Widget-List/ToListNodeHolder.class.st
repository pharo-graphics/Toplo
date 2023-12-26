Class {
	#name : #ToListNodeHolder,
	#superclass : #BlInfiniteHolder,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'data',
		'eventDispatcher',
		'clickHandler'
	],
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #accessing }
ToListNodeHolder >> data [

	^ data
]

{ #category : #accessing }
ToListNodeHolder >> data: aData [ 

	data := aData.
	self node: infiniteElement nodeClass new.
	infiniteElement nodeBuilder value: self node value: self
]

{ #category : #'event management accessing' }
ToListNodeHolder >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToListNodeHolder >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #accessing }
ToListNodeHolder >> isSelected [

	^ self infiniteElement isSelectedAtIndex: self position
]

{ #category : #accessing }
ToListNodeHolder >> node [

	^ self itemElement 
]

{ #category : #accessing }
ToListNodeHolder >> node: aNode [

	itemElement := aNode
]

{ #category : #accessing }
ToListNodeHolder >> onAttachedFromDatasource: aDataSource [

	clickHandler := BlEventHandler
		                on: ToClickOnListNodeEvent
		                do: [ :event | infiniteElement onClickOnNodeEvent: event ].
	self addEventHandler: clickHandler.
	" Selection model: when holder is attached the hold data can be selected 
	( example: selectAll -> the selection model select all indexes ) "
	self selected: self isSelected
]

{ #category : #accessing }
ToListNodeHolder >> onDetachedFromDatasource: aDataSource [

	self removeEventHandler: clickHandler.	
	clickHandler := nil
]

{ #category : #accessing }
ToListNodeHolder >> selected: aBoolean [

	aBoolean
		ifTrue: [
			self node dispatchEvent: (ToListNodeHolderSelectedEvent new
					 holder: self;
					 yourself) ]
		ifFalse: [
			self node dispatchEvent: (ToListNodeHolderDeselectedEvent new
					 holder: self;
					 yourself) ]
]

{ #category : #'selection - handling' }
ToListNodeHolder >> whenDeselectEvent: anEvent [

	(anEvent indexes includes: self position) ifFalse: [ ^ self ].
	self selected: false
]

{ #category : #'selection - handling' }
ToListNodeHolder >> whenSelectEvent: anEvent [

	(anEvent indexes includes: self position) ifFalse: [ ^ self ].
	self selected: true
]
