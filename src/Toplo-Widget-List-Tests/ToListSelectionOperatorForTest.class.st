Class {
	#name : #ToListSelectionOperatorForTest,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TToListSelectionOperator',
	#classTraits : 'TBlEventTarget classTrait + TToListSelectionOperator classTrait',
	#instVars : [
		'selectionModel',
		'eventDispatcher',
		'selectionStrategy',
		'successfulCommand'
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
	self selectionStrategy: ToListSelectionStrategy new.
	self selectionStrategy mode: ToListMultiSelectionMode new.
	selectionModel := BlCompositeSelection new.
]

{ #category : #'t - list selection operator - event dispatching' }
ToListSelectionOperatorForTest >> onSelectionRequestSuccess: aSelectionRequestEvent [

	self successfulCommand: aSelectionRequestEvent command
]

{ #category : #accessing }
ToListSelectionOperatorForTest >> selectionHasChanged [

	^ selectionStrategy selectionHasChanged
]

{ #category : #'t - list selection operator - accessing' }
ToListSelectionOperatorForTest >> selectionModel [

	^ selectionModel 
]

{ #category : #accessing }
ToListSelectionOperatorForTest >> selectionStrategy [

	^ selectionStrategy
]

{ #category : #accessing }
ToListSelectionOperatorForTest >> selectionStrategy: aToListSelectionStrategy [

	selectionStrategy ifNotNil: [ self uninstallStrategy: selectionStrategy ].
	selectionStrategy := aToListSelectionStrategy.
	selectionStrategy ifNotNil: [ self installStrategy: selectionStrategy ].

]

{ #category : #'t - list selection operator - event dispatching' }
ToListSelectionOperatorForTest >> successfulCommand [

	^ successfulCommand
]

{ #category : #'t - list selection operator - event dispatching' }
ToListSelectionOperatorForTest >> successfulCommand: anObject [

	successfulCommand := anObject
]
