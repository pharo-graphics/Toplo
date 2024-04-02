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

{ #category : #accessing }
ToCompositeSelecter >> subSelecterIndex [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterWithId: anUniqueId [

	^ self subSelecterIndex  at: anUniqueId ifAbsent: [  ]
]
