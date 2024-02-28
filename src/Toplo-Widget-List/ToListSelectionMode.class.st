Class {
	#name : #ToListSelectionMode,
	#superclass : #ToListAbstractSelectionMode,
	#instVars : [
		'preserveSelectionOnFocused',
		'operator'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListSelectionMode >> initialize [ 

	super initialize.
	preserveSelectionOnFocused := true
]

{ #category : #'event handling' }
ToListSelectionMode >> onClickEvent: anEvent onNode: aNode [

	| listElement |
	listElement := aNode holder listElement.
	listElement dispatchEvent:
		(ToListClickOnNodePreNotificationEvent new
			 sourceEvent: anEvent;
			 node: aNode;
			 yourself)
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	operator onInstalledIn: anElement.
	selecter operator: operator
]

{ #category : #'api - hooks' }
ToListSelectionMode >> onUninstalledIn: anElement [

	operator onUninstalledIn: anElement.
	super onUninstalledIn: anElement. 

]

{ #category : #accessing }
ToListSelectionMode >> operator [

	^ operator
]

{ #category : #accessing }
ToListSelectionMode >> operator: aSelectionOperator [

	operator := aSelectionOperator
]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused [

	^ preserveSelectionOnFocused
]

{ #category : #accessing }
ToListSelectionMode >> preserveSelectionOnFocused: aBoolean [

	preserveSelectionOnFocused := aBoolean
]
