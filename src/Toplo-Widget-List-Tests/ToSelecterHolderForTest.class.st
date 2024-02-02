Class {
	#name : #ToSelecterHolderForTest,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'selectionModel',
		'eventDispatcher',
		'selectionStrategy',
		'dataSource',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #accessing }
ToSelecterHolderForTest >> dataSource [

	^ dataSource
]

{ #category : #accessing }
ToSelecterHolderForTest >> dataSource: aDataSource [

	dataSource := aDataSource 
]

{ #category : #'event management accessing' }
ToSelecterHolderForTest >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToSelecterHolderForTest >> initialize [

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	dataSource := #(  ).
	self selectionStrategy: ToListSelectionStrategy new.
	self selectionStrategy mode: ToListMultiSelectionMode new.
	selectionModel := BlCompositeSelection new.
	selecter := ToListElementSelecter on: self
]

{ #category : #accessing }
ToSelecterHolderForTest >> selecter [ 

	^ selecter
]

{ #category : #accessing }
ToSelecterHolderForTest >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToSelecterHolderForTest >> selectionStrategy [

	^ selectionStrategy
]

{ #category : #accessing }
ToSelecterHolderForTest >> selectionStrategy: aSelectionStrategy [

	selectionStrategy := aSelectionStrategy 
]
