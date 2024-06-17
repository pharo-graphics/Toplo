Class {
	#name : #ToListFrontSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'beneath'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListFrontSelectionElement class >> beneath: aBoolean [

	^ self new beneath: aBoolean
]

{ #category : #accessing }
ToListFrontSelectionElement >> beneath [

	^ beneath
]

{ #category : #accessing }
ToListFrontSelectionElement >> beneath: aBoolean [

	beneath := aBoolean
]

{ #category : #initialization }
ToListFrontSelectionElement >> initialize [ 

	super initialize.
	beneath := true
]

{ #category : #accessing }
ToListFrontSelectionElement >> option [

	^ beneath
		  ifTrue: [ listElement selectionMode beneathOption ]
		  ifFalse: [ listElement selectionMode overOption ]
]

{ #category : #accessing }
ToListFrontSelectionElement >> selectionMode [

	^ self subclassResponsibility 
]

{ #category : #private }
ToListFrontSelectionElement >> updateListElement [

	" a SelectionElement can already added "
	self hasParent ifTrue: [ ^ self ].
	
	beneath
		ifTrue: [ listElement addBeneathSelectionElement: self ]
		ifFalse: [ listElement addOverSelectionElement: self ]
]
