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

{ #category : #'command application' }
ToAdditionalSelectionCommandApplicationManager >> notifyCommandApplied: aCommand withOperator: anOperator [

	aCommand target dispatchEvent: (self eventClass new
			 selectionModel: aCommand selectionModel;
			 yourself)
]
