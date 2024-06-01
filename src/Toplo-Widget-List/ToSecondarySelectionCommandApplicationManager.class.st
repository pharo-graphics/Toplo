Class {
	#name : #ToSecondarySelectionCommandApplicationManager,
	#superclass : #ToSelectionCommandApplicationManager,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private command application' }
ToSecondarySelectionCommandApplicationManager >> notifyCommandApplied: aCommand inOperator: anOperator [

	aCommand target dispatchEvent:
		(ToListSecondarySelectionChangedEvent new
			 selectionModel: aCommand selectionModel;
			 yourself)
]
