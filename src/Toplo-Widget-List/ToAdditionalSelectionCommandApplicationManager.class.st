Class {
	#name : #ToAdditionalSelectionCommandApplicationManager,
	#superclass : #ToSelectionCommandApplicationManager,
	#instVars : [
		'eventClass'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private command application' }
ToAdditionalSelectionCommandApplicationManager >> eventClass [ 

	^ eventClass
]

{ #category : #'private command application' }
ToAdditionalSelectionCommandApplicationManager >> eventClass: anEventClass [

	eventClass := anEventClass
]

{ #category : #'private command application' }
ToAdditionalSelectionCommandApplicationManager >> notifyCommandApplied: aCommand inOperator: anOperator [

	previousModel = aCommand selectionModel ifTrue: [ ^ self ].
	aCommand target dispatchEvent: (self eventClass new
			 selectionModel: aCommand selectionModel;
			 yourself)
]
