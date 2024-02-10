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
ToCompositeSelectionModel >> deleteAndMoveFrom: aStartIndex to: aStopIndex among: anItemCount [

	| from to over gap |
	from := aStartIndex min: aStopIndex.
	to := aStartIndex max: aStopIndex.
	selection selections delete:
		(BlMonotoneSelection from: from - 1 to: to).
	to > anItemCount ifTrue: [ ^ self ].
	over := selection selections findOverlapping:
		        (BlMonotoneSelection from: to to: anItemCount).
	selection selections delete:
		(BlMonotoneSelection from: to - 1 to: anItemCount).
	gap := to - from + 1.
	over do: [ :o |
		selection selections insert:
			(BlMonotoneSelection from: o selection from - gap to: o selection to - gap) ]
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

{ #category : #'accessing selection' }
ToCompositeSelectionModel >> move: aGap from: anIndex [

	
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

{ #category : #'accessing selection' }
ToCompositeSelectionModel >> shift: aGap from: aStartIndex among: anItemCount [

	| from to prev |
	aGap isZero ifTrue: [ ^ self ].
	aGap < 0 ifTrue: [ ^ self deleteAndMoveFrom: aStartIndex + aGap + 1 to: aStartIndex among: anItemCount ].	
	from := aStartIndex.
	to := aStartIndex + aGap.
	prev := selection copy.
	selection selections delete: (BlMonotoneSelection from: from - 1 to: anItemCount).
	prev indices do: [ :idx |
		idx >= aStartIndex ifTrue: [ selection selectIndex: idx+ aGap ] ]
]
