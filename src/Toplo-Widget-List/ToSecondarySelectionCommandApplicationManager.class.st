Class {
	#name : #ToSecondarySelectionCommandApplicationManager,
	#superclass : #ToSelectionCommandApplicationManager,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToSecondarySelectionCommandApplicationManager >> notifyCommandApplied: aCommand withOperator: anOperator [

	aCommand target dispatchEvent:
		(ToListSecondarySelectionChangedEvent new
			 selectionModel: aCommand selectionModel;
			 yourself)
]
