Class {
	#name : #ToAdditionalSelectionModelOperator,
	#superclass : #ToSelectionModelOperator,
	#instVars : [
		'eventClass'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #accessing }
ToAdditionalSelectionModelOperator class >> eventClass: anEventClass [

	^ self new eventClass: anEventClass
]

{ #category : #accessing }
ToAdditionalSelectionModelOperator >> eventClass [

	^ eventClass
]

{ #category : #accessing }
ToAdditionalSelectionModelOperator >> eventClass: anEventClass [

	eventClass := anEventClass
]

{ #category : #'private command application' }
ToAdditionalSelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	aCommand selectionChanged ifFalse: [ ^ self ].

	aTarget dispatchEvent: (self eventClass new
			 selectionModel: self selectionModel;
			 yourself)
]
