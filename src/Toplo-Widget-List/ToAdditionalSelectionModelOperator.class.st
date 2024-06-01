Class {
	#name : #ToAdditionalSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#instVars : [
		'eventClass'
	],
	#category : #'Toplo-Widget-List-Command-Operator'
}

{ #category : #accessing }
ToAdditionalSelectionModelOperator >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToAdditionalSelectionModelOperator >> eventClass: anEventClass [

	eventClass := anEventClass
]

{ #category : #'private command application' }
ToAdditionalSelectionModelOperator >> notifySelectionChangedAfter: aCommand [

	aCommand selectionChanged ifFalse: [ ^ self ].

	aCommand target dispatchEvent: (self eventClass new
			 selectionModel: aCommand selectionModel;
			 yourself)
]
