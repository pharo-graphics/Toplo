Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToCompositeSelecter,
	#instVars : [
		'primarySelecter'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'command application' }
ToSecondarySelecter >> commandApplied: aCommand [ 

	eventTarget dispatchEvent:
		(ToListSecondarySelectionChangedEvent new
			 selectionModel: aCommand selectionModel;
			 yourself)
]

{ #category : #accessing }
ToSecondarySelecter >> primarySelecter: aPrimarySelecter [

	primarySelecter := aPrimarySelecter 
]

{ #category : #accessing }
ToSecondarySelecter >> subSelecterIndex [

	^ primarySelecter subSelecterIndex
]
