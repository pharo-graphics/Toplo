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
	selectionElementOption := ToListSelectionElementOption new.
	selectionElementOption
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
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelectionChangedEventHandler [ 

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> newSelectionModel [

	^ listElement selectionModel newSecondarySelectionModel
]

{ #category : #'instance creation' }
ToListSecondarySelectionMode >> selectionChangedEventClass [ 

	^ ToListSecondarySelectionChangedEvent
]

{ #category : #initialization }
ToListSecondarySelectionMode >> selectionElementOption [

	^ ToListSelectionElementOption new
		  grouped: true;
		  beneath: true;
		  elementFactory: [
			  ToListBasicSelectionElement new defaultSkin:
					  ToListSecondarySelectionElementSkin new ]
]
