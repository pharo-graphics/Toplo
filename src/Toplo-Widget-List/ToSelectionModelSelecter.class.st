Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #Object,
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'operator',
		'target'
	],
	#category : #'Toplo-Widget-List-Selection-Updater'
}

{ #category : #'event dispatching' }
ToSelectionModelSelecter >> apply [

	self operator applyOn: self target
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAll [

	self operator deselectAll
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAllIndexes: anArray [

	self operator deselectAllIndexes: anArray
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectIndex: anIndex [

	self operator deselectIndex: anIndex
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator [

	^ operator
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAll [

	self operator selectAll
]

{ #category : #operations }
ToSelectionModelSelecter >> selectAllIndexes: anArray [

	self operator selectAllIndexes: anArray
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: anIndex [

	self operator selectIndex: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectIndex: aStartIndex to: anEndIndex [

	self operator selectIndex: aStartIndex to: anEndIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndex: anIndex [

	self operator selectOnlyIndex: anIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> selectOnlyIndexes: anArray [

	self operator selectOnlyIndexes: anArray
]

{ #category : #accessing }
ToSelectionModelSelecter >> target [

	^ target
]

{ #category : #accessing }
ToSelectionModelSelecter >> target: anEventTarget [

	target := anEventTarget
]
