Class {
	#name : #ToCompositeSelecter,
	#superclass : #ToListElementSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToCompositeSelecter class >> selectionModel: aSelectionModel operator: anOperator [

	^ self new
		  selectionModel: aSelectionModel;
		  operator: anOperator;
		  yourself
]

{ #category : #'instance creation' }
ToCompositeSelecter >> newOperator [ 

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToCompositeSelecter >> newSelectionModelInElement: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToCompositeSelecter >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	operator := self newOperator.
	operator onInstalledIn: anElement.
	selectionModel := self newSelectionModelInElement: anElement.
	selectionModel onInstalledIn: anElement
]

{ #category : #'api - hooks' }
ToCompositeSelecter >> onUninstalledIn: anElement [

	operator onUninstalledIn: anElement.
	operator := nil.
	selectionModel onUninstalledIn: anElement.
	selectionModel := nil.
	super onUninstalledIn: anElement.
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterIndex [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterWithId: anUniqueId [

	^ self subSelecterIndex  at: anUniqueId ifAbsent: [  ]
]
