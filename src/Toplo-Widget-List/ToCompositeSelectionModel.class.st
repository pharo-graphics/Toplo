Class {
	#name : #ToCompositeSelectionModel,
	#superclass : #ToUnderlyingSelectionModel,
	#instVars : [
		'selection'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #comparing }
ToCompositeSelectionModel >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ self selection = anObject selection
]

{ #category : #'api - testing' }
ToCompositeSelectionModel >> containsIndex: anIndex [

	^ selection containsIndex: anIndex
]

{ #category : #'accessing selection' }
ToCompositeSelectionModel >> deselect: aFromTextIndex to: aToTextIndex [

	selection deselect: aFromTextIndex to: aToTextIndex
]

{ #category : #'accessing selection' }
ToCompositeSelectionModel >> deselectIndex: anIndex [

	selection deselectIndex: anIndex
]

{ #category : #comparing }
ToCompositeSelectionModel >> hash [

	^ self class hash bitXor: self selection hash
]

{ #category : #initialization }
ToCompositeSelectionModel >> initialize [ 

	super initialize.
	selection := BlCompositeSelection new
]

{ #category : #testing }
ToCompositeSelectionModel >> isCompositeSelectionModel [ 

	^ true
]

{ #category : #testing }
ToCompositeSelectionModel >> isEmpty [

	^ selection isEmpty
]

{ #category : #copying }
ToCompositeSelectionModel >> postCopy [ 

	super postCopy.
	selection := selection copy
]

{ #category : #'accessing selection' }
ToCompositeSelectionModel >> select: fromIndex to: toIndex [

	selection select: fromIndex to: toIndex
]

{ #category : #'accessing selection' }
ToCompositeSelectionModel >> selectIndex: anIndex [

	selection selectIndex: anIndex
]

{ #category : #accessing }
ToCompositeSelectionModel >> selectedIndexesAmong: anInteger [

	^ selection indices
]

{ #category : #enumerating }
ToCompositeSelectionModel >> selectedIndexesCollect: aBlock among: anItemCount [

	^ self selection indicesCollect: aBlock
]

{ #category : #accessing }
ToCompositeSelectionModel >> selectedIndexesCountAmong: anInteger [

	| count |
	count := 0.
	selection do: [ :s | count := count + s interval size - 1 ].
	^ count
]

{ #category : #enumerating }
ToCompositeSelectionModel >> selectedIndexesDo: aBlock among: anItemCount [

	self selection indicesDo: aBlock
]

{ #category : #accessing }
ToCompositeSelectionModel >> selection [

	^ selection
]

{ #category : #accessing }
ToCompositeSelectionModel >> selection: aSelection [

	selection := aSelection
]
