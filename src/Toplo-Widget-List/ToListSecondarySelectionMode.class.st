Class {
	#name : #ToListSecondarySelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListSecondarySelectionMode >> defaultElementBuilder [

	^ [ ToListSecondarySelectionElement new ]
]

{ #category : #initialization }
ToListSecondarySelectionMode >> defaultOption [

	^ (ToListSelectionOption grouped)
		  beneath: true;
		  yourself
]

{ #category : #initialization }
ToListSecondarySelectionMode >> initialize [

	super initialize.
	multiple := true
]

{ #category : #testing }
ToListSecondarySelectionMode >> isMultipleSelection [

	^ multiple
]

{ #category : #initialization }
ToListSecondarySelectionMode >> listEventHandlerClass [

	^ ToListSecondarySelectionElementEventHandler 
]

{ #category : #accessing }
ToListSecondarySelectionMode >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter multiple: aBoolean
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newListEventHandler [

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelecter [

	^ ToSecondarySelecter new
		  selectionChangedEventClass: self selectionChangedEventClass;
		  yourself
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelectionModelIn: aListElement [

	^ aListElement newSecondarySelectionModel 
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> selectionChangedEventClass [ 

	^ ToListSecondarySelectionChangedEvent
]
