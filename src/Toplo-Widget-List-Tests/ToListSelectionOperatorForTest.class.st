Class {
	#name : #ToListSelectionOperatorForTest,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToListSelectionOperator',
	#classTraits : 'TBlEventTarget classTrait + TToListSelectionOperator classTrait',
	#instVars : [
		'selectionModel',
		'eventDispatcher',
		'selectionStrategy'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Command'
}

{ #category : #'t - list selection operator - accessing' }
ToListSelectionOperatorForTest >> dataSource [

	^ 1 to: 1000
]

{ #category : #'event management accessing' }
ToListSelectionOperatorForTest >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'t - list selection operator - accessing' }
ToListSelectionOperatorForTest >> eventTarget [

	^ self  
]

{ #category : #initialization }
ToListSelectionOperatorForTest >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	selectionStrategy := ToListSelectionStrategy new.
	selectionStrategy mode: ToListMultiSelectionMode new.
	self installStrategy: selectionStrategy.
	selectionModel := BlCompositeSelection new.
]

{ #category : #'t - list selection operator - accessing' }
ToListSelectionOperatorForTest >> selectionModel [

	^ selectionModel 
]
