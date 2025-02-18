Class {
	#name : #ToListSecondarySelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListSecondarySelectionMode >> defaultSelectionOption [

	^ ToListSelectionOption new
		  grouped: false;
		  beneath: true;
		  elementFactory: [
			  ToListSecondarySelectionElement new ]
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

{ #category : #testing }
ToListSecondarySelectionMode >> isSecondary [ 

	^ true
]

{ #category : #accessing }
ToListSecondarySelectionMode >> multiple: aBoolean [

	multiple = aBoolean ifTrue: [ ^ self ].
	multiple := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter multiple: aBoolean
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelecter [

	^ ToSecondarySelecter new
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelectionModelIn: aListElement [

	^ aListElement selectionModel newSecondarySelectionModel
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> selectionChangedEventClass [ 

	^ ToListSecondarySelectionChangedEvent
]
