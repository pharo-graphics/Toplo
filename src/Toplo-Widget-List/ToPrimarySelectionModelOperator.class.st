Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aTarget dispatchEvent: (ToPrimarySelectionCommandAppliedEvent new
			 operator: self;
			 command: aCommand).

	aTarget notifyPrimarySelectionChanged:
		(ToListPrimarySelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]
