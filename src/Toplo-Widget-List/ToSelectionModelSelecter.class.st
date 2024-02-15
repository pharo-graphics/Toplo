Class {
	#name : #ToSelectionModelSelecter,
	#superclass : #ToAbstractSelectionModelSelecter,
	#instVars : [
		'operator'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToSelectionModelSelecter >> beSilentWhile: aBlock [ 

	self operator beSilentWhile: aBlock 
]

{ #category : #accessing }
ToSelectionModelSelecter >> currentIndex [ 

	^ self operator currentIndex
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAll [

	self operator addCommand: (ToWholeSelectionCommand new
			 operation: ToRemoveSelectionOperation new;
			 yourself)
]

{ #category : #operations }
ToSelectionModelSelecter >> deselectAllIndexes: anArray [

	self operator addCommand: (ToIndexesSelectionCommand new
			 indexes: anArray;
			 operation: ToRemoveSelectionOperation new)
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	operator := ToSelectionModelOperator new.
	operator onInstalledIn: anEventTarget
]

{ #category : #'api - hooks' }
ToSelectionModelSelecter >> onUninstalledIn: anEventTarget [

	super onUninstalledIn: anEventTarget.
	operator onUninstalledIn: anEventTarget.
	operator := nil
]

{ #category : #accessing }
ToSelectionModelSelecter >> operator [

	^ operator
]
