Class {
	#name : #ToListSecondarySelectionMode,
	#superclass : #ToAbstractListSelectionMode,
	#instVars : [
		'multiple'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToListSecondarySelectionMode >> initialize [

	super initialize.
	multiple := true.
	option := ToListSelectionElementOption new.
	option
		grouped: true;
		beneath: true;
		elementFactory: [
			ToListBasicSelectionElement new defaultSkin:
					ToListSecondarySelectionElementSkin new ]
]

{ #category : #testing }
ToListSecondarySelectionMode >> isMultipleSelection [

	^ multiple
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
		  selectionChangedEventClass: self selectionChangedEventClass;
		  selectionModel:
			  listElement selectionModel newSecondarySelectionModel;
		  yourself
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelectionChangeEventHandler [ 

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #initialization }
ToListSecondarySelectionMode >> on: aListElement [

	super on: aListElement.
	aListElement addEventHandler: self newSelectionChangeEventHandler 
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> selectionChangedEventClass [ 

	^ ToListSecondarySelectionChangedEvent
]
