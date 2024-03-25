Class {
	#name : #ToSingleSelectStrategy,
	#superclass : #ToSelectStrategy,
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #accessing }
ToSingleSelectStrategy >> headerNodeContainerClass [

	^ ToSingleSelectHeaderNodeContainerElement
]

{ #category : #'api - hooks' }
ToSingleSelectStrategy >> onInstalledIn: aSelect [

	aSelect listElement selectionMode: (ToListSingleSelectionMode new
			 operator: ToPrimarySelectionModelOperator new;
			 selectionModel: aSelect listElement selectionModel;
			 yourself).
	super onInstalledIn: aSelect
]
