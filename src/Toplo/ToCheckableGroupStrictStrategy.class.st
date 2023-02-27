Class {
	#name : #ToCheckableGroupStrictStrategy,
	#superclass : #ToCheckableGroupCheckingStrategy,
	#category : #'Toplo-Widget-Button'
}

{ #category : #testing }
ToCheckableGroupStrictStrategy >> canSwitchToNextState: aCheckable [

	^ aCheckable isUnchecked 
]
