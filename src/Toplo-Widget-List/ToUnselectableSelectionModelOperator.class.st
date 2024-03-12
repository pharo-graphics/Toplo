Class {
	#name : #ToUnselectableSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToUnselectableSelectionModelOperator >> listScrollCommand: aCommand in: aTarget [
	" nothing to do "

	
]

{ #category : #'private command application' }
ToUnselectableSelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aTarget notifyUnselectableSelectionChanged:
		(ToListUnselectableSelectionChangedEvent new
			 selectionModel: self selectionModel copy;
			 yourself)
]
